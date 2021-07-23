require 'pp'
require 'byebug'

class Write
  def self.call(data_path, dynamic_schema, scan_rule)
    data = File.read data_path
    elements = data.scan(scan_rule).flatten.each

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
    cnt1: [-> (val, acc) { val.size + acc }, 0],
    cnt2: [-> (val, acc) { acc + 1 }, 0],
  },
  {} # default
]

pp Write.call(data_path, dynamic_schema, scan_rule)


data = File.read data_path
elements = data.scan(scan_rule).flatten.each

init = {
  cnt1: 0,
  cnt2: 0
}

elements.each_with_object({}) do |str, hash|
  hash[:cnt1] = hash[:cnt1] + str.size
  hash[:cnt2] = hash[:cnt1] + 1
end
