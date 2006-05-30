Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2006 04:10:56 +0200 (CEST)
Received: from [220.76.242.187] ([220.76.242.187]:27014 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8126480AbWE3CKq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 May 2006 04:10:46 +0200
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k4U2CbEE017519
	for <linux-mips@linux-mips.org>; Tue, 30 May 2006 11:12:40 +0900
Message-ID: <000101c6838e$437abdf0$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	<linux-mips@linux-mips.org>
Subject: compiling BCM5700 driver
Date:	Tue, 30 May 2006 11:10:45 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello,

I try to compile BCM5700 driver of gigabit ethernet card for MIPS target. I 
used both toolchains (from PMC-sierra and self-made following 
http://www.kegel.com/crosstool recommendations). Get same errors:

In file included from mm.h:151,
                 from b57um.c:19:
tigon3.h:2225: unnamed fields of type other than struct or union are not 
allowed
tigon3.h:2225: warning: no semicolon at end of struct or union
tigon3.h:2225: syntax error before numeric constant
tigon3.h:2225: warning: no semicolon at end of struct or union
tigon3.h:2239: syntax error before '}' token
tigon3.h:2239: warning: type defaults to `int' in declaration of `reg'
tigon3.h:2239: warning: data definition has no type or storage class
tigon3.h:2240: syntax error before '}' token

Here is abstract from tigon3.h where compiler complains:

typedef unsigned int   LM_UINT32,  *PLM_UINT32;
...
typedef volatile LM_UINT32 T3_32BIT_REGISTER, *PT3_32BIT_REGISTER;
...

typedef union T3_CPU
{
  struct
  {
    T3_32BIT_REGISTER mode;
    #define CPU_MODE_HALT   BIT_10
    #define CPU_MODE_RESET  BIT_0
    T3_32BIT_REGISTER state;
    T3_32BIT_REGISTER EventMask;
    T3_32BIT_REGISTER reserved1[4];
    T3_32BIT_REGISTER PC;                                /* ERROR! */
    T3_32BIT_REGISTER Instruction;
    T3_32BIT_REGISTER SpadUnderflow;
    T3_32BIT_REGISTER WatchdogClear;
    T3_32BIT_REGISTER WatchdogVector;
    T3_32BIT_REGISTER WatchdogSavedPC;
    T3_32BIT_REGISTER HardwareBp;
    T3_32BIT_REGISTER reserved2[3];
    T3_32BIT_REGISTER WatchdogSavedState;
    T3_32BIT_REGISTER LastBrchAddr;
    T3_32BIT_REGISTER SpadUnderflowSet;
    T3_32BIT_REGISTER reserved3[(0x200-0x50)/4];
    T3_32BIT_REGISTER Regs[32];
    T3_32BIT_REGISTER reserved4[(0x400-0x280)/4];
  }reg;
}T3_CPU, *PT3_CPU;

I used the following compiler flags:

CFLAGS=-DMODULE -D__KERNEL__ -DDBG=0 -DT3_JUMBO_RCV_RCB_ENTRY_COUNT=256 -DNICE_SUPPORT 
 -DPCIX_TARGET_WORKAROUND=1 -DINCLUDE_TBI_SUPPORT -DINCLUDE_5701_AX_FIX=1 -Wall 
 -Wstrict-prototypes -mabi=32 -pipe -mips4 -mlong-calls -fno-common -fomit-frame-pointer 
 -fno-pic -mno-abicalls -G0 -I$(LINUX)/include

What may be the reason?

Thanks in advance for hints!

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
