class ChapsController < ApplicationController
  before_action :find_story
  before_action :authenticate_user!, except: [:show]

  def show
<<<<<<< HEAD
  	@chap = Chap.find(params[:id]) 
    id_list = @story.chaps.ids.sort
    # # id_list = []
    # # @story.chaps.each do |chap|
    # #   id_list << chap.id
    # # end
    # # id_list.sort! 
    # i = @chap.id
    # # j = id_list.index(i)
    # if i == id_list.last
    #   @next_chap = nil
    # else 
    #   j = id_list.detect{|e| e > i}
    #   @next_chap = Chap.find(j)
    #   # @next_chap = @story.chaps.where(id: i)
    # end

    # if i == id_list.first 
    #   @previous_chap = nil
    # else
    #   j = id_list.detect{|e| e < i}
    #   @previous_chap = Chap.find(j) 
    # end
    @next_chap_id = id_list.detect { |e| e > @chap.id.to_i }
    @previous_chap_id = id_list.reverse.detect{ |e| e < @chap.id}
=======
  	@chap = @story.chaps.find(params[:id])
    # id_list = @story.chaps.where(story_id: @story.id).order(id: :asc)
    id_list = []
    @story.chaps.each do |chap|
      id_list << chap.id
    end
    id_list.sort! 
    i = @chap.id
    j = id_list.index(i)
    if i == id_list.last
      @next_chap = nil
    else 
      i = id_list[j + 1]
      @next_chap = @story.chaps.find(i)
      # @next_chap = @story.chaps.where(id: i)
    end
    i = @chap.id
    if i == id_list.first 
      @previous_chap = nil
    else
      k = id_list[j - 1]
      @previous_chap = @story.chaps.find(k)
    
    end
>>>>>>> 9421f9764320da27ae99f8b12419b88a9addd0ba
  end

  def new
  end

  def create
  	@chap = @story.chaps.create(chap_params)
  	if @chap.save
  	  redirect_to story_chap_path(@story, @chap.id)
  	else
  		render 'new'
  	end
  end

  def edit
  	@chap = @story.chaps.find(params[:id])
  end

  def update
  	@chap = @story.chaps.find(params[:id])
  	if @chap.update(chap_params)
  		redirect_to story_chap_path(@story, @chap.id)
  	else
  		render 'edit'
  	end
  end

  def destroy
    @chap = @story.chaps.find(params[:id])
    @chap.destroy
    redirect_to story_path(@story)
  end

  private
  def find_story
  	@story = Story.find(params[:story_id])
  end

  def chap_params
  	params.require(:chap).permit(:name, :content)
  end
end
