import { LightningElement,api } from 'lwc';
const columns = [
  { label: 'Token', fieldName: 'token' },
  { label: 'Tap to Pay', fieldName: 'tapToPay' },
  { label: 'NFC Limit', fieldName: 'nfcLimit' },
  { label: 'Actions', type: 'action', fieldName: 'actions' }
];

export default class DataTableAccordion extends LightningElement {
  columns =columns;
  @api cdata1 = [{
    id: 1,
    name: 'Paypal Debit Card **4627',
    token: '82648234524',
    status: 'Active',
    limit: '$1,200',
    isDefault: true,
},
{
    id: 2,
    name: 'Paypal Debit Card **4627',
    token: '92648234534',
    status: 'Locked',
    limit: '$1,200',
    isDefault: false,
},
{
    id: 3,
    name: 'Paypal Debit Card **4627',
    token: '67648234541',
    status: 'Active',
    limit: '$1,200',
    isDefault: false,
}];

  handleClick(event) {
    const sectionId = event.detail.sectionId;
    this.cdata1 = this.cdata1.map(item => ({
      ...item,
      isOpen: item.id === sectionId ? !item.id : false
    }));
  }
}