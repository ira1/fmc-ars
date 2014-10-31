class DashboardController < ApplicationController
  def show

    @sample = Survey

    # TODO Protect from SQL injection attack/sanitize params
    # 
    # Main-$ genre facet (MGenre)
    #
    @mgenre = (params.has_key?(:mgenre)) ? params[:mgenre] : "ALL"
    if @mgenre != "ALL"
        @sample = @sample.where(:primary_genre_group => params[:mgenre] )
    end
    #
    # Musician Type facet
    #
    @role = (params.has_key?(:role)) ? params[:role] : "ALL"
    case @role
    when "COMPOSER"
      @sample = @sample.where(role_composer: true)
    when "RECORDING"
      @sample = @sample.where(role_recording: true)      
    when "SALARIED"
      @sample = @sample.where(role_salaried: true)
    when "PERFORMER"
      @sample = @sample.where(role_performer: true)
    when "SESSION"
      @sample = @sample.where(role_session: true)
    # else
      # else stmts
    end
    #
    # Career Level facet
    #
    @careerexp = params.has_key?(:careerexp) ? params[:careerexp] : "ALL"
    logger.info{"careerexp #{params.has_key?(:careerexp)} and is #{@careerexp}"}
    #
    #  TODO Refactor into FTClaim method
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
    
  end
end
