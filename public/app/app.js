var App = {
  start: function() {
    this.$container = $("#content");
    this.allMessages();
  },

  displayHtml: function(element) {
    this.$container.html(element);
  },

  allMessages: function() {
    Message.all().done(function(messages){
      var tableView = new MessageTableView(messages);
      var tableHtml = tableView.render();
      this.displayHtml(tableHtml);
    }.bind(this));
  },

  singleMessage: function(id) {
    Message.find(id).done(function(message) {
      var detailView = new MessageDetailView(message);
      var detailHtml = detailView.render();
      this.displayHtml(detailHtml);
    }.bind(this));
  }
}

$(document).ready(function(){
  App.start();
});
