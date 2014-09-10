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
      messages.forEach(function(message){
        var rowView = new MessageRowView(message);
        var rowHtml = rowView.render();
        // this.displayHtml(rowHtml);
        $("#messages-table").append(rowHtml);
      }.bind(this));
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
