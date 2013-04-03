class LessonLearnedsController < ApplicationController

  def initialize
      @rsolr = RSolr.connect :url => 'http://localhost:8983/solr/collection1'
  end

  # GET /lesson_learneds
  # GET /lesson_learneds.json
  def index
    @lesson_learneds = LessonLearned.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lesson_learneds }
    end
  end

  # GET /lesson_learneds/1
  # GET /lesson_learneds/1.json
  def show
    @lesson_learned = LessonLearned.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson_learned }
    end
  end

  # GET /lesson_learneds/new
  # GET /lesson_learneds/new.json
  def new
    @lesson_learned = LessonLearned.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson_learned }
    end
  end

  # GET /lesson_learneds/1/edit
  def edit
    @lesson_learned = LessonLearned.find(params[:id])
  end

  # POST /lesson_learneds
  # POST /lesson_learneds.json
  def create
    @lesson_learned = LessonLearned.new(params[:lesson_learned])

    respond_to do |format|
      if @lesson_learned.save

        # Now index it in Solr
        @rsolr.add(:id=>@lesson_learned.id,
                   :lesson_date=>@lesson_learned.lessonDate.to_s + 'T00:00:00Z',
                   :project_reference=>@lesson_learned.projectReference,
                   :project_engineer=>@lesson_learned.projectEngineer,
                   :project_architect=>@lesson_learned.projectArchitect,
                   :project_owner=>@lesson_learned.projectOwner,
                   :division=>@lesson_learned.division,
                   :text=>@lesson_learned.input)
        @rsolr.commit

        format.html { redirect_to @lesson_learned, notice: 'Lesson learned was successfully created.' }
        format.json { render json: @lesson_learned, status: :created, location: @lesson_learned }
      else
        format.html { render action: "new" }
        format.json { render json: @lesson_learned.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lesson_learneds/1
  # PUT /lesson_learneds/1.json
  def update
    @lesson_learned = LessonLearned.find(params[:id])

    respond_to do |format|
      if @lesson_learned.update_attributes(params[:lesson_learned])
        # Now index it in Solr
        @rsolr.add(:id=>@lesson_learned.id,
                   :lesson_date=>@lesson_learned.lessonDate.to_s + 'T00:00:00Z',
                   :project_reference=>@lesson_learned.projectReference,
                   :project_engineer=>@lesson_learned.projectEngineer,
                   :project_architect=>@lesson_learned.projectArchitect,
                   :project_owner=>@lesson_learned.projectOwner,
                   :division=>@lesson_learned.division,
                   :text=>@lesson_learned.input)
        @rsolr.commit

        format.html { redirect_to @lesson_learned, notice: 'Lesson learned was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson_learned.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_learneds/1
  # DELETE /lesson_learneds/1.json
  def destroy
    @lesson_learned = LessonLearned.find(params[:id])
    @lesson_learned.destroy

    # Now remove it from Solr
    @rsolr.delete_by_id(@lesson_learned.id)
    @rsolr.commit

    respond_to do |format|
      format.html { redirect_to lesson_learneds_url }
      format.json { head :no_content }
    end
  end
end
