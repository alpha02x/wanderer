defmodule WandererApp.Repo.Migrations.ShipTypes do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:ship_type_infos_v1, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
      add :type_id, :bigint
      add :group_id, :bigint
      add :name, :text
      add :description, :text
      add :mass, :text
      add :capacity, :text
      add :volume, :text

      add :inserted_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")
    end

    create unique_index(:ship_type_infos_v1, [:type_id], name: "ship_type_infos_v1_type_id_index")
  end

  def down do
    drop_if_exists unique_index(:ship_type_infos_v1, [:type_id],
                     name: "ship_type_infos_v1_type_id_index"
                   )

    drop table(:ship_type_infos_v1)
  end
end