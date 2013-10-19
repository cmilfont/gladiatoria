class Technique < ActiveRecord::Base

  validates_presence_of :title, :description

  include Searchable

  mapping _all: {
    auto_boost: true,
    index_analyzer: "index_analyzer",
    search_analyzer: "search_analyzer"
  },
          properties: {
            description: {
              type: "string",
              index_analyzer: "index_analyzer",
              search_analyzer: "search_analyzer"
            },
            title: {
              type: "string",
              boost: 10,
              store: true,
              index_analyzer: "index_analyzer",
              search_analyzer: "search_analyzer"
            }
          }


  def self.search query=""

    return [] unless query.present?

    results = Technique.esclient.search index:"techniques", body:"{\"query\": {\"query_string\": {\"query\": \"#{query}\"}}}"
    ids = results["hits"]["hits"].map{ |hit| hit["_id"] }
    find ids

  end

end
