import { LightningElement,api, wire } from 'lwc';
import getContents from '@salesforce/apex/LWCContentController.getContents';
// Import message service features required for publishing and the message channel
import { publish, MessageContext } from 'lightning/messageService';
import viewContentDetailChannel from '@salesforce/messageChannel/viewContentDetailChannel__c';

const COLUMNS = [
    //{ label: 'Id', fieldName: 'Id' },
    { label: 'Title__c', fieldName: 'Title__c'},
    { label: 'Actions', type: 'button' , typeAttributes:{
        label:'View Content',
        name:'View Content',
        title:'View Content', 
        value:'View_Content',
   
    }},
];

export default class ContentSearchResult extends LightningElement {

    @api searchText
    columns=COLUMNS;
    @wire(getContents,{searchText:"$searchText"})
    contentsList;

    @wire(MessageContext)
    messageContext;

    rowActionHandler(event){
        if(event.detail.action.value=='View_Content'){
           const payload = { id: event.detail.row.Id};
            publish(this.messageContext, viewContentDetailChannel, payload);
        }
    }
}
