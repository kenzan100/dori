# that endpoint which provides the data one step away from view

# weather - 'cloudy' | 'sunny'
# crime_rate - 'high' | 'low'

f1 = Read.new([w2, c2],   as: crime_weather_by_date) do |input_data|
    {
        'yyyy-mm-dd' => {
            weather: 'cloudy',
            crime_rate: 'high'
        }
    }
end

c2 = Read.new(c1,    as: :crime_rate_by_date) do |input_data|
    {
        'yyyy-mm-dd' => 'high'
    }  
end
c1 = Read.new(c_url, as: :crime_rate_source) # dump of source data

w2 = Read.new(w1,    as: :weather_by_date) do |input_data|
    {
        'yyyy-mm-dd' => 'cloudy'
    }  
end

w1 = Read.new(w_url, as: :weather_source)

