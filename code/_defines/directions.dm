#define REVERSE_DIR(dir) ((dir & 10) >> 1 | (dir & 5) << 1)
#define IS_ORDINAL(dir) ((dir - 1) & dir)
#define PERPEND_DIR(dir) ((dir & 3) << 2 | (dir & 12) >> 2)