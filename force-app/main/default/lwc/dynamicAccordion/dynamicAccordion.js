// cardManagement.js
import { LightningElement, api } from 'lwc';

const jsonData = {
  "quiz": {
    "sport": [
      {
        "question": "Which one is correct team name in NBA?",
        "options": [
          "New York Bulls",
          "Los Angeles Kings",
          "Golden State Warriros",
          "Huston Rocket"
        ],
        "answer": "Huston Rocket"
      }
    ],
    "maths": [
      {
        "question": "5 + 7 = ?",
        "options": [
          "10",
          "11",
          "12",
          "13"
        ],
        "answer": "12"
      },
      {
        "question": "12 - 8 = ?",
        "options": [
          "1",
          "2",
          "3",
          "4"
        ],
        "answer": "4"
      }
    ]
  }
};

export default class DynamicAccordion extends LightningElement {
  showSection = false; 
  showTable = false; 
  @api cards = [
        {
            name: 'Iphone 15 (256GB)',
            label: 'Iphone 15 (256GB)',
            caseId:{
              header :'Iphone 15 (256GB)'
            },
            data: [
                {
                    id: 1,
                    name: 'Paypal Debit Card **4627',
                    token: '82648234524',
                    status: 'Active',
                    limit: '$1,200',
                    isDefault: true,
                    TrendIcon: 'utility:down',
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
                },
            ],
        },
        {
            name: 'Samsung S24 (256GB)',
            label: 'Samsung S24 (256GB)',
            caseId:{
              header :'Iphone 15 (256GB)'
            },
            data: [
                // Add Samsung S24 cards data here
            ],
        },
        {
            name: 'Iphone 14 Pro (256GB)',
            label: 'Iphone 14 Pro (256GB)',
            caseId:{
              header :'Iphone 15 (256GB)'
            },
            data: [
              {
                id: 1,
                name: 'Paypal Debit Card **4327',
                token: '82648234524',
                status: 'Active',
                limit: '$1,200',
                isDefault: true,
            }
            ],
        },
    ];

    columns1 = [{label:'Questions',fieldName:'questions',type:'text'},
    {label:'Answers',fieldName:'answers',type:'text'}
    ];

    @api columns = [
        {
            label: 'Card Name',
            fieldName: 'name',
            type: 'text',
            sortable: false,
            wrapText : false,
            cellAttributes: {
              iconName: { fieldName: 'TrendIcon' },
              iconPosition: 'right',
              class:{fieldName:'accountColor'}
          },
        },
        {
            label: 'Token',
            fieldName: 'token',
            type: 'text',
            sortable: false,
            wrapText : false,
            cellAttributes: {
              iconName: 'utility:event',
              iconAlternativeText: 'Close Date',
          },
        },
        {
            label: 'Status',
            fieldName: 'status',
            sortable: false,
            wrapText : false,
            type: 'text', cellAttributes: {
              class: { fieldName: 'statusClass' }
          }
        },
        {
            label: 'NFC Limit',
            fieldName: 'limit',
            type: 'text',
            sortable: false,
            wrapText : false,
        },
        {
            type: 'action',
            typeAttributes: {
                rowActions: [
                    {
                        label: 'Edit',
                        name: 'edit',
                    },
                    {
                        label: 'Delete',
                        name: 'delete',
                    },
                ],
            },
        },
    ];

    get dataValue() {
      return this.cards?.data?.map(row => {
          row.statusClass = row.status === 'Active' ? 'lds-text-color_success' : 'lds-text-color_success';
          return row;
      });
  }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        console.log('row'+JSON.stringify(row));
        if (actionName === 'edit') {
            // Handle edit logic here
        } else if (actionName === 'delete') {
            // Handle delete logic here
        }
    }

    handleLockTapToPay() {
        // Handle lock tap to pay logic here
    }

    handleClick(){
      this.showSection = true;
    }

    tableQuizData = [];
    
    connectedCallback(){
      if(this.cards?.data){
        this.showTable = true;
        this.tableData = this.cards?.data.map(item=>{
          let accountColor = "slds-text-color_error";
          let fd = {...item, "accountColor":accountColor}
          return {...cards, fd}
      })
    }
    let data;
    if (typeof jsonData === 'string') {
      data = JSON.parse(jsonData);
    } else {
      data = jsonData;
    }
    
    // 2. Loop through the quiz categories (sport, maths)
    for (const category of Object.keys(data.quiz)) {
      console.log(`Category: ${category}`);
    let sd;
      // 3. Loop through each question in the category
      for (const question of data.quiz[category]) {
        console.log(question.question);
        for (const option of question.options) {
          console.log(option);
        }
        sd= {
          questions:question.question,
          answers:question.answer
        };
        console.log(`Answer: ${question.answer}`);
        console.log("----------");
        this.tableQuizData.push(sd);
      }
      
    }

    }

}
