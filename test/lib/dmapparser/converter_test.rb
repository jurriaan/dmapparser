require_relative '../../test_helper'

describe DMAPParser::Converter do
  it 'should return the original output again' do
    time = Time.now
    klass = DMAPParser::Converter
    klass.bin_to_date(klass.date_to_bin(time)).to_i.must_equal time.to_i
    klass.bin_to_bool(klass.bool_to_bin(true)).must_equal true
    klass.bin_to_int(klass.int_to_bin(90000)).must_equal 90000
    klass.bin_to_byte(klass.byte_to_bin(190)).must_equal 190
    klass.bin_to_long(klass.long_to_bin(3**25)).must_equal 3**25
    klass.bin_to_version(klass.version_to_bin('1322.200.3')).must_equal '1322.200.3'
    klass.bin_to_short(klass.short_to_bin(19007)).must_equal 19007
  end
  
  it 'should automatically convert numerics' do
    klass = DMAPParser::Converter
    byte = klass.byte_to_bin(244)
    short = klass.short_to_bin(244)
    int = klass.int_to_bin(244)
    long =  klass.long_to_bin(244)
    klass.data_to_numeric(byte).must_equal(244)
    klass.data_to_numeric(short).must_equal(244)
    klass.data_to_numeric(int).must_equal(244)
    klass.data_to_numeric(long).must_equal(244)
  end
  
  it 'should decode unknown types' do
    klass = DMAPParser::Converter
    byte = klass.byte_to_bin(244)
    klass.decode(:ZZZZ, byte).must_equal 244
  end
  
  it 'should encode unknown strings' do
    klass = DMAPParser::Converter
    klass.encode(:ZZZZ, 'aaa').must_equal 'aaa'
  end
end
