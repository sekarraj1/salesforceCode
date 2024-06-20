import { LightningElement } from 'lwc';
import getCountryList from '@salesforce/apex/CalloutWithPublicUrl.getCountryList'

export default class CountryList extends LightningElement {

  columns =[{label:'Country Code',fieldName:'countryCode',type:'text'},
            {label:'Country',fieldName:'country',type:'text'},
            {label:'Region',fieldName:'region',type:'text'}
            ];

  tableData =[];
  showDataTable = false;

  connectedCallback(){
    getCountryList().then(result=>{
      let countryResponse = JSON.parse(result);
      this.parseCountryResponse(countryResponse);
    }).catch((error)=>{
      console.log('error'+JSON.stringify(error));
    });

    this.useFetchLWCmethod();
  }

  useFetchLWCmethod(){
    fetch('https://api.first.org/data/v1/countries', {
      method: "GET"
    }).then((response) => response.json())
      .then(repos => {
          console.log(JSON.stringify(repos));  
      });
  }

  async useFetchLWCmethod1() {
    const response = await fetch('http://example.com/items.json');
    const movies = await response.json();
    console.log(movies);
  }


  parseCountryResponse(countryResponse){
    let countryList;
    for(const countryCode in countryResponse.data){ 
      countryList ={
        country: countryResponse.data[countryCode].country,
        region: countryResponse.data[countryCode].region,
        countryCode: countryCode
      };
      
      this.tableData.push(countryList);
    }
    if(this.tableData.length > 0){
      this.showDataTable = true;
    }
  }
}