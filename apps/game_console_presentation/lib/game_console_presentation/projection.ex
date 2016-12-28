defmodule Projections.Projection do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Ecto.Query

     alias Projections.{Projection,ProjectionVersion}
     alias GameConsolePresentation.Repo

      def update_projection(projection_name, event_id, multi_fn) do
        multi =
          Ecto.Multi.new
          |> Ecto.Multi.run(:verify_projection_version, fn _ ->
            version = case Repo.get(ProjectionVersion, projection_name) do
              nil -> Repo.insert!(%ProjectionVersion{projection_name: projection_name, last_seen_event_id: 0})
              version -> version
            end

            if version.last_seen_event_id < event_id do
              {:ok, %{version: version}}
            else
              {:error, :already_seen_event}
            end
          end)
          |> Ecto.Multi.update(:projection_version, ProjectionVersion.changeset(%ProjectionVersion{projection_name: projection_name}, %{last_seen_event_id: event_id}))

        multi = apply(multi_fn, [multi])

        case Repo.transaction(multi) do
          {:ok, _changes} -> :ok
          {:error, :verify_projection_version, :already_seen_event, _changes_so_far} -> :ok
          {:error, stage, reason, _changes_so_far} -> {:error, reason}
        end
      end
    end
  end
end
