import { LightningElement,wire } from 'lwc';
import getSprintTasksDetails from '@salesforce/apex/sprintTaskController.getSprintTasks';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const actions = [
  { label: 'Show details', name: 'show_details' },
  { label: 'Update', name: 'update' },
];
const columns = [
  { label: 'Employee Name', fieldName: 'Employee_Name__c', editable: true },
  { label: 'Sprint', fieldName: 'Name', type: 'text', editable: true },
  { label: 'Leave Date', fieldName: 'Leave_Date_if_any__c', type: 'text', editable: true },
  { label: 'Timesheet filled', fieldName: 'Is_TimeSheet_filled_Check__c', type: 'text'},
  { label: 'Description', fieldName: 'Tesct__c', type: 'text', editable: true },
  { type:'action',typeAttributes: { rowActions: actions }}
];

export default class SprintTaskDataTable extends LightningElement {
  sprintData = [];
    columns = columns;
    rowOffset = 0;
    showModal = false;
    showSpinner = false;
    recordId;
    wiredSprintResult;
    formats = [
      'font',
      'size',
      'bold',
      'italic',
      'underline',
      'strike',
      'list',
      'indent',
      'align',
      'link',
      'image',
      'clean',
      'table',
      'header',
      'color',
  ];

  get checkDataLength(){
    return this.sprintData.length>0 ? true : false;
  }

  @wire(getSprintTasksDetails)
  wiredSprint(result) {
        this.wiredSprintResult = result;
        if (result.data) {
            this.sprintData = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.sprintData = undefined;
        }
    }

    get checkRecordId(){
      return this.recordId;
    }

    handleRowAction(event){
      const actionName = event.detail.action.name;
        const row = event.detail.row;
        this.recordId = row.Id;
        if(this.recordId){
          this.showSpinner = false;
        }
        if(actionName === 'update'){
          this.showSpinner = true;
            console.log('Display Modal'+JSON.stringify(row));
            this.showModal = true;
        }
    }

    handleSubmit(event){
       // event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    handleSuccess(){
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Updated",
          message:"Updated",
          variant:"success"
        })
      );
      this.showModal = false;
      refreshApex(this.wiredSprintResult);
    }

    closeModalHandler(event){
      this.showModal = false;
    }
}