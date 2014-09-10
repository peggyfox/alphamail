get '/contacts' do
  if current_user
    @contacts = current_user.contacts
    erb :layout_sidebar do
      erb :"contacts/index"
    end
  else
    redirect '/sessions/new'
  end
end

get '/contacts/new' do
  if current_user
    @contact = Contact.new
    erb :layout_sidebar do
      erb :"contacts/new"
    end
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
    erb :layout_sidebar do
      erb :"contacts/show"
    end
  else
    redirect "/sessions/new"
  end
end

get '/contacts/:contact_id/edit' do
  @contact = Contact.find(params[:contact_id])
  if current_user == @contact.user
    erb :layout_sidebar do
      erb :"contacts/edit"
    end
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



