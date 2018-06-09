#include <unistd.h>
#include <stdbool.h>
#include <stdint.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <inttypes.h>
#define TESTOPT

//its highly possible that this function can be optimized ...
int64_t xyz_to_num(int64_t x,int64_t y,int64_t z){
	#ifdef DEBUG
		printf("xyz_to_num x: %"PRId64" y: %"PRId64" z: %"PRId64"\n" ,x,y,z);
	#endif
    if(y>x){
        return 0;
    }
    int64_t n = x*x;
    while(0 != y){
        int64_t _x = x;
        int64_t _y = y;
        int64_t _z = z;
        bool underflow = ((_y - _x + _z - 1)<0);
		#ifdef DEBUG
			printf("~x: %"PRId64" y: %"PRId64" z: %"PRId64"\n" ,x,y,z);
		#endif
		if (underflow){
			#ifdef TESTOPT
				int64_t i = (_x - _y)/(_z - 1);
				#ifdef DEBUG
					printf("!x: %"PRId64" y: %"PRId64" z: %"PRId64" i:%"PRId64"\n" ,x,y,z,i);
				#endif
				y = _y + _z*i;
				x = _x + i - 1;
				if(y>=x+1){
					y-=x+1;
					z--;
				}
				#ifdef DEBUG
					printf("#x: %"PRId64" y: %"PRId64" z: %"PRId64" i:%"PRId64"\n" ,x,y,z,i);
				#endif
			#else
				y = _y + _z;
			#endif

			
            //z = _z;
        }else{
            y = _y - _x + _z - 1;
            z = _z - 1;
            if((y - z) > 0){
                return 0;
            }
        }
        x += 1;
        
        if ((x==y) && (z!=1)){
            return 0;
        }
        if ((0==y) && (z!=1)){
            return 0;
        }
        if (z<0){
            return 0;
        }
    }
    if (x <= n){
        return 0;
    }
    return x;
}
int main(int argc,char** argv){
    FILE* f = fopen("tbl.csv","w+");
	char* str = "x,y,z,r\n";
	
	#ifdef DEBUG
		int64_t res = xyz_to_num(4,1,8);
		printf("res: %"PRId64,res);
		return(0);
	#endif
	
    fwrite(str,1,strlen(str),f);
	fflush(f);
    for(int64_t z=START;z<1000000000000;z++){
		//TODO: 0.49 seems to be save ... tested with example data set.
		//      still need to figure out that value mathematically
		for(int64_t x=(int)(z*0.49);x<=z;x++){
			//TODO: restrict values of y even more
			for(int64_t y=1;y<=x;y++){
				
                int64_t r = xyz_to_num(x,y,z);
				fflush(stdout);
                if(r==0){
                    continue;
                }
                char buf[1024*10];
				int n = sprintf(&buf[0],"%"PRId64",%"PRId64",%"PRId64",%"PRId64"\n" , x,y,z,r);
				printf("%"PRId64" %"PRId64" %"PRId64" r:%"PRId64"\n" ,x,y,z,r);
                fwrite(&buf[0],1,n,f);
				fflush(f);
			}
		}
    }
    fclose(f);
}