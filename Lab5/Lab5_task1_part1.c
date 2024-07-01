#define LED ((volatile long *) 0xFF200000)
int main() {
    *LED = 0x3FF;
    return 0;
}
