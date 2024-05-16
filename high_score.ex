defmodule HighScore do
  @initial_score 0
  
  def new() do
    %{}
  end

  def add_player(scores, name, score \\ @initial_score) do
    Map.put_new(scores, name, score)
  end

  def remove_player(scores, name) do
    {_, updated_map} = Map.pop(scores, name)
    updated_map
  end

  def reset_score(scores, name) do
    remove_player(scores, name)
    |> add_player(name)
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, fn old_score -> old_score + score end)
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end
