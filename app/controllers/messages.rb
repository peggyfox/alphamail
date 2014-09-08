get '/messages' do
  if current_user
    @messages = current_user.received_messages.order(sent_at: :desc)
    @contacts = current_user.contacts
    erb :layout_sidebar do
      erb :"messages/index"
    end
  else
    redirect '/sessions/new'
  end
end

get '/messages/:message_id' do
  @message = Message.find(params[:message_id])
  if current_user == @message.receiver
    @message.update(viewed_at: DateTime.now)
    erb :layout_sidebar do
      erb :"messages/show"
    end
  else
    redirect '/sessions/new', layout: :non_user_layout
  end
end
