Received:  by oss.sgi.com id <S553886AbQKMP2A>;
	Mon, 13 Nov 2000 07:28:00 -0800
Received: from mx.mips.com ([206.31.31.226]:55222 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553844AbQKMP1g>;
	Mon, 13 Nov 2000 07:27:36 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA05493
	for <linux-mips@oss.sgi.com>; Mon, 13 Nov 2000 07:27:11 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA27952
	for <linux-mips@oss.sgi.com>; Mon, 13 Nov 2000 07:27:31 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id OAA29370
	for <linux-mips@oss.sgi.com>; Mon, 13 Nov 2000 14:20:54 +0100 (MET)
Message-ID: <3A0FEAB6.7117CC3C@mips.com>
Date:   Mon, 13 Nov 2000 14:20:54 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: The do_fast_gettimeoffset function
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

The do_fast_gettimeoffset function below (taken from
arch/mips/kernel/time.c) can only be used on 64-bit processors.
I would like to be able to use this on a 32-bit processor. As I'm not
completely sure what this function does, can someone who does please
help me out ?

/Carsten


static unsigned long do_fast_gettimeoffset(void)
{
 u32 count;
 unsigned long res, tmp;

 /* Last jiffy when do_fast_gettimeoffset() was called. */
 static unsigned long last_jiffies=0;
 unsigned long quotient;

 /*
  * Cached "1/(clocks per usec)*2^32" value.
  * It has to be recalculated once each jiffy.
  */
 static unsigned long cached_quotient=0;

 tmp = jiffies;

 quotient = cached_quotient;

 if (tmp && last_jiffies != tmp) {
  last_jiffies = tmp;
  __asm__(".set\tnoreorder\n\t"
   ".set\tnoat\n\t"
   ".set\tmips3\n\t"
   "lwu\t%0,%2\n\t"
   "dsll32\t$1,%1,0\n\t"
   "or\t$1,$1,%0\n\t"
   "ddivu\t$0,$1,%3\n\t"
   "mflo\t$1\n\t"
   "dsll32\t%0,%4,0\n\t"
   "nop\n\t"
   "ddivu\t$0,%0,$1\n\t"
   "mflo\t%0\n\t"
   ".set\tmips0\n\t"
   ".set\tat\n\t"
   ".set\treorder"
   :"=&r" (quotient)
   :"r" (timerhi),
    "m" (timerlo),
    "r" (tmp),
    "r" (USECS_PER_JIFFY)
   :"$1");
  cached_quotient = quotient;
 }

 /* Get last timer tick in absolute kernel time */
 count = read_32bit_cp0_register(CP0_COUNT);

 /* .. relative to previous jiffy (32 bits is enough) */
 count -= timerlo;

 __asm__("multu\t%1,%2\n\t"
  "mfhi\t%0"
  :"=r" (res)
  :"r" (count),
   "r" (quotient));

 /*
   * Due to possible jiffies inconsistencies, we need to check
  * the result so that we'll get a timer that is monotonic.
  */
 if (res >= USECS_PER_JIFFY)
  res = USECS_PER_JIFFY-1;

 return res;
}



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
