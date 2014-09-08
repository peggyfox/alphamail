get '/contacts' do
  if current_user
    @contacts = current_user.contacts
    erb :"contacts/index"
  else
    redirect '/sessions/new'
  end
end

get '/contacts/new' do
  if current_user
    @contact = Contact.new
    erb :"contacts/new"
  else
    redirect "/sessions/new"
  end
end

post '/contacts' do
  if current_user
    @contact = current_user.contacts.create(params[:contact])
    redirect "/contacts"
  else
    redirect "/sessions/new"
  end
end

get '/contacts/:contact_id' do
  @contact = Contact.find(params[:contact_id])
  if current_user == @contact.user
    erb :"contacts/show"
  else
    redirect "/sessions/new"
  end
end

get '/contacts/:contact_id/edit' do
  @contact = Contact.find(params[:contact_id])
  if current_user == @contact.user
    erb :"contacts/edit"
  else
    redirect "/sessions/new"
  end
end

put '/contacts/:contact_id' do
  @contact = Contact.find(params[:contact_id])
  if current_user == @contact.user
    @contact.update(params[:contact])
    redirect "/contacts"
  else
    redirect "/sessions/new"
  end
end

delete '/contacts/:contact_id' do
  @contact = Contact.find(params[:contact_id])
  if current_user == @contact.user
    @contact.destroy
    redirect "/contacts"
  else
    redirect "/sessions/new"
  end
end



