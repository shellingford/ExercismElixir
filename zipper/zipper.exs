defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do

  defstruct focused: nil, parent_chain: []

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    %Zipper{focused: bt}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(%Zipper{focused: nil}), do: nil
  def to_tree(%Zipper{focused: focused, parent_chain: []}), do: focused

  def to_tree(%Zipper{focused: focused, parent_chain: [{value, nil, right, :left} | parent_chain]}) do
    to_tree(%Zipper{focused: %BinTree{ value: value, left: focused, right: right}, parent_chain: parent_chain})
  end

  def to_tree(%Zipper{focused: focused, parent_chain: [{value, left, nil, :right} | parent_chain]}) do
    to_tree(%Zipper{focused: %BinTree{ value: value, left: left, right: focused}, parent_chain: parent_chain})
  end


  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(%Zipper{focused: nil}), do: nil
  def value(z) do
    z.focused.value
  end

  @doc """
  Get the left child of the focus node, if any. 
  """
  @spec left(Z.t) :: Z.t | nil
  def left(%Zipper{focused: %BinTree{ value: _value, left: nil, right: _right}}), do: nil
  def left(%Zipper{focused: _focused = %BinTree{ value: value, left: left, right: right}, parent_chain: parent_chain}) do
    %Zipper{focused: left, parent_chain: [ {value, nil, right, :left} | parent_chain]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(%Zipper{focused: %BinTree{ value: _value, left: _left, right: nil}}), do: nil
  def right(%Zipper{focused: _focused = %BinTree{ value: value, left: left, right: right}, parent_chain: parent_chain}) do
    %Zipper{focused: right, parent_chain: [{value, left, nil, :right}  | parent_chain]}
  end

  @doc """
  Get the parent_chain of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up(%Zipper{focused: _bt, parent_chain: []}), do: nil
  def up(%Zipper{focused: bt, parent_chain: [{value, nil, right, :left} | parent_chain]}) do
    %Zipper{focused:  %BinTree{ value: value, left: bt, right: right}, parent_chain: parent_chain}
  end

  def up(%Zipper{focused: bt, parent_chain: [{value, left, nil, :right} | parent_chain]}) do
    %Zipper{focused:  %BinTree{ value: value, left: left, right: bt}, parent_chain: parent_chain}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(%Zipper{focused: bt, parent_chain: parent_chain}, new_value) do
    %Zipper{focused:  %BinTree{ value: new_value, left: bt.left, right: bt.right}, parent_chain: parent_chain}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(%Zipper{focused: bt, parent_chain: parent_chain}, new_left_leaf) do
    %Zipper{focused:  %BinTree{ value: bt.value, left: new_left_leaf, right: bt.right}, parent_chain: parent_chain}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(%Zipper{focused: bt, parent_chain: parent_chain}, new_right_leaf) do
    %Zipper{focused:  %BinTree{ value: bt.value, left: bt.left, right: new_right_leaf}, parent_chain: parent_chain}
  end
end
