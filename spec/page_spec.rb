require_relative 'spec_helper'

include SimplyPaginate

describe Page do
  context "when is empty" do
    let(:page) { Page.new(0, []) }
    subject { page }

    describe "#elements" do
      specify { expect(subject.elements).to be_nil }
    end

    describe "#next" do
      specify { expect(subject.next).to be_nil }
    end

    describe "#previous" do
      specify { expect(subject.previous).to be_nil }
    end

    describe "#==" do
      subject { page == other_page }
      let(:other_page) { double }

      context "when they are equal" do

        before(:each) do
          allow(other_page).to receive(:index).and_return(0)
          allow(other_page).to receive(:elements).and_return(nil)
        end

        specify { expect(subject).to eq(true) }
      end

      context "when they are different" do
        context "and other is not a page" do
          let(:other_page) { "definitely not a page" }
          specify { expect(subject).to eq(false) }
        end

        context "and the second has different values" do
          before(:each) do
            allow(other_page).to receive(:index).and_return(1)
            allow(other_page).to receive(:elements).and_return([])
          end

          specify { expect(subject).to eq(false) }
        end
      end
    end
  end

  context "when has elements" do
    let(:page) { Page.new(1, [1,2,3,4,5,6,7,8,9], 3) }
    subject { page }

    describe "#elements" do
      specify { expect(subject.elements).to eq([1,2,3]) }
    end

    describe "#next" do
      specify { expect(subject.next).to be_instance_of(Page) }
      specify { expect(subject.next.index).to eq(subject.index + 1) }
    end

    describe "#previous" do
      before(:each) { allow(page).to receive(:index).and_return(2) }

      specify { expect(subject.previous).to be_instance_of(Page) }
      specify { expect(subject.previous.index).to eq(subject.index - 1) }
    end

    describe "#==" do
      let(:other_page) { double }
      subject { page == other_page }

      context "when both are equal" do
        before(:each) do
          allow(other_page).to receive(:index).and_return(1)
          allow(other_page).to receive(:elements).and_return([1,2,3])
        end

        specify { expect(subject).to eq(true) }
      end

      context "when they are different" do
        context "and other is not a page" do
          let(:other_page) { "definitely not a page" }
          specify { expect(subject).to eq(false) }
        end

        context "because the second has different values" do
          before(:each) do
            allow(other_page).to receive(:index).and_return(1)
            allow(other_page).to receive(:elements).and_return([])
          end

          specify { expect(subject).to eq(false) }
        end
      end
    end
  end
end
