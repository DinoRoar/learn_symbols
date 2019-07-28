defmodule TextToSpeech do
  @moduledoc """
  Documentation for TextToSpeech.
  """

  require Logger

  @doc """
  Hello world.

  ## Examples

      iex> TextToSpeech.hello()
      :world

  """
  def get_audio_for(text) do
    raw_response = HTTPotion.post url(), [body: build_body(text), headers: ["Content-Type": "application/json"]]
    raw_response
  end

  defp build_body(text) do
    """
  {
      "audioConfig": {
        "audioEncoding": "LINEAR16",
        "pitch": 0,
        "speakingRate": 1
      },
      "input": {
        "text": "#{text}"
      },
      "voice": {
        "languageCode": "en-US",
        "name": "en-US-Wavenet-D"
      }
    }
"""
  end

  defp url do
    api_key = Application.get_env(:text_to_speech, :api_key)
    Logger.debug api_key;
    "https://texttospeech.googleapis.com/v1beta1/text:synthesize?key=#{api_key}"
    end
end
