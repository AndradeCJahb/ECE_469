#define PUSHBUTTONS ((volatile long *) 0xFF200050)
#define LEDS ((volatile long*) 0xFF200000)
int main() {
	int butval;
	while (1) {
  		butval = *PUSHBUTTONS;
  		*LEDS = butval;
	}
	return 0;
}
