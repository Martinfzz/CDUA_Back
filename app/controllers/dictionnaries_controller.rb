class DictionnariesController < ApplicationController
  before_action :set_dictionnary, only: [:show, :update, :destroy]
  
  def search
    @dictionnary = Dictionnary.where(title: /.*#{params[:search]}.*/i ).all
    if @dictionnary.length > 0
      render json: @dictionnary
    else
      render json: {message: "No entry founded"}, status: 404
    end
  end

  def index
    @dictionnaries = Dictionnary.all
    render json: @dictionnaries
  end

  def show
    render json: @dictionnary
  end

  def create
    @dictionnary = Dictionnary.new(dictionnary_params)

    if @dictionnary.save
      render json: @dictionnary, status: :created, location: @dictionnary
    else
      render json: @dictionnary.errors, status: :unprocessable_entity
    end
  end

  def update
    if @dictionnary.update(dictionnary_params)
      render json: @dictionnary
    else
      render json: @dictionnary.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @dictionnary.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dictionnary
      @dictionnary = Dictionnary.find(id: BSON::ObjectId.from_string(params[:id]))
    end

    # Only allow a list of trusted parameters through.
    def dictionnary_params
      params.fetch(:dictionnary, {}).permit(:title, :lang, data: [:lang, hits: [roms: [:headword, :headword_full, :wordclass, arabs: [:header, translations: [:source, :target]]]]])
    end
  
end
