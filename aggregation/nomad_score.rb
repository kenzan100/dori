class NomadScore
  def call
    [
      NomadScore,
      RentSpeedScore,
      ClimateScore,
      TransportScore
    ]
  end
end