import { LightningElement, wire , track } from 'lwc';
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext
} from 'lightning/messageService';
import viewContentDetailChannel from '@salesforce/messageChannel/viewContentDetailChannel__c';
import getContentDetail from '@salesforce/apex/LWCContentController.getContentDetail';

// Mardown 
import { loadScript } from 'lightning/platformResourceLoader';
import MARKED_JS from '@salesforce/resourceUrl/marked';


export default class ContentDetail extends LightningElement {
    subscription = null;
    contents = [];
    @wire(MessageContext)
    messageContext;
    title = 'Content Detail';
    _body = '';

    connectedCallback() {
        this.subscribeToMessageChannel();
        
    }

    async getContentDetail() {
     
        const data = await getContentDetail({ id: this.id });
         this.contents = data;
       
    }
      // Encapsulate logic for Lightning message service subscribe and unsubsubscribe
      subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                viewContentDetailChannel,
                (data) => this.handleContentSelection(data),
                { scope: APPLICATION_SCOPE }
            );
        }
    }
    handleContentSelection(data) {
        
        this.id = data.id;
        this.getContentDetail();
    
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    @track body;

    handleBodyChange(event) {
        this.body = event.target.value;
        
    }

}
