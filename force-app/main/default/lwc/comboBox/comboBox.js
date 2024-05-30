import { LightningElement, api, track } from 'lwc';

export default class ComboBox extends LightningElement {
  @api selectedValue;
	@api selectedLabel;
	@api label = "Country";
	@api minChar = 2;
  @api isRequired = false;
  @api placeholderText = "Please select the Options";

  isSearchStringEmpty = true;
  isValid = true;
	ICON_URL = "/apexpages/slds/latest/assets/icons/{0}-sprite/svg/symbols.svg#{1}";
  requiredFieldMsg = "Field is Required";
  showDropdown = false;
  HideOptions = "Hide Options";
  RemoveSelectedOption = "Remove Selected Option";
  ShowOptions = "Display Options";

  @api picklistLabels;
	@api picklistValues;
	@api picklistFirstSupportText;
	@api picklistSecondSupportText;

  @api selectedPicklist;
	@api optionTagMap;
  value;
	@track optionData;
	searchString;

  showOptions(){

  }

  blurEvent(event) {
  }

  handleRemoveSelected(event) {
  }

  showOptions(){

  }
}