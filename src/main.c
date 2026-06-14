/* ==========================================================================
   AVS3 Audio Decoder — CLI entry point.
   Validates arguments and bridges to _main() in decoder.c.
   ========================================================================== */

#include <stdio.h>
#include <stdlib.h>

extern int _main(int argc, char *argv[]);

static void print_usage(const char *prog)
{
    fprintf(stderr, "Usage:\n");
    fprintf(stderr, "  %s <input.avs3a> <output.wav>\n", prog);
}

int main(int argc, char *argv[])
{
    if (argc < 3) {
        print_usage(argv[0]);
        return EXIT_FAILURE;
    }

    return _main(argc, argv);
}
