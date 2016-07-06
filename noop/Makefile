C_TARGETS := noop

CC := gcc
CFLAGS := -static -Os -nostartfiles -fno-asynchronous-unwind-tables

.PHONY: all
all: $(C_TARGETS)

$(C_TARGETS): noop.c
	$(CC) $(CFLAGS) -o '$@' '$<'
	strip -R .comment -s '$@'

.PHONY: clean
clean:
	-rm -vrf $(C_TARGETS)

.PHONY: test
test: $(C_TARGETS)
	@for b in $^; do \
		( set -x && "./$$b" ); \
	done
