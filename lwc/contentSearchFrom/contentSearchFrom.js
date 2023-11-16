import { LightningElement} from 'lwc';
import LWCRestMethod from '@salesforce/apex/LWCContentController.LWCRestMethod';

export default class ContentSearchFrom extends LightningElement {
    searchText = '';
    //@wire(LWCRestMethod)
    //LWCRestMethod;

    contentChangeHandler(event) {
        this.searchText = event.target.value;
    }

   searchClickHandler() {
        const event = new CustomEvent('searchcontent', { detail: this.searchText });
        this.dispatchEvent(event);
      //console.debug('search content');
    }

  loadClickHandler(){
    //this.clickedButtonLabel = event.target.value;
    LWCRestMethod();
    console.log('Content saved successfully');
  }
}
