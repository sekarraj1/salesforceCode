import { LightningElement , wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountInfoController.getAccountList';
import getContacts from '@salesforce/apex/ContactInfoController.getContactList';

export default class AccountList extends LightningElement {
  loader = false;
  accounts =[];
  error = '';
  accountStateObject ={
    totalRecords :0,
    recordStart:0,
    recordEnd:0,
    totalPages:0,
    isNext:true,
    isPrev: true,
    pageSize:10,
    pageNumber:3
  };

  @wire(getContacts)contactList({ error, data }){
    if(data){
      console.log('data>>'+JSON.stringify(data));
    }
    if(error){
      console.log('data>>'+JSON.stringify(data));
    }
  }

  connectedCallback(){
    this.getAccounts();
  }

  getAccounts(){
    this.loader = true;
    getAccountList({
      pageSize: this.accountStateObject.pageSize,pageNumber: this.accountStateObject.pageNumber
    }).then(result=>{
      this.loader = false;
      if(result){
        const resultData = JSON.parse(result);
        this.accounts = resultData.accounts;
        this.accountStateObject.pageNumber = resultData.pageNumber;
        this.accountStateObject.totalRecords =  resultData.totalRecords;
        this.accountStateObject.recordStart = resultData.recordStart;
        this.accountStateObject.recordEnd = resultData.recordEnd;
        this.accountStateObject.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
        this.accountStateObject.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
        this.accountStateObject.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);     
      }
    }).catch(error=>{
      this.loader = false;
      this.error = error;
    });
  } 

  handleNext(){
    this.accountStateObject.pageNumber = this.accountStateObject.pageNumber+1;
    this.getAccounts();
  }

  handlePrev(){
    this.accountStateObject.pageNumber = this.accountStateObject.pageNumber-1;
    this.getAccounts();
  }

  get isDisplayNoRecords(){
    let isDisplay = true;
    if(this.accounts){
      if(this.accounts.length == 0){
        isDisplay = true;
      }else{
          isDisplay = false;
      }
    }
    return isDisplay;
  }

}