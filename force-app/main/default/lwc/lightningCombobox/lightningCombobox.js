import { LightningElement,track } from 'lwc';
import getValuesFromTable from "@salesforce/apex/GetLocationDetailsController.getValuesFromTable";
import getStatesFromTable from "@salesforce/apex/GetLocationDetailsController.getStatesFromTable";

export default class LightningCombobox extends LightningElement {
  picklistOrdered;
  searchResults;
  selectedSearchResult;

  value = "";
  countryOptions = [];
  selectedCountry;
  @track stateOptions = [];

handleChange(event) {
	this.value = event.detail.value;
	console.log(this.value);
}
  get selectedValue() {
    return this.selectedSearchResult ? this.selectedSearchResult.label : null;
  }

  connectedCallback() {
    getValuesFromTable().then((result) => {
      result.forEach((row)=>{
        this.countryOptions.push({label:row.Name,value:row.Name});
      });
    })
  }

  handleChange(event){
    this.selectedCountry = event.detail.value;
    this.stateOptions =[];
    this.getStateValues(this.selectedCountry); 
  }

  getStateValues(selectedCountry){
    console.log('selectedCountry>>'+selectedCountry);
    getStatesFromTable().then((result)=>{
      console.log('result>>'+JSON.stringify(result));
      result.forEach((row)=>{
        this.stateOptions.push({label:row.Name,value:row.Name});
      });
    });
  }


  search(event) {
    const input = event.detail.value.toLowerCase();
   
    const result = this.picklistOrdered.filter((picklistOption) =>
      picklistOption.label.toLowerCase().includes(input)
    );
    this.searchResults = result;
  }

  selectSearchResult(event) {
    const selectedValue = event.currentTarget.dataset.value;
    this.selectedSearchResult = this.picklistOrdered.find(
      (picklistOption) => picklistOption.value === selectedValue
    );
    this.clearSearchResults();
  }

  clearSearchResults() {
    this.searchResults = null;
  }

  showPicklistOptions() {
    if (!this.searchResults) {
      this.searchResults = this.picklistOrdered;
    }
  }

}