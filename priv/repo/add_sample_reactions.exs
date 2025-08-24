alias Slax.Accounts.User
alias Slax.Chat
alias Slax.Chat.Room
alias Slax.Repo

emojis = [
  "😁","😃","🔥","👍","👎","❤️","😘","🤨","👌","👏","✅","😢","☹️"
]

for room <- Room |> Repo.all() do
  room_data = Room |> Repo.get_by!(name: room.name) |> Repo.preload(:messages)

  users = Repo.all(User)

  for message <- room_data.messages do
    num_reactions = :rand.uniform(5) - 1

    if num_reactions > 0 do
      for _ <- (0..num_reactions) do
        Chat.add_reaction(
          Enum.random(emojis),
          message,
          Enum.random(users)
        )
      end
    end
  end
end
