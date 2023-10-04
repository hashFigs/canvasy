defmodule CanvasApp.Places.MyGeocoder do
  require HTTPoison

  #@google_maps_api_key  System.get_env("GOOGLE_MAPS_API_KEY")

  @google_geolocating_api_key  System.get_env("GOOGLE_GEOLOCATING_API_KEY")


  def geocode_address(address) do
   # encoded_address = URI.encode(address)

    base_url = "https://maps.googleapis.com/maps/api/geocode/json"

    query_params = [
      {"address", address},
      {"key", @google_geolocating_api_key}
    ]

    encoded_query = URI.encode_query(query_params)
    url = "#{base_url}?#{encoded_query}"

    case IO.inspect(HTTPoison.get(url)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, parse_geocode_response(body)}
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "HTTP request failed with status code #{status_code}: #{body}"}
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse_geocode_response(body) do
    case Jason.decode(body) do
      {:ok, %{"results" => [result]}} ->
        # Extract latitude and longitude
        {:ok, result["geometry"]["location"]}
      _ ->
        {:error, "Unable to parse geocode response"}
    end
  end
end
