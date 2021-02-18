class ChintaiScore
  {
    "島根県"=>{"rent_average"=>6.62, "rank_rent"=>15, "score"=>25.0, "score_rent"=>25.0},
    "青森県"=>{"rent_average"=>6.29, "rank_rent"=>12, "score"=>25.0, "score_rent"=>25.0},
  }
  def call
    Rent.aggregate(by: 'area', value: 'rent')
  end

  def validate
    {
      keys: AREA_NAMES,
      values: (5..20)
    }
  end
end