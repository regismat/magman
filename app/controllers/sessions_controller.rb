class SessionsController < ApplicationController
    layout 'standard'
  
  def new
    
  end
  
   def user_params
    params.require(:user).permit(:username, :password)
  end
  
  def create 
    user = User.find_by_username(params[:username])
   
      if user && user.authenticate(params[:password]) 
         
         if user.customer
            session[:user_id] = user.id
           redirect_to :controller=>:bookings, :action=>:index
           flash[:notice] = 'Connexion réussie! Bienvenue!'
           
         else
          flash[:notice] ="Veillez contacter le magasinier pour l'activation de votre compte!"
           render "new"
         end  
         
      else
         flash.now.alert = "Erreur: nom d'utilisateur or mot de passe invalide!"
         render "new"
      
      end 
    
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
    
    flash[:notice] = 'Déconnecté!'
  end
end
