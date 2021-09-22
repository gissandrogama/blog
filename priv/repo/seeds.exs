# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Blog.{Accounts, Posts}

user = %{
  email: "gissandrogama@gmail.com",
  first_name: nil,
  image:
    "https://lh3.googleusercontent.com/a-/AOh14GiZkmHmmMIaY5Vl1B7uZmE5O27nOPDL6ShmCRG5=s96-c",
  last_name: nil,
  provider: "google",
  token:
    "ya29.a0ARrdaM93AwctsYLgu5_ZFEhpPkVmwnMJuW5ewQZ6LojuCkoM1qBoTTfQY1nRHiEmJTCJJ0gxg2QZMacslWV0cn7P87X-o3uocxDw1Le_gJxxZ-wtT-WqE0LdOLrdEQ_hkkcd6o0muIuD66nOVLqe-w55Nm0_tQ"
}

post_phoenix = %{
  title: "Phoenix framework",
  description:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
}

post_postgres = %{
  title: "Postgres data base",
  description:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
}

{:ok, user} = Accounts.create_user(user)

{:ok, _phoenix} = Posts.create_post(user, post_phoenix)
{:ok, _postgres} = Posts.create_post(user, post_postgres)
