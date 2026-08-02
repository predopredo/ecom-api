# app/controllers/concerns/paginatable.rb
module Paginatable
  extend ActiveSupport::Concern

  def paginate(scope, default_per_page: 20, max_per_page: 100)
    page = [ params[:page].to_i, 1 ].max
    raw_per_page = params[:per_page].present? ? params[:per_page].to_i : default_per_page
    per_page = [[ raw_per_page, 1 ].max, max_per_page ].min

    total_count = scope.count
    total_pages = (total_count.to_f / per_page).ceil
    records = scope.offset((page - 1) * per_page).limit(per_page)

    response.headers["X-Total-Count"] = total_count.to_s
    response.headers["X-Page"] = page.to_s
    response.headers["X-Per-Page"] = per_page.to_s
    response.headers["X-Total-Pages"] = total_pages.to_s

    {
      data: records,
      meta: {
        page: page,
        per_page: per_page,
        total_count: total_count,
        total_pages: total_pages
      }
    }
  end
end
