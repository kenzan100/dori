class Dori::Application
  def run
    # 4 different source of info
    # - Rent
    # - Net speed
    # - Climate
    # - Access

    # Adj list (forward)
    # key =(data)=> [values]
    [
      reader1 => [writer1],
      reader2 => [writer1],
      reader3 => [writer1],
      reader4 => [writer1],
    ]

    # Adj list (inverse)
    # key <=(data)= [values]
    [
      writer1 => [reader1, reader2, reader3, reader4]
    ]

    # class DataComponent
    #   def call(input)
    #     output = transform(input)
    #     return output
    #   end
    # end

    ---

    # frequency: once
    reader1 = Read.new(
      url: "https://www.chintai.net/rent/",
      validation: {
        format: :xml,
        must_contain: "//*[@class='mod_areaMap area']//div//ul//li//a"
      }
    ) # => dump the whatever data this was able to get as long its valid
    # reader2 = Read.new()

    # | Merge.new(
    # )
    # Select.new(
    #   "//*[@class='mod_areaMap area']//div//ul//li//a"
    # ).each do |element|
    #   Read.new(
    #     url: element,
    #     validation: {
    #       format: :xml,
    #       must_contain: "//*[@class='mod_defTable rent_graphTable js_graph']//tbody//tr"
    #     }
    #   )
    # end

    Write.new(json_schema, reader1, reader2)

    chintai_schema = [
      {
        area: :name
      }
    ]

    Write.new(
      chintai_schema,
      reader1
    )

    dynamic_schema = [
      {
        rent_average: -> () { |elem, acc| acc + (elem/acc.len) },
        net_speed:    -> () { |elem, acc| acc + (elem/acc.len) },
      }
    ]

    proc = -> (str, acc) { acc + 1 }

    enum = [1, 2, 3].each

    class Write
      def self.call(data_path, dynamic_schema, scan_rule)
        data = File.read data_path
        elements = data.scan(scan_rule).to_enum

        memo = dynamic_schema.last
        elements.size.times do
          enum_val = elements.next

          dynamic_schema.first.each do |k, procs|
            proc = procs.first
            default = procs.last
            memo[k] = proc.call(enum_val, memo[k] || default)
          end
        end

        memo
      end
    end

    scan_rule = /style=(.+)>/
    data_path = 'chintai_dump.xml'
    dynamic_schema = [
      {
        cnt1: [-> (val, acc) { acc + 1 }, 0],
        cnt2: [-> (val, acc) { acc + 1 }, 0],
      },
      {} # default
    ]

    Write.call(data_path, dynamic_schema, scan_rule)

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
