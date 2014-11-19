class ImpSurveysController < ApplicationController
  before_action :set_imp_survey, only: [:show, :edit, :update, :destroy]

  # GET /imp_surveys
  # GET /imp_surveys.json
  def index
    @imp_surveys = ImpSurvey.all
  end

  # GET /imp_surveys/1
  # GET /imp_surveys/1.json
  def show
  end

  # GET /imp_surveys/new
  def new
    @imp_survey = ImpSurvey.new
  end

  # GET /imp_surveys/1/edit
  def edit
  end

  # POST /imp_surveys
  # POST /imp_surveys.json
  def create
    @imp_survey = ImpSurvey.new(imp_survey_params)

    respond_to do |format|
      if @imp_survey.save
        format.html { redirect_to @imp_survey, notice: 'Imp survey was successfully created.' }
        format.json { render :show, status: :created, location: @imp_survey }
      else
        format.html { render :new }
        format.json { render json: @imp_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imp_surveys/1
  # PATCH/PUT /imp_surveys/1.json
  def update
    respond_to do |format|
      if @imp_survey.update(imp_survey_params)
        format.html { redirect_to @imp_survey, notice: 'Imp survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @imp_survey }
      else
        format.html { render :edit }
        format.json { render json: @imp_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imp_surveys/1
  # DELETE /imp_surveys/1.json
  def destroy
    @imp_survey.destroy
    respond_to do |format|
      format.html { redirect_to imp_surveys_url, notice: 'Imp survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imp_survey
      @imp_survey = ImpSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imp_survey_params
      params.require(:imp_survey).permit(:respondentid, :collectorid, :startdate, :enddate, :completetime, :ipaddress, :consent, :birth_year, :age, :age_group, :citizen, :experience, :experience_group, :hours, :hours_group, :perspective, :ascap, :bmi, :sesac, :soundexchange, :no_pro, :member_pro, :foreign_pro, :afm, :aftra, :agma, :sag, :naras, :songguild, :nsai, :countryma, :acf, :amc, :mtc, :chamberma, :jen, :aaj, :jazzcorner, :ama, :ema, :folkalliance, :jpf, :gma, :ibma, :fracatlas, :napama, :apap, :no_music_org, :member_music_org, :other_music_org, :genre1, :primary_genre_consolidated, :genre_group_1, :genre2, :genre3, :other_genre, :moneygenre1, :moneygenre_consolidated, :money_genre_group_1, :moneygenre2, :cowriter, :band, :producer, :label, :publisher, :bizmanager, :booking, :tourmanager, :soundperson, :roadcrew, :publicist, :fanstreetteam, :webmaster, :graphicdesign, :accountant, :attorney, :other_team_member, :pie_song, :pie_salary, :pie_live, :pie_record, :pie_session, :pie_merch, :pie_teach, :pie_other, :pie_total, :change_song, :compose_inc_direction, :change_salary, :salary_inc_direction, :change_live, :perform_inc_direction, :change_record, :record_inc_direction, :change_session, :session_inc_direction, :change_merch, :merch_inc_direction, :change_teach, :teach_inc_direction, :rev_youtube, :rev_webads, :rev_fanfund, :rev_fanclub, :rev_persona, :rev_endorse, :rev_acting, :rev_corp, :rev_sample, :rev_honoraria, :rev_grants, :rev_produce, :rev_pubadvance, :ascaplus, :aarc, :afm_2, :afm_srsp, :afm_aftra, :aftra_csp, :label_settle, :income, :midrange_income, :music_inc_share_pct, :income_strata, :income_strata_group, :emi, :full_time, :seasoning_group, :path, :path_group, :short_role_music, :short_role_lyrics, :short_role_composer, :short_role_recording, :short_role_record, :short_role_perform_desc, :short_role_perform, :short_role_orchestra_desc, :short_role_orchestra, :short_role_session_desc, :short_role_session, :short_role_teach_desc, :short_role_teach, :short_role_admin_desc, :short_role_admin, :short_moneyrole, :med_moneyrole, :long_composer, :long_recordings, :long_liveperformance, :long_session, :long_teacher, :role_composer, :role_recording, :role_performer, :role_session, :role_teacher, :other_inc_streams, :other_dec_streams, :confirm_perspective, :radio_com, :freq_commercial_radio, :radio_noncom, :freq_noncommercial_radio, :radio_internet, :freq_internet_radio, :radio_satellite, :freq_satellite_radio, :radio_cable, :freq_cable_radio, :web_produce, :comfort_net_produce, :web_promote, :comfort_net_promote, :web_distro, :comfort_net_distribute, :web_collab, :comfort_net_collaborate, :web_fans, :comfort_net_fanconnect, :ableton, :garageband, :digitalperformer, :finale, :logic, :maximuspe, :prop_reason, :prop_record, :pro_tools, :sibelius, :virtual_dj, :other_software, :webblog, :bandcamp, :bandletter, :bandzoogle, :cash_music, :cdbaby, :facebook, :fanbridge, :flickr, :foursquare, :mailchimp, :myspace, :nextbigsound, :nimbit, :reverbnation, :rootmusic, :rumblefish, :songkick, :sonicbids, :soundcloud, :taxi, :topspin, :tumblr, :tunecore, :twitter, :youtube, :other_web_dist, :tech_money, :tech_self, :tech_collab, :tech_fans, :tech_merits, :tech_compete, :tech_promo, :tech_devalue, :tech_piracy, :tech_control, :time_compose, :time_perform, :time_record, :time_collab, :time_session, :time_teach, :time_socnet, :time_manage, :time_account, :time_fundraise, :learn_about_survey, :survey_source, :gender, :gender_group, :race_ethnicity, :education_level, :edu_level_group, :music_school, :music_degree, :specific_degree, :health_ins, :pension, :zip, :msa, :msa_code, :med_compcred12mos, :med_compcredcareer, :med_comp_credits_lifetime, :med_reccred12mos, :med_reccredcareer, :med_recording_credits_lifetime, :med_numshows, :med_shows_12months, :med_sesscred12mos, :med_sesscredcareer, :med_session_credits_lifetime, :long_compcred12mos, :long_compcredcareer, :long_composition_credits_lifetime, :long_reccred12mos, :long_reccredcareer, :long_recording_credits_lifetime, :long_numshows, :long_shows_last_year, :long_sesscred12mos, :long_sesscredcareer, :long_session_credits_lifetime, :credits_compositions_life, :credits_recordings_life, :shows_last_year, :credits_sessions_life)
    end
end
