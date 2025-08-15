defmodule MyApp.Repo.Migrations.DropRepliesTable do
  use Ecto.Migration

  def change do
    drop table(:replies)
  end
end
