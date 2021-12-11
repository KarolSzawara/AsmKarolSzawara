#include "pch.h"
#include "cheader.h"

void sepiaC(BYTE* image, int start, int stop, int tone, int depth)
{
	for (int i = start; i <= stop - 32; i += 32) {
		int avarge = image[i];

		avarge += image[i + 1];

		avarge += image[i + 2];

		avarge /= 3;

		image[i] = avarge;

		image[i + 1] = avarge;

		image[i + 2] = avarge;

		avarge = image[i + 4];

		avarge = image[i + 5];

		avarge = image[i + 6];

		avarge /= 3;

		image[i + 4] = avarge;

		image[i + 5] = avarge;

		image[i + 6] = avarge;

		avarge = image[i + 8];

		avarge = image[i + 9];

		avarge = image[i + 10];

		avarge /= 3;

		image[i + 8] = avarge;

		image[i + 9] = avarge;

		image[i + 10] = avarge;

		avarge += image[i + 12];

		avarge += image[i + 13];

		avarge += image[i + 14];

		avarge /= 3;

		image[i + 12] = avarge;

		image[i + 13] = avarge;

		image[i + 14] = avarge;

		avarge = image[i + 16];

		avarge = image[i + 17];

		avarge = image[i + 18];

		avarge /= 3;

		image[i + 16] = avarge;

		image[i + 17] = avarge;

		image[i + 18] = avarge;

		avarge = image[i + 20];

		avarge = image[i + 21];

		avarge = image[i + 22];

		avarge /= 3;

		image[i + 20] = avarge;

		image[i + 21] = avarge;

		image[i + 22] = avarge;

		avarge = image[i + 24];

		avarge = image[i + 25];

		avarge = image[i + 26];

		avarge /= 3;

		image[i + 24] = avarge;

		image[i + 25] = avarge;

		image[i + 26] = avarge;

		avarge = image[i + 28];

		avarge = image[i + 29];

		avarge = image[i + 30];

		avarge /= 3;

		image[i + 28] = avarge;

		image[i + 29] = avarge;

		image[i + 30] = avarge;

		


	}
	for (int i = start; i <= stop - 4; i += 4) {
		if (image[i] < depth)
			image[i] = 0;
		else
			image[i] -= depth;
		if (image[i + 1] > (255 - tone))

			image[i + 1] = 255;
		else
			image[i + 1] += tone;
		if (image[i + 2] > (255 - 2 * tone))

			image[i + 2] = 255;
		else
			image[i + 2] += (2 * tone);
	}
}