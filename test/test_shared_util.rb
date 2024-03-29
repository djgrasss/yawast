require 'minitest/autorun'
require './lib/yawast'
require './test/base'
require 'colorize'

class TestSharedUtils < MiniTest::Unit::TestCase
  include TestBase

  def test_puts_error
    override_stdout

    Yawast::Utilities.puts_error 'test'
    assert_equal stdout_value, '[E]'.red + " test\n"

    restore_stdout
  end

  def test_puts_vuln
    override_stdout

    Yawast::Utilities.puts_vuln 'test'
    assert_equal stdout_value, '[V]'.magenta + " test\n"

    restore_stdout
  end

  def test_puts_warn
    override_stdout

    Yawast::Utilities.puts_warn 'test'
    assert_equal stdout_value, '[W]'.yellow + " test\n"

    restore_stdout
  end

  def test_puts_info
    override_stdout

    Yawast::Utilities.puts_info 'test'
    assert_equal stdout_value, '[I]'.green + " test\n"

    restore_stdout
  end
end
