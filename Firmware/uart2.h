//uart2.h
#ifndef _UART2_H
#define _UART2_H

#include <inttypes.h>
#include <stdio.h>


#if defined(__cplusplus)
extern "C" {
#endif //defined(__cplusplus)

#ifndef DISABLE_MMU

extern FILE _uart2io;
#define uart2io (&_uart2io)


extern void uart2_init(void);

extern int8_t uart2_rx_str_P(const char* str);
#endif //_UART2_H


#if defined(__cplusplus)
}
#endif

#endif //defined(__cplusplus)
