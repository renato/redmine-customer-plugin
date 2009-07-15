require_dependency 'issue'
 
# Patches Redmine's Issues dynamically. Adds a relationship
# Issue +has_many+ to IssueResource
module IssuePatch
  def self.included(base) # :nodoc:
    # Same as typing in the class
    base.class_eval do
      belongs_to :customer
    end
  end
end
 
Issue.send(:include, IssuePatch)
