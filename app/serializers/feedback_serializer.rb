class FeedbackSerializer < ActiveModel::Serializer
    attribute :id, if: :assessment_present?
    attribute :review, if: :assessment_present?
    attribute :created_by, if: :assessment_present?

    def assessment_present?
      true if current_user.id == object.created_by
    end
end
