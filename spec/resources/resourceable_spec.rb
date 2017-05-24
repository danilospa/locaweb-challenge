# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Resourceable, type: :resource do
  describe '#to_h' do
    subject { custom_class.new.to_h }

    context 'when instance class does not have a super class' do
      let(:custom_class) do
        custom_class = Class.new.send(:include, described_class)
        custom_class.class_eval do
          def custom_method
            'custom method response'
          end
        end

        custom_class
      end

      it 'returns methods and values as hash' do
        expect(subject).to eq 'custom_method' => 'custom method response'
      end
    end

    context 'when instance class has a super class' do
      let(:custom_class) do
        parent_class = Class.new.send(:include, described_class)
        parent_class.class_eval do
          def super_class_custom_method
            'super class custom method response'
          end
        end

        custom_class = Class.new(parent_class)
        custom_class.class_eval do
          def custom_method
            'custom method response'
          end
        end

        custom_class
      end

      it 'returns methods and values from instance and from super class as hash' do
        expected = {
          'super_class_custom_method' => 'super class custom method response',
          'custom_method' => 'custom method response'
        }
        expect(subject).to eq expected
      end
    end
  end
end
