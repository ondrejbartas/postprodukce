# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper



# Format a label element for a form field.
#
# +options+ can include:
#
# [:required] If +true+, an asterisk is added to the label.
# [:field_name] If true, the for attribute on the label
# is set from +model+ + +field_name+;
# otherwise, for attribute is set from
# +model+ + lowercased and underscored +label_text+.
#
# Example call:
# label(:person, 'Email')
#
# Example output:
# <strong><label for="person_email">Email</label>:</strong>
def label(model, field_name, label_text, options={})
  # Use the field_name option if supplied
  # The value for the for attribute.
  label_for = (model.to_s + '_' + field_name).downcase
  # The <label> tag
  label_tag = content_tag('label', label_text, :for => label_for)
  # Add an asterisk if :required option specified.
  label_tag += '*' if options[:required]
  # Finish off the label.
  label_tag += ':'
  # Wrap the <label> tag in a <strong> tag.
  content_tag('strong', label_tag)
end

def print_field(value, text, warp)
  #Print field if is not blank
  unless value.blank?
    out = '<'+warp+'><strong>'+text+'</strong> '+value+'</'+warp+'>'
  else
    out = ""
  end
  out
end

def print_address_field(value, text, warp)
  #Print field if is not blank
  unless value.blank?
    out = '<'+warp+'><strong>'+text+'</strong> '+address_format(value)+'</'+warp+'>'
  else
    out = ""
  end
  out
end

def print_simple_field(value, text, warp)
  #Print field if is not blank
  unless value.blank?
    out = '<'+warp+'><strong>'+text+'</strong> '+simple_format(value)+'</'+warp+'>'
  else
    out = ""
  end
  out
end

def print_mail_field(value, text, warp)
  #Print field if is not blank
  unless value.blank?
    out = '<'+warp+'><strong>'+text+'</strong> '+mail_to(value)+'</'+warp+'>'
  else
    out = ""
  end
  out
end

def show_name(item)
    item.nil? ? "" : item.name
end

 def address_format(text)
    content_tag 'address', text.to_s.
      gsub(/\r\n?/, "\n").                    # \r\n and \r -> \n
      gsub(/\n\n+/, "</address>\n\n<address>").           # 2+ newline  -> paragraph
      gsub(/([^\n]\n)(?=[^\n])/, '\1<br />')  # 1 newline   -> br
 end
end
