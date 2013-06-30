Code.require_file "test_helper.exs", __DIR__

defmodule TestUnitTest do
  use ExUnit.Case

  test "the truth" do
      assert true
      refute false
  end

  test "exceptions" do
      assert_raise ArithmeticError, 
          "bad argument in arithmetic expression", 
              fn ->
                 1 + "test"
              end
  end
end

defmodule CallbacksTest do
    use ExUnit.Case, async: true

    setup_all do
        IO.puts "This is a global setup callback"
        :ok
    end

    teardown_all do
        IO.puts "This is a global teardown callback"
        :ok
    end

    setup do
        IO.puts "This is a setup callback"
        { :ok, from_setup: :hello }
    end

    teardown meta do
        IO.puts "This is a teardown callback"
        assert meta[:from_setup] == :hello
        :ok
    end
    
    test "test meta", meta do
        assert meta[:from_setup] == :hello
    end

    test "the truth 1" do
        IO.puts "\tInside the test 1"
        assert true
    end

    test "the truth 2" do
        IO.puts "\tInside the test 2"
        assert true
    end

end