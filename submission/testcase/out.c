#include "io.h"
int main() {
    char c;
    for (int i = 1; i < 70; i++)
        c = inb(), outb(c), outb(' '), outl(c), outb('\t');
}