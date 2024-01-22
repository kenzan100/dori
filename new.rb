# typed: true
# 名前を入れたら

class Input < T::Struct
  prop :name, String
  prop :luck, T.nilable(String)
end

class Crawed < T::Struct
  prop :num_of_char, Integer
  prop :luck, String
end

class Http
  def from_request(http_request)
    Input.new(name: http_request.body.name)
  end
end

class Crawl
  def from_crawl(url)
    res = get(url)
    parsed = parse(res)
    save(parsed)
    Crawed.new(num_of_char: parsed.num_of_char, luck: parsed.luck)
  end
end

class Sql
  def from_http(input)
  end

  def from_crawl(crawed)
  end

  def to_render
    query("select * from crawled")
  end
end

class Render
  def from_sql(input)
    Input.new(name: input.name, luck: input.luck)
  end

  def show
    return "
      <html>
        <head>
          <title>姓名判断</title>
        </head>
        <body>
          <h1>あなたの名前</h1>
          <p>#{input.name}</p>
          <h1>あなたの運勢</h1>
          <p>#{input.fortune}</p>
        </body>        
      </html>
    "
  end
end

http = Http.new
crawl = Crawl.new
sql = Sql.new
render = Render.new

dag = DAG.new
dag.add(from: http, to: sql)
dag.add(from: crawl, to: sql)
dag.add(from: sql, to: render)

dag.run

