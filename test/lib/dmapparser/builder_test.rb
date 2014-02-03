require_relative '../../test_helper'

describe DMAPParser::Builder do
  before do
    @pair_data = DMAPParser::Builder.cmpa do
      cmpg 'AABBCCDDEE'
      cmnm 'Name'
      cmty 'iPod'
    end
  end

  it 'should return a valid string' do
    dmap = @pair_data.to_dmap
    dmap.must_be_instance_of String
    DMAPParser::Parser.parse(dmap).to_dmap.must_equal(dmap)
  end

  it 'should raise an exception if tags are put inside non-containers' do
    lambda do
      DMAPParser::Builder.cmnm do
        cmpg 'AABBCCDDEE'
        cmty 'iPod'
      end
    end.must_raise RuntimeError
  end

  it 'should return a TagContainer' do
    @pair_data.must_be_instance_of DMAPParser::TagContainer
  end

  it 'should store the correct values' do
    @pair_data.cmpg.must_equal 'AABBCCDDEE'
    @pair_data.cmnm.must_equal 'Name'
    @pair_data.cmty.must_equal 'iPod'
  end

  it 'should store the correct Tags' do
    @pair_data.get_tag(:cmpg).must_be_instance_of DMAPParser::Tag
    @pair_data.get_tag(:cmnm).must_be_instance_of DMAPParser::Tag
    @pair_data.get_tag(:cmty).must_be_instance_of DMAPParser::Tag
  end

  it 'should fail if there is no container' do
    -> { DMAPParser::Builder.cmnm }.must_raise RuntimeError
  end

  it 'should support deep nesting' do
    nested = DMAPParser::Builder.mcon do
      miid 0
      mcon do
        miid 1
        mcon do
          miid 2
          mcon do
            miid 3
          end
        end
      end
    end

    nested.must_be_instance_of DMAPParser::TagContainer
    mcon = nested
    3.times do |i|
      mcon.miid.must_equal i
      mcon = mcon.mcon
    end
    dmap = nested.to_dmap
    DMAPParser::Parser.parse(dmap).to_dmap.must_equal(dmap)
  end
end
