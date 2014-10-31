json.array!(@surveys) do |survey|
  json.extract! survey, :id, :respondentid, :batch, :full_time, :age
  json.url survey_url(survey, format: :json)
end
