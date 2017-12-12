class PagesController < ApplicationController
    def index
        @categories = Category.all
        @items = Item.all
    end
    
    def search
        @search_term = params[:search_term]
    
        # interpolition
        query = "%#{params[:search_term]}%"
    
        @items = Item.where("name like ?", query)
    end
    
    def category
        title = params[:title]
        @items = Item.where("category like ?" , title)
    end
    
    def paymentAccepted
        # here you could clear the cart
        # below the hash allows you to put a variable in a string'
        flash[:notice] = "Payment accepted. Thank you."
        @order = Order.last
        @order.update_attribute(:status, 'Paid')
        
        # remove cart from session
        session[:cart] = nil
    end
end
