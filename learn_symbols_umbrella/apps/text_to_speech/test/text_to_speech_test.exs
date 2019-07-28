defmodule TextToSpeechTest do
  use ExUnit.Case
  doctest TextToSpeech

  test "greets the world" do
    assert TextToSpeech.hello() == :world
  end
end
