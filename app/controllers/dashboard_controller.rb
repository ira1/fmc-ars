class DashboardController < ApplicationController

  # TODO strip whitespace for length test
  #
  def AppendClauseOr(clause,phrase)
    if 0<clause.length then
      clause << " OR "
    end
    clause << phrase
    return clause
  end
  
  def AppendClauseAnd(clause,phrase)
    if 0<clause.length then
      clause << " AND "
    end
    clause << phrase
    return clause
  end
  
  def show

    @sample = Survey

    # TODO Protect from SQL injection attack/sanitize params
    
    #
    # TODO Test for version=1.0 & changenum
    #
    
    
    ################### FILTERS ###################
    
    #
    #  if musician_type param is set assign/override the role parameter appropriately
    #
    if params.has_key?(:musician_type)
      params[:role_session] = params[:role_performer] = params[:role_salaried] = params[:role_recording] = params[:role_composer]= params[:role_teacher] = "false"
      case params[:musician_type].upcase
      when "COMPOSER"
        params[:role_composer] = "true"
      when "RECORDING"
        params[:role_recording] = "true"
      when "SALARIED"
        params[:role_salaried] = "true"
      when "PERFORMER"
        params[:role_performer] = "true"
      when "SESSION"
        params[:role_session] = "true"
      when "TEACHER"
        params[:role_teacher] = "true"
        #      @sample = @sample.where(role_session: true)
        #else
        #single_mode = false;
      end    
    end
    
    #
    # Main-$ genre facet (MGenre)
    #
    genreincomeOn=false
    @mgenre = (params.has_key?(:mgenre)) ? params[:mgenre].upcase : "ALL"
    if @mgenre != "ALL"
        @sample = @sample.where(:genre_group_1 => params[:mgenre] )
        @sample_antigenre = Survey.where.not(:genre_group_1 => params[:mgenre])
        puts "ANTI-GENRE !!!!!!!!"
        puts @sample_antigenre.count()
        genreincomeOn=true
    end

    #
    #
    #  Process Role parameters 
    #
    rolecount=0
    roleclause=""
    #if ("true"==params[:role_missing]) then 
    #     roleclause = "(role_composer is null AND role_recording is null AND role_salaried is null AND role_performer is null AND role_session is null)"
    #     facetroles+=1
    #end
    if params.has_key?(:roles_exact) && "true"==params[:roles_exact]
      roles_exact=true
    else
      roles_exact=false
    end
    
      if ( params.has_key?(:role_composer) && "true"==params[:role_composer].downcase ) then 
        rolecount += 1
        if roles_exact
          AppendClauseAnd(roleclause,"role_composer=true")
        else
          AppendClauseOr(roleclause,"role_composer=true")
        end
      else
        if roles_exact 
          AppendClauseAnd(roleclause,"role_composer=false")
        end
      end

    if ( params.has_key?(:role_recording) && "true"==params[:role_recording].downcase ) then
      rolecount += 1
      if roles_exact then 
        AppendClauseAnd(roleclause,"role_recording=true")
      else
        AppendClauseOr(roleclause, "role_recording=true")
      end
    else
      if roles_exact
        AppendClauseAnd(roleclause,"role_recording=false")
      end
    end

    if params.has_key?(:role_salaried) && "true"==params[:role_salaried].downcase  then 
      rolecount += 1
      if roles_exact
        AppendClauseAnd(roleclause, "role_salaried=true") 
      else        
        AppendClauseOr(roleclause, "role_salaried=true") 
      end
    else
      if roles_exact
        AppendClauseAnd(roleclause, "role_salaried=false") 
      end
    end

    if params.has_key?(:role_performer) && "true"==params[:role_performer].downcase  then 
      rolecount += 1
      if roles_exact
        AppendClauseAnd(roleclause, "role_performer=true")
      else        
        AppendClauseOr(roleclause, "role_performer=true")
      end
    else
      if roles_exact
        AppendClauseAnd(roleclause, "role_performer=false")
      end
    end

    if params.has_key?(:role_session) && "true"==params[:role_session].downcase then 
      rolecount += 1
      if roles_exact
        AppendClauseAnd(roleclause, "role_session=true")
      else
        AppendClauseOr(roleclause, "role_session=true")
      end
    else
      if roles_exact 
        AppendClauseAnd(roleclause, "role_session=false")
      end
    end

    if params.has_key?(:role_teacher) && "true"==params[:role_teacher].downcase then 
      if roles_exact
        AppendClauseAnd(roleclause, "role_teacher=true")
      else        
        AppendClauseOr(roleclause, "role_teacher=true")
      end
    else
      if roles_exact
        AppendClauseAnd(roleclause, "role_teacher=false")
      end
    end      

    if params.has_key?(:role_other) && "true"==params[:role_other] then
      AppendClauseOr(roleclause, "role_other=true")
    else
      @sample=@sample.where("role_other=false")
      @sample_antigenre = @sample_antigenre.where("role_other=false") if genreincomeOn
    end
    
#
# role_other
#
#    if 0<rolecount then 
#      AppendClauseOr(roleclause, "(role_composer is null and role_recording is null and role_salaried is null and role_performer is null and role_session is null and role_teacher is null)")
#    end 
    if 0<roleclause.length then
      @sample = @sample.where(roleclause)
      @sample_antigenre = @sample_antigenre.where(roleclause) if genreincomeOn
    end
    #
    
    # Career Level facet
    #
    @careerexp = params.has_key?(:careerexp) ? params[:careerexp] : "ALL"
    whereclause =""
    #logger.info{"careerexp #{params.has_key?(:careerexp)} and is #{@careerexp}"}
    case @careerexp
    when  "1" 
      whereclause = "experience_group < 4"
    when "2"
      whereclause = "experience_group > 3 and experience_group < 7"
    when "3"
      whereclause ="experience_group > 6"
    end
     if 1 < whereclause.length 
       @sample = @sample.where(whereclause)
       @sample_antigenre = @sample_antigenre.where(whereclause) if genreincomeOn
     end
    #
    # Full time? (may contain nulls)
    #
    if "true"==params[:ft] then
      whereclause = "full_time = true"
      @sample = @sample.where(whereclause)
      @sample_antigenre = @sample_antigenre.where(whereclause) if genreincomeOn
    end
    
    #
    # Went to music school or conservatory
    #
    if "true"==params[:trained] then
      whereclause = "music_school = true"
      @sample = @sample.where(whereclause)
      @sample_antigenre = @sample_antigenre.where(whereclause) if genreincomeOn
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
      @sample_antigenre = @sample_antigenre.where(genderclause) if genreincomeOn
    end
    
    #
    # TODO EMI filter
    #
    
    whereclause=""
    @emigroup = params.has_key?(:emigroup) ? params[:emigroup] : "ALL"
    case @emigroup
    when  "1" 
      whereclause = "emi < 25000"
    when "2"
      whereclause = "emi >= 25000 and emi < 75000"
    when "3"
      whereclause = "emi >= 75000"
    end
    if 1 < whereclause.length
      @sample = @sample.where(whereclause)
      @sample_antigenre = @sample_antigenre.where(whereclause) if genreincomeOn
    end      
    
    #################### Outputs ######################
    
    #
    # Shared by all Outputs
    #
    @NCount = @sample.count
    
    #
    # AnnInc 
    # TODO Refactor into AnnInc method & Model, combine selects into fewer cursors
    #
    @AvgEMI = @sample.average(:emi) || 0
    @EMISampleSize = @sample.count(:emi)
    @EMIPctAnswered = (0==@NCount)? 100 : 100 * @EMISampleSize / @NCount
    @AvgPctLive = (@sample.average(:pie_live)) || 0
    @AvgEMILive = @AvgPctLive*@AvgEMI
    @AvgPctTeach = @sample.average(:pie_teach) || 0
    @AvgEMITeach = @AvgPctTeach * @AvgEMI
    @AvgPctSalary = @sample.average(:pie_salary) || 0
    @AvgEMISalary = @AvgPctSalary * @AvgEMI
    @AvgPctSession = @sample.average(:pie_session) || 0
    @AvgEMISession = @AvgPctSession * @AvgEMI
    @AvgPctComposition = @sample.average(:pie_song) || 0
    @AvgEMIComposition = @AvgPctComposition * @AvgEMI
    @AvgPctRecord = @sample.average(:pie_record) || 0
    @AvgEMIRecord = @AvgPctRecord * @AvgEMI
    @AvgPctMerch = @sample.average(:pie_merch) || 0
    @AvgEMIMerch = @AvgPctMerch * @AvgEMI
    @AvgPctOther = @sample.average(:pie_other) || 0
    @AvgEMIOther = @AvgPctOther * @AvgEMI
    @DecrIncLive = @sample.where("perform_inc_direction = -1").count()
    @IncrIncLive = @sample.where("perform_inc_direction = 1").count()

    @DecrIncTeach = @sample.where("teach_inc_direction = -1").count()
    @IncrIncTeach = @sample.where("teach_inc_direction = 1").count()

    @DecrIncSalary = @sample.where("salary_inc_direction = -1").count()
    @IncrIncSalary = @sample.where("salary_inc_direction = 1").count()

    @DecrIncSession = @sample.where("session_inc_direction = -1").count()
    @IncrIncSession = @sample.where("session_inc_direction = 1").count()

    @DecrIncComposition = @sample.where("compose_inc_direction = -1").count()
    @IncrIncComposition = @sample.where("compose_inc_direction = 1").count()

    @DecrIncRecording = @sample.where("record_inc_direction = -1").count()
    @IncrIncRecording = @sample.where("record_inc_direction = 1").count()
    @DecrIncMerch = @sample.where("merch_inc_direction = -1").count()
    @IncrIncMerch = @sample.where("merch_inc_direction = 1").count()
    @DecrIncOther = 0 #@sample.where("perform_inc_direction = -1").count()
    @IncrIncOther = 0 #@sample.where("perform_inc_direction = 1").count()
    
    #
    #  GenreIncome
    #
    if genreincomeOn
      @AvgEMI_antigenre = @sample_antigenre.average(:emi) || 0
      puts "ANTI    GENRE        AMI calc"
    end

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
     @AboutPctExperienced = (0<@sample_size) ? 100*@sample.where("experience_group > 3").count/@sample_size : 0
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
     
     #
     # Roles chart
     #
     roleCounts = @sample.select("count(case when role_composer then true end) as composers, count(case when role_recording then true end) as recordingartists,count(case when role_salaried then true end) as salarieds, count(case when role_performer then true end) as performers, count(case when role_session then true end) as sessionplayers, count(case when role_teacher then true end) as teachers").order('1').first
     @Composers = roleCounts.composers
     @RecordingArtists = roleCounts.recordingartists
     @Salarieds = roleCounts.salarieds
     @Performers = roleCounts.performers
     @SessionPlayers = roleCounts.sessionplayers
     @Teachers = roleCounts.teachers
     
     #@RecordingArtists = @sample.count("case when role_recording then true end")
     #@Salarieds = @sample.count("case when role_salaried then true end")
     #@Performers = @sample.count("case when role_performer then true end")
     #@SessionArtists = @sample.count("case when role_session then true end")
     #@Teachers = @sample.count("case when role_teacher then true end")
     #
     # Genre Pie Chart
     #
     

     
  end
end
