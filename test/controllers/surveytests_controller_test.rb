require 'test_helper'

class SurveytestsControllerTest < ActionController::TestCase
  setup do
    @surveytest = surveytests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveytests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create surveytest" do
    assert_difference('Surveytest.count') do
      post :create, surveytest: { aarc: @surveytest.aarc, afm_2: @surveytest.afm_2, afm_aftra: @surveytest.afm_aftra, afm_srsp: @surveytest.afm_srsp, aftra_csp: @surveytest.aftra_csp, age: @surveytest.age, age_group: @surveytest.age_group, ascaplus: @surveytest.ascaplus, comfort_net_collaborate: @surveytest.comfort_net_collaborate, comfort_net_distribute: @surveytest.comfort_net_distribute, comfort_net_fanconnect: @surveytest.comfort_net_fanconnect, comfort_net_produce: @surveytest.comfort_net_produce, comfort_net_promote: @surveytest.comfort_net_promote, compose_inc_direction: @surveytest.compose_inc_direction, credits_compose_life: @surveytest.credits_compose_life, credits_record_life: @surveytest.credits_record_life, credits_session_life: @surveytest.credits_session_life, credits_show_life: @surveytest.credits_show_life, edu_level_group: @surveytest.edu_level_group, emi: @surveytest.emi, experience_group: @surveytest.experience_group, freq_cable_radio: @surveytest.freq_cable_radio, freq_commercial_radio: @surveytest.freq_commercial_radio, freq_internet_radio: @surveytest.freq_internet_radio, freq_noncommercial_radio: @surveytest.freq_noncommercial_radio, freq_satellite_radio: @surveytest.freq_satellite_radio, full_time: @surveytest.full_time, gender: @surveytest.gender, gender_group: @surveytest.gender_group, genre_group_1: @surveytest.genre_group_1, hours_group: @surveytest.hours_group, income_strata: @surveytest.income_strata, income_strata_group: @surveytest.income_strata_group, integer: @surveytest.integer, integer: @surveytest.integer, label_settle: @surveytest.label_settle, member_music_org: @surveytest.member_music_org, member_pro: @surveytest.member_pro, merch_inc_direction: @surveytest.merch_inc_direction, money_genre_group_1: @surveytest.money_genre_group_1, music_inc_share_pct: @surveytest.music_inc_share_pct, music_school: @surveytest.music_school, path_group: @surveytest.path_group, perform_inc_direction: @surveytest.perform_inc_direction, pie_live: @surveytest.pie_live, pie_merch: @surveytest.pie_merch, pie_other: @surveytest.pie_other, pie_record: @surveytest.pie_record, pie_salary: @surveytest.pie_salary, pie_session: @surveytest.pie_session, pie_song: @surveytest.pie_song, pie_teach: @surveytest.pie_teach, record_inc_direction: @surveytest.record_inc_direction, respondentid: @surveytest.respondentid, rev_acting: @surveytest.rev_acting, rev_corp: @surveytest.rev_corp, rev_endorse: @surveytest.rev_endorse, rev_fanclub: @surveytest.rev_fanclub, rev_fanfund: @surveytest.rev_fanfund, rev_grants: @surveytest.rev_grants, rev_honoraria: @surveytest.rev_honoraria, rev_persona: @surveytest.rev_persona, rev_produce: @surveytest.rev_produce, rev_pubadvance: @surveytest.rev_pubadvance, rev_sample: @surveytest.rev_sample, rev_webads: @surveytest.rev_webads, rev_youtube: @surveytest.rev_youtube, role_compose: @surveytest.role_compose, role_perform: @surveytest.role_perform, role_record: @surveytest.role_record, role_session: @surveytest.role_session, role_teach: @surveytest.role_teach, salary_inc_direction: @surveytest.salary_inc_direction, seasoning_group: @surveytest.seasoning_group, session_inc_direction: @surveytest.session_inc_direction, shows_last_year: @surveytest.shows_last_year, teach_inc_direction: @surveytest.teach_inc_direction, zip: @surveytest.zip }
    end

    assert_redirected_to surveytest_path(assigns(:surveytest))
  end

  test "should show surveytest" do
    get :show, id: @surveytest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @surveytest
    assert_response :success
  end

  test "should update surveytest" do
    patch :update, id: @surveytest, surveytest: { aarc: @surveytest.aarc, afm_2: @surveytest.afm_2, afm_aftra: @surveytest.afm_aftra, afm_srsp: @surveytest.afm_srsp, aftra_csp: @surveytest.aftra_csp, age: @surveytest.age, age_group: @surveytest.age_group, ascaplus: @surveytest.ascaplus, comfort_net_collaborate: @surveytest.comfort_net_collaborate, comfort_net_distribute: @surveytest.comfort_net_distribute, comfort_net_fanconnect: @surveytest.comfort_net_fanconnect, comfort_net_produce: @surveytest.comfort_net_produce, comfort_net_promote: @surveytest.comfort_net_promote, compose_inc_direction: @surveytest.compose_inc_direction, credits_compose_life: @surveytest.credits_compose_life, credits_record_life: @surveytest.credits_record_life, credits_session_life: @surveytest.credits_session_life, credits_show_life: @surveytest.credits_show_life, edu_level_group: @surveytest.edu_level_group, emi: @surveytest.emi, experience_group: @surveytest.experience_group, freq_cable_radio: @surveytest.freq_cable_radio, freq_commercial_radio: @surveytest.freq_commercial_radio, freq_internet_radio: @surveytest.freq_internet_radio, freq_noncommercial_radio: @surveytest.freq_noncommercial_radio, freq_satellite_radio: @surveytest.freq_satellite_radio, full_time: @surveytest.full_time, gender: @surveytest.gender, gender_group: @surveytest.gender_group, genre_group_1: @surveytest.genre_group_1, hours_group: @surveytest.hours_group, income_strata: @surveytest.income_strata, income_strata_group: @surveytest.income_strata_group, integer: @surveytest.integer, integer: @surveytest.integer, label_settle: @surveytest.label_settle, member_music_org: @surveytest.member_music_org, member_pro: @surveytest.member_pro, merch_inc_direction: @surveytest.merch_inc_direction, money_genre_group_1: @surveytest.money_genre_group_1, music_inc_share_pct: @surveytest.music_inc_share_pct, music_school: @surveytest.music_school, path_group: @surveytest.path_group, perform_inc_direction: @surveytest.perform_inc_direction, pie_live: @surveytest.pie_live, pie_merch: @surveytest.pie_merch, pie_other: @surveytest.pie_other, pie_record: @surveytest.pie_record, pie_salary: @surveytest.pie_salary, pie_session: @surveytest.pie_session, pie_song: @surveytest.pie_song, pie_teach: @surveytest.pie_teach, record_inc_direction: @surveytest.record_inc_direction, respondentid: @surveytest.respondentid, rev_acting: @surveytest.rev_acting, rev_corp: @surveytest.rev_corp, rev_endorse: @surveytest.rev_endorse, rev_fanclub: @surveytest.rev_fanclub, rev_fanfund: @surveytest.rev_fanfund, rev_grants: @surveytest.rev_grants, rev_honoraria: @surveytest.rev_honoraria, rev_persona: @surveytest.rev_persona, rev_produce: @surveytest.rev_produce, rev_pubadvance: @surveytest.rev_pubadvance, rev_sample: @surveytest.rev_sample, rev_webads: @surveytest.rev_webads, rev_youtube: @surveytest.rev_youtube, role_compose: @surveytest.role_compose, role_perform: @surveytest.role_perform, role_record: @surveytest.role_record, role_session: @surveytest.role_session, role_teach: @surveytest.role_teach, salary_inc_direction: @surveytest.salary_inc_direction, seasoning_group: @surveytest.seasoning_group, session_inc_direction: @surveytest.session_inc_direction, shows_last_year: @surveytest.shows_last_year, teach_inc_direction: @surveytest.teach_inc_direction, zip: @surveytest.zip }
    assert_redirected_to surveytest_path(assigns(:surveytest))
  end

  test "should destroy surveytest" do
    assert_difference('Surveytest.count', -1) do
      delete :destroy, id: @surveytest
    end

    assert_redirected_to surveytests_path
  end
end
