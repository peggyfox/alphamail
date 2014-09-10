function MessageRowView(message){
  this.message = message;
  // this.$el = $("<tr></tr>");
  this.template = _.template($("#message-row-template").html());
}

MessageRowView.prototype.render = function(){
  // this.$el.html(this.template(this.message));
  return $(this.template(this.templateData()));
}

MessageRowView.prototype.templateData = function() {
  return {
    from_email: this.message.from_email,
    subject: this.message.subject,
    short_body: this.shortenBody(this.message.body),
    sent_at: this.displaySentAt(this.message.sent_at)
  };
}

MessageRowView.prototype.shortenBody = function(body) {
  return body.substr(0, 75);
};

MessageRowView.prototype.displaySentAt = function(sent_at) {
  var sent = new Date (sent_at)
  var now = new Date (Date.now())
  if (sent.toDateString() === now.toDateString()) {
    return sent.toLocaleTimeString();
  }
  else {
    return sent.toDateString();
  }
}

