crumb :root do
  link '<i class="fa fa-home fa-fw"></i>'.html_safe, blog_root_page_path do

  end
end

crumb :category do |cat|
   link ('<i class="fa fa-code-fork"></i> '+cat.title.truncate(20)).html_safe, category_path(cat)
   parent :category, cat.parent unless cat.parent.nil?
 end

 crumb :article do |art|
   link ('<i class="fa fa-file-text"></i> ' + art.title.truncate(20)).html_safe, category_article_path(art.category, art) unless art.new_record?
  # link ('<i class="fa fa-pencil-square-o"></i> ' + "New Article").html_safe, category_path(art.category) if art.new_record?
   parent :category, art.category unless art.category.nil?
 end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).