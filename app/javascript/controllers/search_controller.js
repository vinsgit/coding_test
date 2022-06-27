import { Controller } from "@hotwired/stimulus"
import Fuse from "fuse.js"
export default class extends Controller {
  static targets = ["name"]

  typeIn() {
    this.getContacts()
  }

  constructTable(data) {
    const list = data
    const cols = $("#contactsTable th")
    $('#contactsTable tbody').empty();
    $('.pagination').hide();
    // Traversing the JSON data
    for (let i = 0; i < list.length; i++) {
      let row = $("<tr/>");
      for (let colIndex = 0; colIndex < cols.length; colIndex++) {
        let colName = $(cols[colIndex]).data('type');
        let val = list[i]['item'][colName];
        row.append($('<td/>').html(val));
      }
      // Adding each row to the table
      $('#contactsTable tbody').append(row);
    }
  }

  fuseSearch(responseJSON) {
    // define options
    const options = {
      includeScore: true,
      useExtendedSearch: true,
      keys: ['name']
    }
    const fuse = new Fuse(responseJSON, options)
    const result = fuse.search(this.name)
    this.constructTable(result)   
  }

  async getContacts() {
    return await fetch("/contacts/search?" + "name=" + this.name)
      .then(data => data.json())
      .then(responseJSON => {
        this.fuseSearch(responseJSON)
      }).catch((error) => { console.error(error) })
  }

  get name() {
    return this.nameTarget.value
  }
}



