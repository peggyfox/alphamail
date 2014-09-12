var App = {
  start_session: function() {
    this.$container = $("#content");
    this.allMessages();
    $('#inbox').click(function(event){
      this.allMessages();
    }.bind(this));
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
  },

  loginStart: function(){
    this.$container = $("#content");
    var formView = new SessionFormView();
    var formHtml = formView.render();
    this.displayHtml(formHtml);
    $("#sign-in").submit(function( event ) {
      event.preventDefault();
      var action = $(this).attr('action');
      var data = $(this).serialize();
      $.post(action, data).done(function(){
        App.start_session();
      });
    });

  },


}

$(document).ready(function(){
  $.get("/sessions").done(function(in_session){
    console.log(in_session);
    if(in_session){
      App.start_session();
    }
    else{
      App.loginStart();
    }
  });
});
