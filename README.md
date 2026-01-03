# Roo.nvim

A simple tool for jumping between buffers.  In this plugin, the idea of jumping between buffers is treated much like jumping directly between tabs in a browser or task bar (Ctrl-1 through Ctrl-9).  Buffers can be assigned to an index between 1 and 9, and then the current window can be set to display a buffer by index.

## Installation

Using Lazy:

```lua
{
    'kburgon/roo.nvim'
}
```

## Usage

The following vim commands are available for use:

- `RooSet {index} {buffnum}`: Marks the specified buffer for the given index.  If `{buffnum}` is not included the current buffer will be used
- `RooJump {index}`: Jump to the buffer at the given index
- `RooList`: Prints a list of all the marked buffers and their indexes


