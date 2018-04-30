# Generated via
#  `rails generate hyrax:work OralHistory`
class OralHistory < ActiveFedora::Base
  include ::Hyrax::WorkBehavior


  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }


  property :subject_genres, predicate: ::RDF::Vocab::MODS.subjectGenre, multiple: true do |index|
    index.as :stored_searchable
  end

  property :language_of_resource, predicate: ::RDF::Vocab::MODS.languageOfResource, multiple: true do |index|
    index.as :stored_searchable
  end

  property :media_url, predicate: ::RDF::Vocab::MODS.locationUrl, multiple: false do |index|
    index.as :stored_searchable
  end

  property :content_description, predicate: ::RDF::Vocab::MODS.abstract, multiple: true do |index|
    index.as :stored_searchable
  end

  include ::Hyrax::BasicMetadata

  self.indexer = OralHistoryIndexer
  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
end

# title: parsexml('title'),
#     duration: parsexml('duration'),
#     collection_name: parsexml('collection_name'),
#     repository: parsexml('repository'),
#     format: parsexml('format'),
#     interviewer: parsexml('interviewer'),
#     interviewee: parsexml('interviewee'),
#     media_url: parsexml('media_url'),
#     language: parsexml('language'),
#     description: parsexml('description'),
#     transcript: parsexml('transcript')