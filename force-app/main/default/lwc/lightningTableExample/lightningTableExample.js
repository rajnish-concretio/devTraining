import { LightningElement,track } from 'lwc';

export default class LightningTableExample extends LightningElement {

    name = 'Rajnish Kumar';
    title = 'Developer';

    changeHandler(event){
        this.title = event.target.value;
    }
    @track address ={
        City: "Delhi",
        Postal: 100092,
        Country: "India"
    }
    changeCityHandler(event){
        this.address.City = event.target.value;
    }

    users = ['Ally','Tom','Nik'];
    get getUser(){
       return this.users[0]; 
    }
    num1 = 10;
    num2 = 20;

    get getAddition(){
        return this.num1 + this.num2;
    }
}