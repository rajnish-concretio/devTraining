// accountTable.js
import { LightningElement, wire, track } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import getSObjects from '@salesforce/apex/AccountController.getSObjects';
import getObjectFields from '@salesforce/apex/AccountController.getObjectFields';
import getRecordsByFields from '@salesforce/apex/AccountController.getRecordsByFields';

const columns = [
    { label: 'Record ID', fieldName: 'Id' }
];

let PAGE_SIZE = 5; // Number of records per page

export default class AccountTable extends LightningElement {
    @track selectedFields = [];
    @track accountData = [];
    @track columns = columns;
    @track searchTerm = '';
    @track pageNumber = 1; // Current page number
    @track sobjectOptions = [];
    @track selectedSObject;
    @track fieldOptions = []; // Add fieldOptions property

    originalAccountData = []; // Store original account data

    @wire(getObjectInfo, { objectApiName: '$selectedSObject' })
    objectInfo;

    @wire(getSObjects)
    wiredSObjects({ error, data }) {
        if (data) {
            this.sobjectOptions = data.map(sobject => ({ label: sobject, value: sobject }));
        } else if (error) {
            console.error('Error fetching SObjects', error);
        }
    }

    get pageSize() {
        return PAGE_SIZE;
    }

    get isPreviousDisabled() {
        return this.pageNumber === 1;
    }

    get isNextDisabled() {
        return this.pageNumber >= Math.ceil(this.accountData.length / PAGE_SIZE);
    }

    handleFieldSelection(event) {
        this.selectedFields = event.detail.value;
    }

    handleSubmit() {
        if (this.selectedSObject && this.selectedFields.length > 0) {
            getRecordsByFields({ objectName: this.selectedSObject, selectedFieldsName: this.selectedFields })
                .then(result => {
                    this.accountData = result;
                    this.originalAccountData = result; // Store original account data
                    this.columns = this.selectedFields.map(field => ({
                        label: this.objectInfo.data.fields[field].label,
                        fieldName: field
                    }));
                })
                .catch(error => {
                    console.error('Error fetching account data', error);
                });
        }
    }

    handleSearchChange(event) {
        this.searchTerm = event.target.value.toLowerCase();
        if (this.searchTerm === '') {
            this.accountData = this.originalAccountData; // Reset account data to original state
        } else {
            this.filterData();
        }
    }

    filterData() {
        this.accountData = this.originalAccountData.filter(account => {
            return typeof account.Name === 'string' && account.Name.toLowerCase().includes(this.searchTerm);
        });
    }

    handlePageSizeChange(event) {
        PAGE_SIZE = parseInt(event.target.value, 10);
        this.pageNumber = 1; // Reset page number when page size changes
    }

    setPageSize() {
        this.pageNumber = 1; // Reset page number when page size changes
        // Fetch data again based on new page size
        this.handleSubmit();
    }

    previousPage() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
        }
    }

    nextPage() {
        if (this.pageNumber < Math.ceil(this.accountData.length / PAGE_SIZE)) {
            this.pageNumber++;
        }
    }

    get pagedData() {
        const start = (this.pageNumber - 1) * PAGE_SIZE;
        const end = this.pageNumber * PAGE_SIZE;
        return this.accountData.slice(start, end);
    }

    handleSObjectSelection(event) {
        this.selectedSObject = event.detail.value;
        this.selectedFields = []; // Reset selected fields when SObject changes
        this.fieldOptions = []; // Reset fieldOptions when SObject changes
        if (this.selectedSObject) {
            this.loadFields();
        }
    }

    loadFields() {
        getObjectFields({ objectName: this.selectedSObject })
            .then(result => {
                this.fieldOptions = result.map(field => ({ label: field, value: field }));
            })
            .catch(error => {
                console.error('Error fetching object fields', error);
            });
    }
}
