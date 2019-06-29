defmodule LearnSymbols.Repo.Migrations.CreateUserProfileAndSymbols do
  use Ecto.Migration

  def change do
    create table(:user_profiles) do
      add :provider_id, :string
      add :name, :string

      timestamps()
    end

    create index(:user_profiles, [:provider_id])

    create table(:symbols) do
      add :symbol, :string
      add :next_show, :utc_datetime
      add :correct_answers, :integer
      add :user_id, references(:user_profiles)

      timestamps()
    end

    create unique_index(:symbols, [:user_id, :symbol])

  end
end
