class SurveytestsController < ApplicationController
  before_action :set_surveytest, only: [:show, :edit, :update, :destroy]

  # GET /surveytests
  # GET /surveytests.json
  def index
    @surveytests = Surveytest.all
  end

  # GET /surveytests/1
  # GET /surveytests/1.json
  def show
  end

  # GET /surveytests/new
  def new
    @surveytest = Surveytest.new
  end

  # GET /surveytests/1/edit
  def edit
  end

  # POST /surveytests
  # POST /surveytests.json
  def create
    @surveytest = Surveytest.new(surveytest_params)

    respond_to do |format|
      if @surveytest.save
        format.html { redirect_to @surveytest, notice: 'Surveytest was successfully created.' }
        format.json { render :show, status: :created, location: @surveytest }
      else
        format.html { render :new }
        format.json { render json: @surveytest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveytests/1
  # PATCH/PUT /surveytests/1.json
  def update
    respond_to do |format|
      if @surveytest.update(surveytest_params)
        format.html { redirect_to @surveytest, notice: 'Surveytest was successfully updated.' }
        format.json { render :show, status: :ok, location: @surveytest }
      else
        format.html { render :edit }
        format.json { render json: @surveytest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveytests/1
  # DELETE /surveytests/1.json
  def destroy
    @surveytest.destroy
    respond_to do |format|
      format.html { redirect_to surveytests_url, notice: 'Surveytest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_surveytest
      @surveytest = Surveytest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def surveytest_params
      params.require(:surveytest).permit(:respondentid, :age, :age_group, :experience_group, :hours_group, :integer, :member_pro, :member_music_org, :genre_group_1, :money_genre_group_1, :pie_song, :integer, :pie_salary, :pie_live, :pie_record, :pie_session, :pie_merch, :pie_teach, :pie_other, :compose_inc_direction, :salary_inc_direction, :perform_inc_direction, :record_inc_direction, :session_inc_direction, :merch_inc_direction, :teach_inc_direction, :rev_youtube, :rev_webads, :rev_fanfund, :rev_fanclub, :rev_persona, :rev_endorse, :rev_acting, :rev_corp, :rev_sample, :rev_honoraria, :rev_grants, :rev_produce, :rev_pubadvance, :ascaplus, :aarc, :afm_2, :afm_srsp, :afm_aftra, :aftra_csp, :label_settle, :music_inc_share_pct, :income_strata, :income_strata_group, :emi, :full_time, :seasoning_group, :path_group, :role_compose, :role_record, :role_perform, :role_session, :role_teach, :freq_commercial_radio, :freq_noncommercial_radio, :freq_internet_radio, :freq_satellite_radio, :freq_cable_radio, :comfort_net_produce, :comfort_net_promote, :comfort_net_distribute, :comfort_net_collaborate, :comfort_net_fanconnect, :gender, :gender_group, :edu_level_group, :music_school, :zip, :credits_compose_life, :credits_record_life, :credits_show_life, :credits_session_life, :shows_last_year)
    end
end
