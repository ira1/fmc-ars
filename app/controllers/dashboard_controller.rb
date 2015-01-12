class DashboardController < ApplicationController

  logger.info("running")
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
  
    def sigfig_to_s(numero,digits)
      f = sprintf("%.#{digits - 1}e", numero).to_f
      i = f.to_i
      (i == f ? i : f).to_s
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
    @genreincomeOn=false
    @mgenre = (params.has_key?(:mgenre)) ? params[:mgenre].upcase : "ALL"
    if @mgenre != "ALL"
        @sample = @sample.where(:money_genre_group_1 => params[:mgenre] )
        # if user has chosen a genre, then we need to prepare a result set based on the inverse of chosen genre 
        @sample_antigenre = Survey.where.not(:money_genre_group_1 => params[:mgenre])
        @genreincomeOn=true
    end

    #
    #
    #  Process Role parameters 
    #
    optionalclause=""
    mandatoryclause=""
    #if ("true"==params[:role_missing]) then 
    #     roleclause = "(role_composer is null AND role_recording is null AND role_salaried is null AND role_performer is null AND role_session is null)"
    #     facetroles+=1
    #end
    # if time permits, change this to ["role_composer","role..."].each iterator
    #
    if params.has_key?(:role_composer) then
      if "true"==params[:role_composer].downcase  then 
        AppendClauseOr(optionalclause,"role_composer=true")
      else
        AppendClauseAnd(mandatoryclause,"role_composer!=true")
      end
    end

    if params.has_key?(:role_recording) then
      if "true"==params[:role_recording].downcase then
        AppendClauseOr(optionalclause, "role_recording=true")
      else
        AppendClauseAnd(mandatoryclause,"role_recording!=true")
      end
    end

    if params.has_key?(:role_salaried)
      if "true"==params[:role_salaried].downcase  then 
        AppendClauseOr(optionalclause, "role_salaried=true") 
      else        
        AppendClauseAnd(mandatoryclause, "role_salaried!=true") 
      end
    end

    if params.has_key?(:role_performer)
      if "true"==params[:role_performer].downcase  then 
        AppendClauseOr(optionalclause, "role_performer=true")
      else        
        AppendClauseAnd(mandatoryclause, "role_performer!=true")
      end
    end

    if params.has_key?(:role_session)
      if "true"==params[:role_session].downcase then 
        AppendClauseOr(optionalclause, "role_session=true")
      else
        AppendClauseAnd(mandatoryclause, "role_session!=true")
      end
    end

    if params.has_key?(:role_teacher)
      if "true"==params[:role_teacher].downcase then 
        AppendClauseOr(optionalclause, "role_teacher=true")
      else        
        AppendClauseAnd(mandatoryclause, "role_teacher!=true")
      end
    end      

    if params.has_key?(:role_other) && "true"==params[:role_other] then
      AppendClauseOr(roleclause, "role_other=true")
    else
      @sample=@sample.where("role_other=false")
      @sample_antigenre = @sample_antigenre.where("role_other=false") if @genreincomeOn
    end
    
#
# role_other
#
#    if 0<rolecount then 
#      AppendClauseOr(roleclause, "(role_composer is null and role_recording is null and role_salaried is null and role_performer is null and role_session is null and role_teacher is null)")
#    end 
    if 0<optionalclause.length && 0<mandatoryclause.length then
      roleclause= "("+optionalclause+")" 
      AppendClauseAnd(roleclause,mandatoryclause)
    else
      if 0<optionalclause.length then
        roleclause=optionalclause
      else
        roleclause=mandatoryclause
      end
    end
    @sample = @sample.where(roleclause)
    @sample_antigenre = @sample_antigenre.where(roleclause) if @genreincomeOn
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
       @sample_antigenre = @sample_antigenre.where(whereclause) if @genreincomeOn
     end
    #
    # Full time? (may contain nulls)
    #
    if "true"==params[:ft] then
      whereclause = "full_time = true"
      @sample = @sample.where(whereclause)
      @sample_antigenre = @sample_antigenre.where(whereclause) if @genreincomeOn
    end
    
    #
    # Went to music school or conservatory
    #
    if "true"==params[:trained] then
      whereclause = "music_school = true"
      @sample = @sample.where(whereclause)
      @sample_antigenre = @sample_antigenre.where(whereclause) if @genreincomeOn
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
      @sample_antigenre = @sample_antigenre.where(genderclause) if @genreincomeOn
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
      @sample_antigenre = @sample_antigenre.where(whereclause) if @genreincomeOn
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
    @AvgEMI = sigfig_to_s(@sample.average(:emi).to_f || 0,3).to_f
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
    if @genreincomeOn then
      #coalesce(avg(pie_compose),0) as avg_pct_compose,\
      #coalesce(avg(pie_song),0) as avg_pct_song,\
      #coalesce(avg(pie_record),0) as avg_pct_record,\
      genreColExpr = "count(emi) as ncount, \
      coalesce(avg(emi),0) as avg_emi, \
      coalesce(avg(pie_live),0) as avg_pct_live,\
      coalesce(avg(pie_teach),0) as avg_pct_teach,\
      coalesce(avg(pie_salary),0) as avg_pct_salary,\
      coalesce(avg(pie_session),0) as avg_pct_session,\
      coalesce(avg(pie_song),0) as avg_pct_compose,\
      coalesce(avg(pie_record),0) as avg_pct_record,\
      coalesce(avg(pie_merch),0) as avg_pct_merch,\
      coalesce(avg(pie_other),0) as avg_pct_other"
      
      @GenreIncResults = @sample.select(genreColExpr).order("1").first
      @AntiGenreIncResults = @sample_antigenre.select(genreColExpr).order("1").first
      @NCount_antigenre = @AntiGenreIncResults.attributes["ncount"]
      @AvgEMI_antigenre = @AntiGenreIncResults.attributes["avg_emi"]
      
      @GenrePcts = @GenreIncResults.attributes.select { |k,v| k['avg_pct']}.map {|k,v| v.to_f.round(1)}
      @AntiGenrePcts = @AntiGenreIncResults.attributes.select { |k,v| k['avg_pct']}.map {|k,v| v.to_f.round(1) }
      
     # @EMISampleSize = @sample.count(:emi)
     # @EMIPctAnswered = (0==@NCount)? 100 : 100 * @EMISampleSize / @NCount
     #  @AvgPctLive = (@sample.average(:pie_live)) || 0
     #  @AvgEMILive = @AvgPctLive*@AvgEMI
     #  @AvgPctTeach = @sample.average(:pie_teach) || 0
     #  @AvgEMITeach = @AvgPctTeach * @AvgEMI
     #  @AvgPctSalary = @sample.average(:pie_salary) || 0
     #  @AvgEMISalary = @AvgPctSalary * @AvgEMI
     #  @AvgPctSession = @sample.average(:pie_session) || 0
     #  @AvgEMISession = @AvgPctSession * @AvgEMI
     #  @AvgPctComposition = @sample.average(:pie_song) || 0
     #  @AvgEMIComposition = @AvgPctComposition * @AvgEMI
     #  @AvgPctRecord = @sample.average(:pie_record) || 0
     #  @AvgEMIRecord = @AvgPctRecord * @AvgEMI
     #  @AvgPctMerch = @sample.average(:pie_merch) || 0
     #  @AvgEMIMerch = @AvgPctMerch * @AvgEMI
     #  @AvgPctOther = @sample.average(:pie_other) || 0
     #  @AvgEMIOther = @AvgPctOther * @AvgEMI
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
    #  TODO use NULLIF to prevent div by 0 in SQL
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
     
     #
     # Genre Bar Chart
     #
     genreLong= {0=>'All others',1=>'Classical',2=>'Jazz',3=>'Rock/Alt-Rock/Indie',4=>'Country/Americana/Bluegrass', nil=>'No answer'}
     genreShort= {0=>'Others',1=>'Classical',2=>'Jazz',3=>'Rock...',4=>'Country...', nil=>'Unknown'}
     genreCounts=@sample.group(:genre_group_1).count()
     @GenreSeries = [1,2,3,4,0,nil].map { |e| { :name=>genreLong[e].to_s, :y=>genreCounts[e], :short=>genreShort[e].to_s } }
     
     #
     # OtherIncome calculation 
     #
     # f.sort_by { |kkey,vval| vval}
     if 0<@NCount 
       colexpr="100.0*count(case when rev_produce then 1 end)/count(*) as rev_produce, 100.0*count(case when afm_srsp then 1 end)/count(*) as afm_srsp, 100.0*count(case when rev_honoraria then 1 end)/count(*) as rev_honoraria, 100.0*count(case when rev_grants then 1 end)/count(*) as rev_grants, 100.0*count(case when afm_2 then 1 end)/count(*) as afm_2, 100.0*count(case when rev_fanfund then 1 end)/count(*) as rev_fanfund, 100.0*count(case when rev_corp then 1 end)/count(*) as rev_corp, 100.0*count(case when afm_aftra then 1 end)/count(*) as afm_aftra, 100.0*count(case when ascaplus then 1 end)/count(*) as ascaplus, 100.0*count(case when rev_acting then 1 end)/count(*) as rev_acting, 100.0*count(case when rev_webads then 1 end)/count(*) as rev_webads, 100.0*count(case when aarc then 1 end)/count(*) as aarc, 100.0*count(case when rev_endorse then 1 end)/count(*) as rev_endorse, 100.0*count(case when label_settle then 1 end)/count(*) as label_settle, 100.0*count(case when rev_sample then 1 end)/count(*) as rev_sample, 100.0*count(case when rev_pubadvance then 1 end)/count(*) as rev_pubadvance, 100.0*count(case when rev_youtube then 1 end)/count(*) as rev_youtube, 100.0*count(case when rev_persona then 1 end)/count(*) as rev_persona, 100.0*count(case when rev_fanclub then 1 end)/count(*) as rev_fanclub, 100.0*count(case when aftra_csp then 1 end)/count(*) as aftra_csp"
       @OtherIncomeDist=@sample.select(colexpr).order("1").first.attributes.select { |k,v| v }
     # f = @OtherIncomeDist.sort_by { |kkey,vval| vval}
     end
     
     #
     #
     #    Music Income by Age Group
     #
     ageColExpr = "age_group as x,avg(emi)::int as avg_emi, (avg(midrange_income)-avg(emi))::int as avg_non_music_inc"
     musicIncbyAge = ActiveRecord::Base.connection.select_all(@sample.group(:age_group).order(:age_group).select(ageColExpr))
     @MusicIncbyAge = musicIncbyAge.map { |e| [e["x"].to_i-1, sigfig_to_s(e["avg_emi"].to_f,3).to_i] }
     @NonMusicIncbyAge = musicIncbyAge.map { |e| [e["x"].to_i-1, sigfig_to_s(e["avg_non_music_inc"].to_f,3).to_i] }
     @AvgGross = sigfig_to_s(@sample.average(:midrange_income).to_f || 0.0,3).to_i
     
     #
     #
     #     Concentration Map
     #
     colexpr = "countyfips as fips, count(*) as value"
     @MusiciansByCounties = @sample.where("countyfips is not null").group(:countyfips).select(colexpr).order("1")
  end
end
