import { LightningElement } from 'lwc';

export default class ContentSearch extends LightningElement {
    searchText = '';
    searchcontentHandler(event) {
        this.searchText = event.detail;
    }
}
