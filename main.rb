class Dori::Application
  def run
    # 4 different source of info
    # - Rent
    # - Net speed
    # - Climate
    # - Access

    # Adj list (forward)
    [
      reader1 => [writer1],
      reader2 => [writer1],
      reader3 => [writer1],
      reader4 => [writer1],
    ]

    # Adj list (inverse)
    [
      writer1 => [reader1, reader2, reader3, reader4]
    ]

    # frequency: once
    reader1 = Read.new(
      url: "https://www.chintai.net/rent/",
      validation: {
        format: :xml,
        must_contain: "//*[@class='mod_areaMap area']//div//ul//li//a"
      }
    )
    reader2 = Read.new(
    )


    | Merge.new(
    )
    Select.new(
      "//*[@class='mod_areaMap area']//div//ul//li//a"
    ).each do |element|
      Read.new(
        url: element,
        validation: {
          format: :xml,
          must_contain: "//*[@class='mod_defTable rent_graphTable js_graph']//tbody//tr"
        }
      )
    end

    schema = [
      {
        rent_average: matcher,
        net_speed: matcher,
      }
    ]

    Write.call('hoge.json', schema)

    Read.new(
      key: [:id, :timestamp],
      InitialLoad
      WebhookSync
    )

    Map.new()
    Reduce.new()
    Filter.new()


  end
end
