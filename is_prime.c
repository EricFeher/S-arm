#include <stdio.h>

extern int is_prime(int value);

int main(){
    int result=is_prime(7);
    printf ( "Prim? %d\n",result);
    return 0;
}

