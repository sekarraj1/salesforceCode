import { LightningElement } from 'lwc';
import getCountryList from '@salesforce/apex/CalloutWithPublicUrl.getCountryList';
import getAssessmentDetails from '@salesforce/apex/AssessmentOutputTestController.getCompDetails';

export default class CountryList extends LightningElement {

  columns =[{label:'Country Code',fieldName:'countryCode',type:'text'},
            {label:'Country',fieldName:'country',type:'text'},
            {label:'Region',fieldName:'region',type:'text'}
            ];
            columns1 =[{label:'Bom PN',fieldName:'BoMPN',type:'text'},
            {label:'Bom Qty',fieldName:'BoMQty',type:'text'},
            {label:'Disti PN',fieldName:'DistiPN',type:'text'},
            {label:'Disti Qty',fieldName:'DistiQty',type:'text'},
            {label:'Error Flag',fieldName:'ErrorFlag',type:'text'}
            ];
  

  tableData =[];
  assesData=[];
  showDataTable = false;
  showassesData = false;

  connectedCallback(){
    getCountryList().then(result=>{
      let countryResponse = JSON.parse(result);
      this.parseCountryResponse(countryResponse);
    }).catch((error)=>{
      console.log('error'+JSON.stringify(error));
    });
    this.assessmentMethod();
    //this.useFetchLWCmethod();
  }

  assessmentMethod(){
    getAssessmentDetails().then(result=>{
      let outPutResult = JSON.parse(result);
      console.log('result>>>'+typeof result);
      console.log('result'+JSON.stringify(result));
      this.setOutputTable(outPutResult);
    });
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

  

  setOutputTable(res){
    let dataList;
    for(let i=0;i<res.length;i++){
      dataList={
        "BoMPN": res[i].bom_pn,
        "BoMQty":res[i].bom_qty,
        "DistiPN":res[i].Disti_pn,
        "DistiQty":res[i].Disti_qty,
        "ErrorFlag":res[i].Error_Flag
      }
      this.assesData.push(dataList);
    }
    if(this.assesData.length>0){
      this.showassesData = true;
    }
    
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