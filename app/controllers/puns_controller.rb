class PunsController < ApplicationController
    attr_accessor :tweet,:is_published,:publication_date,:likes,:retweets ,:tweet_id
    protect_from_forgery unless: -> { request.format.json? }
    # respond_to :html, :xml, :json

    def index
        
        if params[:filter] === 'not published'
            @puns = Pun.all.where(is_published: false).order(:publication_date)
        elsif params[:filter] === 'published'
            @puns = Pun.all.where(is_published: true).order(:publication_date)
        else
            @puns = Pun.all.order(:publication_date)
        end
        
        respond_to do |format|
            # debugger
            format.html
            format.json { render json: @puns, status: 201 }  
        end

    end



    def show
        @pun =Pun.find(params[:id])
    end
    


    def create
        @pun = Pun.create(params[:tweet])
    end

    def publish
        @pun = Pun.find(params[:id])
        @pun.tweet_id = params[:pun][:tweet_id]
        @pun.is_published = true

        if @pun.save
            render json: @pun, status: 201  
        else
            console.log(alert("Oops, couldn't publish the tweet"))
        end
    end

    def update
        @pun = Pun.find(params[:id])
        @pun.tweet = params[:pun][:tweet]
        
        if @pun.save
            redirect_to '/puns/' + params[:id]
         else
            alert("Oops, couldn't update the tweet")
         end

    end



    def destroy
        @pun =Pun.find(params[:id])
        @pun.delete
        redirect_to '/'
    end

end
