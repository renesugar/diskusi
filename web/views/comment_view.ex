###
# File     : comment_view.ex
# License  :
#   Copyright (c) 2017 Herdy Handoko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
###
defmodule Diskusi.CommentView do
  @moduledoc """
  Comment view template.
  """

  use Diskusi.Web, :view

  @doc """
  All comments result JSON template.
  """
  @spec render(String.t, map) :: map
  def render("index.json", %{comments: comments}) do
    %{
      success: true,
      results: Enum.map(comments, &comment_json/1)
    }
  end

  @doc """
  Single comment result JSON template.
  """
  def render("show.json", %{comment: comment}) do
    %{
      success: true,
      result: comment_json(comment)
    }
  end

  @doc """
  Comment created response JSON template.
  """
  def render("created.json", %{message: message, comment: comment}) do
    %{
      success: true,
      message: message,
      result: comment_json(comment)
    }
  end

  @doc """
  Comment JSON model.
  """
  @spec comment_json(Diskusi.Comment.t) :: map
  def comment_json(comment) do
    level = if is_nil(comment.level), do: 0, else: comment.level

    %{
      ref: comment.ref,
      author: comment.author,
      text: comment.text,
      level: level,
      created: comment.inserted_at,
      updated: comment.updated_at
    }
  end
end
