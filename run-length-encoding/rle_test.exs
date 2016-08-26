if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("rle.exs")
end

ExUnit.start
#ExUnit.configure exclude: :encode, trace: true

defmodule RunLengthEncoderTest do
  use ExUnit.Case

  @tag :encode
  test "empty string returns empty" do
    assert RunLengthEncoder.encode("") === ""
  end

  @tag :encode
  test "simple string gets encoded" do
    assert RunLengthEncoder.encode("AAA") === "3A"
  end

  @tag :encode
  test "more complicated string" do
    assert RunLengthEncoder.encode("HORSE") == "1H1O1R1S1E"
  end

  @tag :encode
  test "an even more complex string" do
    assert RunLengthEncoder.encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB") === "12W1B12W3B24W1B"
  end

  @tag :decode
  test "it decodes an encoded simple string" do
    assert RunLengthEncoder.decode("3A") === "AAA"
  end

  @tag :decode
  test "it decodes a more complicated string" do
    assert RunLengthEncoder.decode("12W1B12W3B24W1B") === "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
  end
end
