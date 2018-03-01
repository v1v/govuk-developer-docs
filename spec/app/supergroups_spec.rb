RSpec.describe Supertypes do
  describe '.details' do
    it 'should work' do
      stub_request(:get, "https://github.com/alphagov/govuk_document_types/blob/master/data/supergroups.yml")
        .to_return(body: File.read("spec/fixtures/supergroups.yml"))

      supergroups = Supergroups.details

      expect(supergroups.supergroups.first).to include({
                                                         "id" => "news_and_communications",
                                                         "subgroups" => ["updates_and_alerts", "news"]
                                                       })
    end
  end
end
