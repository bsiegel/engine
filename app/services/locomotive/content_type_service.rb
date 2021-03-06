module Locomotive
  class ContentTypeService < Struct.new(:site)

    def list
      site.content_types
        .only(:_id, :name, :slug, :number_of_entries)
        .order_by(:name.asc).to_a
    end

    def find_by_slug(slug)
      site.content_types.by_id_or_slug(slug)
    end

  end
end
