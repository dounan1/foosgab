class SliderInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options.merge!({ 
      type: 'range',
      min: '0',
      max: '10',
      step: '1'
    })
    
    @builder.text_field(attribute_name, input_html_options)
  end
end