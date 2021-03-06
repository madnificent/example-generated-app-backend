defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  ## START GENERATED PROXY RULES
  match "/pipelines/*path" do
    Proxy.forward conn, path, "http://resource/pipelines/"
  end
  match "/steps/*path" do
    Proxy.forward conn, path, "http://resource/steps/"
  end
  match "/docker-composes/*path" do
    Proxy.forward conn, path, "http://resource/docker-composes/"
  end
  match "/container-items/*path" do
    Proxy.forward conn, path, "http://resource/container-items/"
  end
  match "/container-groups/*path" do
    Proxy.forward conn, path, "http://resource/container-groups/"
  end
  match "/container-relations/*path" do
    Proxy.forward conn, path, "http://resource/container-relations/"
  end
  match "/pipeline-instances/*path" do
    Proxy.forward conn, path, "http://resource/pipeline-instances/"
  end
  match "/services/*path" do
    Proxy.forward conn, path, "http://resource/services/"
  end
  match "/stacks/*path" do
    Proxy.forward conn, path, "http://resource/stacks/"
  end
  match "/statuses/*path" do
    Proxy.forward conn, path, "http://resource/statuses/"
  end
  ## END GENERATED PROXY RULES


  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
