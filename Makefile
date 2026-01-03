.PHONY: test lint

test:
	nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal.vim'}"                                           ─╯

lint:
	luacheck lua/roo
