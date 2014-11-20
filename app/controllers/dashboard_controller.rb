class DashboardController < ApplicationController
  def show

    @sample = Survey

    # TODO Protect from SQL injection attack/sanitize params
    
    #
    # TODO Test for version=1.0
    #
    
    
    ################### FILTERS ###################
    
    #
    # Main-$ genre facet (MGenre)
    #
    @mgenre = (params.has_key?(:mgenre)) ? params[:mgenre] : "ALL"
    if @mgenre != "ALL"
        @sample = @sample.where(:genre_group_1 => params[:mgenre] )
    end

    #
    #  if musician_type param is set assign/override the role parameter appropriately
    #
    if params.has_key?(:musician_type)
      # TODO make this more resilient against typos in param values
      params[:role_session] = params[:role_performer] = params[:role_salaried] = params[:role_recording] = params[:role_composer]= "false"
      case params[:musician_type]
      when "COMPOSER"
        params[:role_composer] = "true"
      #      @sample = @sample.where(role_composer: true)
      when "RECORDING"
        params[:role_recording] = "true"
        #      @sample = @sample.where(role_recording: true)      
      when "SALARIED"
        params[:role_salaried] = "true"
        #      @sample = @sample.where(role_salaried: true)
      when "PERFORMER"
        params[:role_performer] = "true"
        #      @sample = @sample.where(role_performer: true)
      when "SESSION"
        params[:role_session] = "true"
        #      @sample = @sample.where(role_session: true)
        #else
        #single_mode = false;
      end    
    end
    
    #
    #
    #  ProcessRole parameters 
    #
    facetroles=0
    roleclause=""
    #if ("true"==params[:role_missing]) then 
    #     roleclause = "(role_composer is null AND role_recording is null AND role_salaried is null AND role_performer is null AND role_session is null)"
    #     facetroles+=1
    #end
    if ( "true"==params[:role_composer] ) then 
      if 0!=facetroles
        roleclause += " OR role_composer=true"
      else
        roleclause = "role_composer=true"
      end
      facetroles+=1
      #@role_composer=true
    end
    if ( "true"==params[:role_recording] ) then 
       if 0!=facetroles
         roleclause = roleclause + " OR role_recording=true" 
       else
         roleclause = "role_recording=true"
       end
       facetroles+=1
      #@role_recording=true
    end
    if ( "true"==params[:role_salaried] ) then 
       if 0!=facetroles
         roleclause = roleclause + " OR role_salaried=true" 
       else
         roleclause = "role_salaried=true"
       end
       facetroles+=1
      #@role_salaried=true
    end
    if ( "true"==params[:role_performer] ) then 
       if 0!=facetroles
         roleclause = roleclause + " OR role_performer=true" 
       else
         roleclause = "role_performer=true"
       end
       facetroles+=1
      #@role_performer=true
    end
    if ("true"==params[:role_session]) then 
       if 0!=facetroles
         roleclause = roleclause + " OR role_session=true" 
       else
         roleclause = "role_session=true"
       end
       facetroles+=1
      #@role_session=true
    end
    if 0<facetroles then
        @sample = @sample.where(roleclause)
    end
    #
    #
    # Career Level facet
    #
    @careerexp = params.has_key?(:careerexp) ? params[:careerexp] : "ALL"
    #logger.info{"careerexp #{params.has_key?(:careerexp)} and is #{@careerexp}"}
    case @careerexp
    when  "1" 
      @sample = @sample.where("experience_group < 4")
    when "2"
      @sample = @sample.where("experience_group > 3 and experience_group < 7")
    when "3"
      @sample = @sample.where("experience_group > 6")
    end
    
    #
    # Full time? (may contain nulls)
    #
    if "true"==params[:ft] then
      @sample = @sample.where("full_time = true")
    end
    
    #
    # Went to music school or conservatory
    #
    if "true"==params[:trained] then
      @sample = @sample.where("music_school = true")
    end
    
    #
    # Gender one of M,F,T or null
    #
    genderclause=""
    if params.has_key?(:gender_male) && "true"==params[:gender_male] then
      genderclause << "gender_group = 'M'"
    end
    if params.has_key?(:gender_female) && "true"==params[:gender_female] then
      if genderclause.length > 0 then
        genderclause << " OR "
      end
      genderclause << "gender_group = 'F'"
    end
    if params.has_key?(:gender_transgender) && "true"==params[:gender_transgender] then
      if genderclause.length > 0 then
        genderclause << " OR "
      end
      genderclause << "gender_group = 'T'"
    end
    if params.has_key?(:gender_unanswered) && "true"==params[:gender_unanswered] then
      if genderclause.length > 0 then
        genderclause << " OR "
      end
      genderclause << "gender_group is null or gender_group =''"
    end
    
    if genderclause.length > 0 then
      @sample = @sample.where(genderclause)
    end
    
    #
    # TODO EMI filter
    #
    
    #################### Outputs ######################
    
    #
    # Shared by all Outputs
    #
    @NCount = @sample.count
    
    #
    # AnnInc 
    # TODO Refactor into AnnInc method & Model
    #
    @AvgEMI = @sample.average(:emi)
    @EMISampleSize = @sample.count(:emi)
    @AvgEMI ||= 0 # if nil (or false) set to 0
    
    #
    #  TODO Refactor into FTClaim method & Model
    #
    @sample_size = @sample.count()
    numerator = @sample.where(:full_time => true).count()
    if @sample_size != 0 
      @pctfulltime = 100 * numerator / @sample_size
    else
      @pctfulltime = 0
    end
    
    #
    #  TODO Refactor into AboutGroupClaim method
    #
    # experience_group should have no nulls
     @AboutPctExperienced = 100*@sample.where("experience_group > 3").count/@sample.count
     #
     @AboutCompositionsNCount = @sample.count(:credits_compositions_life)
     @AboutCompositionsPctAnswered = (0==@NCount) ? 0 : (100 * @AboutCompositionsNCount / @NCount)
     @AboutPctOver50Compositions = (0==@AboutCompositionsNCount) ? 0 :100*@sample.where("credits_compositions_life > 1").count/@AboutCompositionsNCount
     #
     @AboutRecordingsNCount = @sample.count(:credits_recordings_life)
     @AboutRecordingsPctAnswered = (0==@NCount) ? 0 : (100 * @AboutRecordingsNCount / @NCount)
     @AboutPctOver50Recordings = (0==@AboutRecordingsNCount) ? 0 : 100*@sample.where("credits_recordings_life > 1").count/@AboutRecordingsNCount
     #
     @AboutShowsNCount = @sample.count(:shows_last_year)
     @AboutShowsPctAnswered = (0==@NCount) ? 0 : (100 * @AboutShowsNCount / @NCount)
     @AboutPctOver50Shows = (0==@AboutShowsNCount) ? 0 : 100*@sample.where("shows_last_year > 1").count/@AboutShowsNCount
  end
end
