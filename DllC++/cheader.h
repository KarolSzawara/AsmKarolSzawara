#pragma once
#ifdef CHEADER_EXPORTS
#define CHEADER_API __declspec(dllexport)
#else
#define CHEADER_API __declspec(dllimport)
#endif

extern "C" CHEADER_API void sepiaC(BYTE * image, int start, int stop, int tone, int depth);
