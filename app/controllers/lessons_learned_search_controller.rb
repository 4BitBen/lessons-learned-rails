class LessonsLearnedSearchController < ApplicationController
  # GET /lessons_learned_search
  # GET /lessons_learned_search.json
  def index
    rsolr = RSolr.connect :url => 'http://localhost:8983/solr/collection1'
    @lessons_learned_search = rsolr.select(:params => { :q=>params[:search], :hl=>true})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons_learned_search }
    end
  end
end
