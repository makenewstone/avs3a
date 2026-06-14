#pragma once

#include "avs3_stat_dec.h"

#ifdef __cplusplus
extern "C" {
#endif

	AVS3DecoderHandle avs3_create_decoder();
	void avs3_destroy_decoder(AVS3DecoderHandle hAvs3Dec);
	int parse_header(AVS3DecoderHandle hAvs3Dec, unsigned char* pData, int nLenIn, int isInitFrame, int *pnLenConsumed, uint16_t *crc);
	int avs3_decode(AVS3DecoderHandle hAvs3Dec, unsigned char* pDataIN, int nLenIn, unsigned char* pDataOut, int *pnLenOut, int *pnLenConsumed);



#ifdef __cplusplus
}
#endif

