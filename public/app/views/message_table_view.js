function MessageTableView(messages){
  this.messages = messages;
  this.template = _.template($("#message-table-template").html());
}

MessageTableView.prototype.render = function(){
  var $element = $(this.template());
  this.messages.forEach(function(message){
    var rowView = new MessageRowView(message);
    var rowHtml = rowView.render();
    $element.find("tbody").append(rowHtml);
  }.bind(this));
  debugger
  return $element;
}