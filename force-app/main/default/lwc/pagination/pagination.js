// Pagination.js
import { LightningElement, api, track } from 'lwc';
import getRecords from '@salesforce/apex/PaginationController.getRecords';

export default class Pagination extends LightningElement {
    @api objectName; // the name of the object to query
    @api fields; // the fields to display in the table
    @api pageSize; // the number of records per page
    @api sortedBy; // the field to sort by
    @api sortedDirection; // the direction of sorting (asc or desc)

    @track records; // the records to display in the current page
    @track error; // the error message if any
    @track pageNumber = 1; // the current page number
    @track totalPages = 1; // the total number of pages

    // get the offset of the current page
    get offset() {
        return (this.pageNumber - 1) * this.pageSize;
    }

    // get the label for the page information
    get pageLabel() {
        return `Page ${this.pageNumber} of ${this.totalPages}`;
    }

    // get the disable status of the previous button
    get disablePrevious() {
        return this.pageNumber <= 1;
    }

    // get the disable status of the next button
    get disableNext() {
        return this.pageNumber >= this.totalPages;
    }

    // handle the first button click
    handleFirst() {
        this.pageNumber = 1;
        this.fetchRecords();
    }

    // handle the previous button click
    handlePrevious() {
        this.pageNumber--;
        this.fetchRecords();
    }

    // handle the next button click
    handleNext() {
        this.pageNumber++;
        this.fetchRecords();
    }

    // handle the last button click
    handleLast() {
        this.pageNumber = this.totalPages;
        this.fetchRecords();
    }

    // handle the sorting event from the data table
    handleSort(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        this.fetchRecords();
    }

    // fetch the records from the server
    fetchRecords() {
        getRecords({
            objectName: this.objectName,
            fields: this.fields,
            pageSize: this.pageSize,
            offset: this.offset,
            sortedBy: this.sortedBy,
            sortedDirection: this.sortedDirection
        })
            .then(result => {
                this.records = result.records;
                this.totalPages = Math.ceil(result.total / this.pageSize);
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.records = undefined;
            });
    }

    // fetch the records when the component is connected
    connectedCallback() {
        this.fetchRecords();
    }
}
