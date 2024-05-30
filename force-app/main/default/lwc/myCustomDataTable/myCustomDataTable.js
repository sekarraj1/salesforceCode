import { LightningElement } from 'lwc';
import richTextColumnType from "./richTextColumnType.html";

export default class MyCustomDataTable extends LightningElement {
  static customTypes={
    // custom type definition
    richText: {
        template: richTextColumnType,
        standardCellLayout: true
    }
}
}