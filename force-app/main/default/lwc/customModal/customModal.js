import { LightningElement,api,track } from 'lwc';

export default class CustomModal extends LightningElement {
  @api closelLabel = 'close';
  @api saveLabel = 'save'; 
  @api saveName; 
  @api closeLinkname;
  @api saveLinkname;
  @api hideSaveButton = false; 
  @api hideCancelButton = false; 
  @api hideCloseButton = false;
  @api hideFooter = false;
  @api hideHeader = false; 
  @api modalHeader; 
  @api modalSubHeader;
  @api modalWidth = 100;
  @track label;
  @api saveButtonVariant = "brand";
  @api closeButtonVariant = "neutral";
  @api isOverflowVisible;
  @api disableModalUpdate;
  @track modalBodyClass;
  @api headerStyle = "slds-text-heading_medium slds-hyphenate";
  @api subHeaderStyle = "slds-text-align_center slds-text-color_weak";
  @api isModalLarger = false;
  @api iconName = "utility:check";
  @api iconClose = "utility:clear";

  clickHandlerForSaveRequest(event) {
    this.iconName = "utility:spinner";
    this.dispatchEvent(
      new CustomEvent("save", {
        detail: {
          buttonName: this.saveName
        }
      })
    );
  }
  clickHandlerForCloseRequest(event) {
    this.dispatchEvent(
      new CustomEvent("close", {
        detail: {
          buttonName: event.target.label
        }
      })
    );
  }
  get modalWidthValue() {
    return `max-width:${this.modalWidth}vh; ${this.isModalLarger ? "height:95%;" : ""}`;
  }
  get sectionHeight() {
    return this.isModalLarger ? "height:95%;" : "";
  }
  get modalClasses() {
    if (this.isModalLarger != null && this.isModalLarger === true) {
      return "slds-modal slds-fade-in-open slds-modal_medium";
    }
    return "slds-modal slds-fade-in-open";
  }
  connectedCallback() {
    if (this.isOverflowVisible) {
      this.modalBodyClass = "overflow:visible;";
    }
  }

  @api
  get headerClass() {
    return this.hideHeader ? "slds-modal__header slds-modal__header_empty" : "slds-modal__header";
  }

  @api
  disableSaveButton() {
    this.disableModalUpdate = true;
  }

  @api
  enableSaveButton() {
    this.disableModalUpdate = false;
  }
}