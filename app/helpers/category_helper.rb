module CategoryHelper
    def build_tree node
        {
         text: node.title,
         href: category_url(node),
         tags: [node.articles.count],
         nodes: node.childrens.map { |x| build_tree(x) },
         state: {selected: (@category.present? && @category.id==node.id)}  
        }.delete_if{|x,v| v.try(:empty?)}
  end
end
