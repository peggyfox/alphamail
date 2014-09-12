function SessionFormView() {
  this.template = _.template($("#session-template").html());
}

SessionFormView.prototype.render = function() {
  return $(this.template());
}
