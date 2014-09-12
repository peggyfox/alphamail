function MessageDetailView(message) {
  this.message = message;
  this.template = _.template($("#message-detail-template").html());
}

MessageDetailView.prototype.render = function() {
  return $(this.template(this.templateData()));
}

MessageDetailView.prototype.templateData = function() {
  return {
    id: this.message.id,
    from_email: this.message.from_email,
    subject: this.message.subject,
    sent_at: this.displaySentAt(this.message.sent_at),
    body: this.message.body,
  };
}

MessageDetailView.prototype.displaySentAt = function(sent_at) {
  var sent = new Date (sent_at)
  var now = new Date (Date.now())
  if (sent.toDateString() === now.toDateString()) {
    return sent.toLocaleTimeString();
  }
  else {
    return sent.toDateString();
  }
}

