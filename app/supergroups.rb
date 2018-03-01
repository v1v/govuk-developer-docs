class Supergroups
  def self.details
    @supergroups_details || begin
      data = HTTP.get_yaml("https://github.com/alphagov/govuk_document_types/blob/master/data/supergroups.yml")
      supergroups = data.fetch("content_purpose_supergroup")
      docs = data.fetch("documentation")
      Supergroups.new(supergroups, docs)
    end
  end

  attr_reader :supergroups, :documentation

  def initialize(supergroups, documentation)
    @supergroups = supergroups.fetch("items")
    @documentation = documentation
  end
end