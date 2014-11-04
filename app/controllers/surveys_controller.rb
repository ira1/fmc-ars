class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:respondentid, :birth_year, :age, :age_group, :experience_group, :hours_group, :member_pro, :member_music_org, :genre_group_1, :money_genre_group_1, :pie_song, :pie_salary, :pie_live, :pie_record, :pie_session, :pie_merch, :pie_teach, :pie_other, :compose_inc_direction, :salary_inc_direction, :perform_inc_direction, :record_inc_direction, :session_inc_direction, :merch_inc_direction, :teach_inc_direction, :rev_youtube, :rev_webads, :rev_fanfund, :rev_fanclub, :rev_persona, :rev_endorse, :rev_acting, :rev_corp, :rev_sample, :rev_honoraria, :rev_grants, :rev_produce, :rev_pubadvance, :ascaplus, :aarc, :afm_2, :afm_srsp, :afm_aftra, :aftra_csp, :label_settle, :music_inc_share_pct, :income_strata, :income_strata_group, :emi, :full_time, :seasoning_group, :path_group, :role_composer, :role_recording, :role_performer, :role_session, :role_teacher, :freq_commercial_radio, :freq_noncommercial_radio, :freq_internet_radio, :freq_satellite_radio, :freq_cable_radio, :comfort_net_produce, :comfort_net_promote, :comfort_net_distribute, :comfort_net_collaborate, :comfort_net_fanconnect, :gender, :gender_group, :edu_level_group, :music_school, :zip, :credits_compositions_life, :credits_recordings_life, :shows_last_year, :credits_sessions_life, :batch, :latitude, :longitude)
    end
end
