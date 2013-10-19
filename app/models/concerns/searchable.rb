module Searchable
  extend ActiveSupport::Concern

  included do

    attr_accessor :hit

    class_attribute :index
    class_attribute :esclient

    self.index = {}
    self.index[self.name.tableize.to_sym] = { mappings: {}, settings: {} }
    self.index[self.name.tableize.to_sym][:mappings][self.name.tableize.singularize.to_sym] = {}
    self.esclient = Elasticsearch::Client.new host: 'localhost:9200'

    after_update do
      update_document
      true
    end

    after_create do
      create_document
      true
    end

    after_destroy do
      delete_document
      true
    end

    settings_default

  end

  def create_document
    self.esclient.create index: self.class.name.tableize,
                          type: self.class.name.tableize.singularize,
                            id: try(:id),
                          body: attributes
  end

  def update_document
    delete_document
    create_document
  end

  def delete_document
    self.esclient.delete index: self.class.name.tableize,
                         type: self.class.name.tableize.singularize,
                         id: try(:id)
  end

  module ClassMethods

    def settings_default
      settings index: {
        :analysis => {
          :analyzer=> {
            :index_analyzer=> {
              :tokenizer=> "standard",
              :filter=> ["standard", "my_delimiter", "lowercase", "stop", "asciifolding", "porter_stem", "my_edge"]
            },
            :search_analyzer=> {
              :tokenizer=> "standard",
              :filter=> ["standard", "lowercase", "stop", "asciifolding", "porter_stem"]
            }
          },
          :filter=> {
            :my_delimiter => {
              :type=> "word_delimiter",
              :generate_word_parts=> true,
              :catenate_words=> true,
              :catenate_numbers=> true,
              :catenate_all=> true,
              :split_on_case_change=> true,
              :preserve_original=> true,
              :split_on_numerics=> true,
              :stem_english_possessive=> true
            },
            my_edge: {
              type: 'edgeNGram', #1 to 10 letters, from the start
              min_gram: 1,
              max_gram: 10,
              side: 'front'
            }
          }
        }
      }
    end

    def mapping conf
      self.index[self.name.tableize.to_sym][:mappings][self.name.tableize.singularize.to_sym] = conf
    end
    def settings conf
      self.index[self.name.tableize.to_sym][:settings] = conf
    end

    def create_index
      self.esclient.indices.create index: self.name.tableize, body: self.index[self.name.tableize.to_sym]
    end

    def destroy_index
      self.esclient.indices.delete index: self.name.tableize
    end

    def create_documents
      documents = self.name.constantize.send(:all).map do |document|
        {
          index:  {
            _index: self.name.tableize,
            _type: self.name.tableize.singularize,
            _id: document.try(:id),
            data: document.attributes
          }
        }
      end
      self.esclient.bulk body: documents if documents.present?
    end

  end

end