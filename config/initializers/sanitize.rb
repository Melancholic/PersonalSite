class Sanitize
  module Config
    EXPENDED_BASIC = Sanitize::Config.merge(Sanitize::Config::BASIC,
      :elements => Sanitize::Config::BASIC[:elements] + ['img', 'div','iframe'], 
      :attributes => {
        'img'=> ['src', 'title', 'align', 'alt'],
        'a'=> ['class', 'href'],
        'iframe' => ['src', 'allowfullscreen', 'frameborder' ],
        'div' => ['class']
      },
      :add_attributes =>{
        'img' => {'class' => 'img-thumbnail'}

      },
      :protocols => {
        'iframe' => {'src' => ['http', 'https']}
      }
    )
  end
end