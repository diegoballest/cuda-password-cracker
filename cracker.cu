/*
	@Author Diego Alfredo Ballesteros Bautista - A01271588
	Copyright (C) 2018 Diego Alfredo Ballesteros Bautista
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <algorithm>
#include <iostream>
#include <string>
#include <set>
#include <stdio.h>
#include "cuda_runtime.h"

#define N (10*10)

__global__ void getPermutationsGPU(int len, int min, int max, char *pass, int *ans){

	*ans = 0;
	int tid = threadIdx.x + blockIdx.x*blockDim.x;
	switch (len){

	case 1:
		if (tid + min == pass[0]){
			*ans = 1;
			printf("FOUND GPU: %s\n", pass);
			__threadfence();
			asm("trap;");
		}
		break;

	case 2:
		if (blockIdx.x + min == pass[0] && threadIdx.x + min == pass[1]){
			*ans = 1;
			printf("FOUND GPU: %s\n", pass);
			__threadfence();
			asm("trap;");
		}
		break;

	case 3:
		for (int c1 = min; c1 < max; c1++){
			if (c1 == pass[0] && blockIdx.x + min == pass[1] && threadIdx.x + min == pass[2]){
				*ans = 1;
				printf("FOUND GPU: %s\n", pass);
				__threadfence();
				asm("trap;");
			}
		}
		break;

	case 4:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				if (c1 == pass[0] && c2 == pass[1] && blockIdx.x + min == pass[2] && threadIdx.x + min == pass[3]){
					*ans = 1;
					printf("FOUND GPU: %s\n", pass);
					__threadfence();
					asm("trap;");
				}
			}
		}
		break;

	case 5:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					if (c1 == pass[0] && c2 == pass[1] && c3 == pass[2] && blockIdx.x + min == pass[3] && threadIdx.x + min == pass[4]){
						*ans = 1;
						printf("FOUND GPU: %s\n", pass);
						__threadfence();
						asm("trap;");
					}
				}
			}
		}
		break;

	case 6:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					for (int c4 = min; c4 < max; c4++){
						if (c1 == pass[0] && c2 == pass[1] && c3 == pass[2] && c4 == pass[3] && blockIdx.x + min == pass[4] && threadIdx.x + min == pass[5]){
							*ans = 1;
							printf("FOUND GPU: %s\n", pass);
							__threadfence();
							asm("trap;");
						}
					}
				}
			}
		}
		break;

	case 7:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					for (int c4 = min; c4 < max; c4++){
						for (int c5 = min; c5 < max; c5++){
							if (c1 == pass[0] && c2 == pass[1] && c3 == pass[2] && c4 == pass[3] && c5 == pass[4] && blockIdx.x + min == pass[5] && threadIdx.x + min == pass[6]){
								*ans = 1;
								printf("FOUND GPU: %s\n", pass);
								__threadfence();
								asm("trap;");
							}
						}
					}
				}
			}
		}
		break;
	case 8:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					for (int c4 = min; c4 < max; c4++){
						for (int c5 = min; c5 < max; c5++){
							for (int c6 = min; c6 < max; c6++){
								if (c1 == pass[0] && c2 == pass[1] && c3 == pass[2] && c4 == pass[3] && c5 == pass[4] && c6 == pass[5] && blockIdx.x + min == pass[6] && threadIdx.x + min == pass[7]){
									*ans = 1;
									printf("FOUND GPU: %s\n", pass);
									__threadfence();
									asm("trap;");
								}
							}
						}
					}
				}
			}
		}
		break;
	default:
		break;
	}

}

void getPermutationsCPU(int len, int min, int max, char *pass){
	int found = 0;
	switch (len){

	case 1:
		for (int c1 = min; c1 < max; c1++){
			if (pass[0] == c1){

				found = 1;
				printf("Found CPU: %s\n", pass);
				return;
			}
		}
		if (found == 0){
			printf("Password not Found in CPU \n");
		}
		break;

	case 2:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				if (pass[0] == c1 && pass[1] == c2){
					found = 1;
					printf("Found CPU: %s\n", pass);
					return;
				}
			}
		}
		if (found == 0){
			printf("Password not Found in CPU \n");
		}
		break;

	case 3:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					if (pass[0] == c1 && pass[1] == c2 && pass[2] == c3){
						found = 1;
						printf("Found CPU: %s\n", pass);
						return;
					}
				}
			}
		}
		if (found == 0){
			printf("Password not Found in CPU \n");
		}
		break;

	case 4:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					for (int c4 = min; c4 < max; c4++){
						if (pass[0] == c1 && pass[1] == c2 && pass[2] == c3 && pass[3] == c4){
							found = 1;
							printf("Found CPU: %s\n", pass);
							return;
						}
					}
				}
			}
		}
		if (found == 0){
			printf("Password not Found in CPU \n");
		}
		break;

	case 5:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					for (int c4 = min; c4 < max; c4++){
						for (int c5 = min; c5 < max; c5++){
							if (pass[0] == c1 && pass[1] == c2 && pass[2] == c3 && pass[3] == c4 && pass[4] == c5){
								found = 1;
								printf("Found CPU: %s\n", pass);
								return;
							}
						}
					}
				}
			}
		}
		if (found == 0){
			printf("Password not Found in CPU \n");
		}
		break;

	case 6:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					for (int c4 = min; c4 < max; c4++){
						for (int c5 = min; c5 < max; c5++){
							for (int c6 = min; c6 < max; c6++){
								if (pass[0] == c1 && pass[1] == c2 && pass[2] == c3 && pass[3] == c4 && pass[4] == c5 && pass[5] == c6){
									found = 1;
									printf("Found CPU: %s\n", pass);
									return;
								}
							}
						}
					}
				}
			}
		}
		if (found == 0){
			printf("Password not Found in CPU \n");
		}
		break;

	case 7:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					for (int c4 = min; c4 < max; c4++){
						for (int c5 = min; c5 < max; c5++){
							for (int c6 = min; c6 < max; c6++){
								for (int c7 = min; c7 < max; c7++){
									if (pass[0] == c1 && pass[1] == c2 && pass[2] == c3 && pass[3] == c4 && pass[4] == c5 && pass[5] == c6 && pass[6] == c7){
										found = 1;
										printf("Found CPU: %s\n", pass);
										return;
									}
								}
							}
						}
					}
				}
			}
		}
		if (found == 0){
			printf("Password not Found in CPU \n");
		}
		break;
	case 8:
		for (int c1 = min; c1 < max; c1++){
			for (int c2 = min; c2 < max; c2++){
				for (int c3 = min; c3 < max; c3++){
					for (int c4 = min; c4 < max; c4++){
						for (int c5 = min; c5 < max; c5++){
							for (int c6 = min; c6 < max; c6++){
								for (int c6 = min; c6 < max; c6++){
									for (int c7 = min; c7 < max; c7++){
										for (int c8 = min; c8 < max; c8++){
											if (pass[0] == c1 && pass[1] == c2 && pass[2] == c3 && pass[3] == c4 && pass[4] == c5 && pass[5] == c6 && pass[6] == c7 && pass[7] == c8){
												found = 1;
												printf("Found CPU: %s\n", pass);
												return;
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		if (found == 0){
			printf("Password not Found in CPU \n");
		}
		break;
	default:
		printf("Password too long");
		break;
	}
}

void menu(){

	printf("  /$$$$$$                  /$$                                                    \n");
	printf(" /$$__  $$                | $$                                                    \n");
	printf("| $$  \\__/ /$$   /$$  /$$$$$$$  /$$$$$$                                           \n");
	printf("| $$      | $$  | $$ /$$__  $$ |____  $$                                          \n");
	printf("| $$      | $$  | $$| $$  | $$  /$$$$$$$                                          \n");
	printf("| $$    $$| $$  | $$| $$  | $$ /$$__  $$                                          \n");
	printf("|  $$$$$$/|  $$$$$$/|  $$$$$$$|  $$$$$$$                                          \n");
	printf(" \\______/  \\______/  \\_______/ \\_______/                                          \n");
	printf(" /$$$$$$$                                                                      /$$\n");
	printf("| $$__  $$                                                                    | $$\n");
	printf("| $$  \\ $$ /$$$$$$   /$$$$$$$ /$$$$$$$ /$$  /$$  /$$  /$$$$$$   /$$$$$$   /$$$$$$$\n");
	printf("| $$$$$$$/|____  $$ /$$_____//$$_____/| $$ | $$ | $$ /$$__  $$ /$$__  $$ /$$__  $$\n");
	printf("| $$____/  /$$$$$$$|  $$$$$$|  $$$$$$ | $$ | $$ | $$| $$  \\ $$| $$  \\__/| $$  | $$\n");
	printf("| $$      /$$__  $$ \\____  $$\\____  $$| $$ | $$ | $$| $$  | $$| $$      | $$  | $$\n");
	printf("| $$     |  $$$$$$$ /$$$$$$$//$$$$$$$/|  $$$$$/$$$$/|  $$$$$$/| $$      |  $$$$$$$\n");
	printf("|__/      \\_______/|_______/|_______/  \\_____/\\___/  \\______/ |__/       \\_______/\n");
	printf("  /$$$$$$                               /$$                                       \n");
	printf(" /$$__  $$                             | $$                                       \n");
	printf("| $$  \\__/  /$$$$$$  /$$$$$$   /$$$$$$$| $$   /$$  /$$$$$$   /$$$$$$              \n");
	printf("| $$       /$$__  $$|____  $$ /$$_____/| $$  /$$/ /$$__  $$ /$$__  $$             \n");
	printf("| $$      | $$  \\__/ /$$$$$$$| $$      | $$$$$$/ | $$$$$$$$| $$  \\__/             \n");
	printf("| $$    $$| $$      /$$__  $$| $$      | $$_  $$ | $$_____/| $$                   \n");
	printf("|  $$$$$$/| $$     |  $$$$$$$|  $$$$$$$| $$ \\  $$|  $$$$$$$| $$                   \n");
	printf(" \\______/ |__/      \\_______/ \\_______/|__/  \\__/ \\_______/|__/                   \n");

	printf("\n");
	printf("1) Lower case\n");
	printf("2) Upper case\n");
	printf("3) Numbers\n");
	printf("4) All (Lower case, Upper case, Numbers and Symbols)\n");
}

int main(){

	//const int isize = N*sizeof(int);
	const int csize = N*sizeof(char);
	const int isize = N*sizeof(int);

	int opc;
	int min, max;
	menu();
	scanf("%i", &opc);
	switch (opc){
	case 1:
		min = 97;
		max = 123;
		break;
	case 2:
		min = 65;
		max = 91;
		break;
	case 3:
		min = 48;
		max = 58;
		break;
	case 4:
		min = 33;
		max = 127;
		break;
	default:
		printf("No option found\n");
	}
	char pass[100];
	printf("Password = ");
	scanf("%s", &pass);

	int *ans = 0;
	int len = strlen(pass);

	if (strlen(pass) > 8){
		printf("\n Password too long\n");
		return 0;
	}
	printf("-----------------------\n");

	char *d_pass;
	int *d_ans;

	ans = (int*)malloc(isize);
	cudaMalloc((void**)&d_pass, csize);
	cudaMalloc((void**)&d_ans, isize);

	cudaMemcpy(d_pass, pass, csize, cudaMemcpyHostToDevice);

	//cudaDeviceSetLimit(cudaLimitPrintfFifoSize, 9999999999);


	clock_t timeOnGpu = clock();
	if (len == 1){
		getPermutationsGPU << <1, max - min >> > (len, min, max, d_pass, d_ans);
	}
	else {
		getPermutationsGPU << <max - min, max - min >> > (len, min, max, d_pass, d_ans);
	}

	cudaMemcpy(ans, d_ans, csize, cudaMemcpyDeviceToHost);

	if (*ans == 0){
		printf("Password not Found in GPU \n");
	}

	double gpuTime = (((double)clock() - timeOnGpu) / CLOCKS_PER_SEC);
	printf("Time on GPU %fs\n", gpuTime);

	printf("-----------------------\n");

	clock_t timeOnCpu = clock();
	getPermutationsCPU(len, min, max, pass);
	double cpuTime = (((double)clock() - timeOnGpu) / CLOCKS_PER_SEC);
	printf("Time on CPU %fs\n", cpuTime);

	printf("-----------------------\n");

	if (timeOnGpu < timeOnCpu){
		printf("GPU is %f times faster\n", cpuTime / gpuTime);
	}
	else if (timeOnGpu > timeOnCpu){
		printf("CPU is %f times faster\n", gpuTime / cpuTime);
	}

	free(ans);
	cudaFree(d_pass);
	cudaFree(d_ans);
}
