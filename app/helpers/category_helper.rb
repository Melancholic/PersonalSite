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

    def nested_dropdown(items, depth=0)
        result = []
        items.map do |item|
            result << [("-" * depth)+' ' + item.title, item.id]
            result += nested_dropdown(item.childrens, depth+1) unless item.childrens.blank?
        end
        result
    end
end
