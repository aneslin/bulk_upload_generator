# Generated via
#  `rails generate hyrax:work Photo`
class Photo < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  before_create :set_default_metadata

  def set_default_metadata
    self.digital_publisher = "Georgia State University Library"
    self.format = "image/jp2"
	  self.item_type = "Image"
  end

  self.indexer = PhotoIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  property :title, predicate: ::RDF::Vocab::DC.title, multiple: true do |index|
    index.as :stored_searchable, :facetable
  end

  property :item_identifier, predicate: ::RDF::Vocab::DC.mediator, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :date_of_original, predicate: ::RDF::Vocab::DC.temporal, multiple: true do |index|
    index.as :stored_searchable, :facetable
  end

  property :decade, predicate: ::RDF::Vocab::DC.date, multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  # There is an entry for 'coverage' and an entry for 'temporal', but not one for both.

  property :subject, predicate: ::RDF::Vocab::DC.subject, multiple: true do |index|
    index.as :stored_searchable, :facetable
  end

  property :file_name, predicate: ::RDF::Vocab::DC.issued, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :location_depicted, predicate: ::RDF::Vocab::DC.spatial, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :note, predicate: ::RDF::Vocab::DC.description, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  # There is something wrong with these three fields saving for some of the rows of data in the csv...
  # this might be related to the .ispartof vocab being reserved or trying to modify the collection attribute.
  property :series, predicate: ::RDF::Vocab::DC.coverage, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :collection, predicate: ::RDF::Vocab::DC.source, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :curatorial_area, predicate: ::RDF::Vocab::DC.spatial, multiple: false do |index|
      index.as :stored_searchable, :facetable
  end

  property :digital_publisher, predicate: ::RDF::Vocab::DC.publisher, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :format, predicate: ::RDF::Vocab::DC.format, multiple: false do |index|
	  index.as :stored_searchable, :facetable
  end

  #type is invalid as a property name
  property :item_type, predicate: ::RDF::Vocab::DC.type, multiple: false do |index|
	  index.as :stored_searchable, :facetable
  end


  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end

# [:﻿identifier, :title, :date_of_original, :decade, :description, :creator,
# :contributors, :digital_publisher, :curatorial_area, :collection, :rights_information,
# :citation, :location_depicted, :subject, :"subject_(names)", :source_format,
# :type, :format, :file_name]


