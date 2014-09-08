get '/messages' do
  if current_user
    @messages = current_user.received_messages.order(sent_at: :desc)
    @contacts = current_user.contacts
  else
    redirect '/sessions/new'
  end
    erb :layout_sidebar do
      erb :"messages/index"
    end
end

get '/messages/:message_id' do
  @message = Message.find(params[:message_id])
  if current_user == @message.receiver
    @message.update(viewed_at: DateTime.now)
    erb :"messages/show"
  else
    redirect '/sessions/new', layout: :non_user_layout
  end
end
