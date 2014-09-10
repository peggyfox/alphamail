function Message(options){
  this.id = options.id;
  this.to_email = options.to_email;
  this.receiver_id = options.receiver_id;
  this.from_email = options.from_email;
  this.subject = options.subject;
  this.body = options.body;
  this.sent_at = options.sent_at;
  this.viewed_at = options.viewed_at;
  this.dbc_id = options.dbc_id;
}

Message.all = function() {
  return $.get("/messages").pipe(function(json_messages){
    return json_messages.map(function(json_message){
      return new Message(json_message);
    });
  });
}

Message.find = function(id) {
  return $.get("/messages/"+id).pipe(function(json_message){
    return new Message(json_message);
  });
}
