class IssueCustomerHooks < Redmine::Hook::ViewListener
  # Renders the Customer name
  #
  # Context:
  # * :issue => Issue being rendered
  #
  def view_issues_show_details_bottom(context = { })
    if context[:project].module_enabled?('customer_module')
      data = "<td><b>"
      data += l(:field_customer)
      data += ":</b></td><td>#{html_escape context[:issue].customer.name unless context[:issue].customer.nil?}</td>"
      return "<tr>#{data}<td></td></tr>"
    else
      return ''
    end
  end

  # Renders a select tag with all the Customers
  #
  # Context:
  # * :form => Edit form
  # * :project => Current project
  #
  def view_issues_form_details_bottom(context = { })
    if context[:project].module_enabled?('customer_module')
      select = context[:form].select :customer_id, Customer.find(:all).collect { |d| [d.name, d.id] }, :include_blank => true 
      return "<p>#{select}</p>"
    else
      return ''
    end
  end

  # Renders a select tag with all the Customers for the bulk edit page
  #
  # Context:
  # * :project => Current project
  #
  def view_issues_bulk_edit_details_bottom(context = { })
    if context[:project].module_enabled?('customer_module')
      select = select_tag('customer_id',
                               content_tag('option', l(:label_no_change_option), :value => '') +
                               content_tag('option', l(:label_none), :value => 'none') +
                               options_from_collection_for_select(Customer.find(:all), :id, :name))
    
      return content_tag(:p, "<label>#{l(:field_customer)}: " + select + "</label>")
    else
      return ''
    end
  end
  
  # Saves the Customer assignment to the issue
  #
  # Context:
  # * :issue => Issue being saved
  # * :params => HTML parameters
  #
  def controller_issues_bulk_edit_before_save(context = { })
    case true
    when context[:params][:customer_id].blank?
      # Do nothing
    when context[:params][:customer_id] == 'none'
      # Unassign customer
      context[:issue].customer = nil
    else
      context[:issue].customer = Customer.find(context[:params][:customer_id])
    end
    return ''
  end

  # Little helper to check whether the object is numeric (id)
  def numeric?(object)
    true if Float(object) rescue false
  end
 
  # Customer changes for the journal use the Customer name
  # instead of the id
  #
  # Context:
  # * :detail => Detail about the journal change
  #
  def helper_issues_show_detail_after_setting(context = { })
    # TODO Later: Overwritting the caller is bad juju
    if context[:detail].prop_key == 'customer_id'
      if numeric? context[:detail].value
        d = Customer.find_by_id(context[:detail].value)
        context[:detail].value = d.name unless d.nil? || d.name.nil?
      end
      if numeric? context[:detail].old_value
        d = Customer.find_by_id(context[:detail].old_value)
        context[:detail].old_value = d.name unless d.nil? || d.name.nil?      
      end
    end
    ''
  end
end
