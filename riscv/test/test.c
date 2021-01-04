//#include "io.h"

int main(){

	//outlln(1);
	int a[2];
	a[0] = 0;
	a[1] = 1;
	for (int i = 0; i < 2; i++)
		if (a[i] != i)
			while(1);
}
