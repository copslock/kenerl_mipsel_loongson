Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6S7x6Rw021355
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 28 Jul 2002 00:59:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6S7x5t9021353
	for linux-mips-outgoing; Sun, 28 Jul 2002 00:59:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mta0 ([61.144.161.2])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6S7wmRw021326
	for <linux-mips@oss.sgi.com>; Sun, 28 Jul 2002 00:58:53 -0700
Received: from z15805 (localhost [127.0.0.1])
 by mta0.huawei.com (iPlanet Messaging Server 5.2 HotFix 0.7 (built Jun 26
 2002)) with ESMTPA id <0GZY00KR48T18U@mta0.huawei.com> for
 linux-mips@oss.sgi.com; Sun, 28 Jul 2002 15:58:14 +0800 (CST)
Date: Sun, 28 Jul 2002 16:01:41 +0800
From: renwei <renwei@huawei.com>
Subject: mipsel-gcc sick with #pragma?
To: linux-mips@oss.sgi.com
Message-id: <001b01c2360d$07aabd20$690d6e0a@huawei.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
Content-type: text/plain; charset=gb2312
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
X-Spam-Status: No, hits=-0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi, 

  I have some mipsel-linux-gcc on my i386 pc
to compile something , just like this:

/***********   begin ************/

#include <stdio.h>
#include <stdlib.h>
#define pack warn  

#pragma pack(1)

typedef  struct tagHDP_IPPrefix1
{
    unsigned long ulIPPrefixNum;     
    unsigned char pucData[1];  b
}HDP_IPPrefix_S1;

typedef  struct tagHTP_Packet_TLV1
{
    unsigned short usType;              /* Type */
    unsigned short usLen;               /* Length */
    unsigned char  pucValue[20];         /* Value */
}HTP_Packet_TLV_S1;

#pragma pack(  )

void * test1(HTP_Packet_TLV_S1   stNewTLV)
{
    HDP_IPPrefix_S1      *pstIPPrefix    = 0; 
    pstIPPrefix = ( HDP_IPPrefix_S1 * )(stNewTLV.pucValue); 
    pstIPPrefix->ulIPPrefixNum = 0; 
    pstIPPrefix->ulIPPrefixNum += stNewTLV.usType * 2;
    return  pstIPPrefix;

}

/************* end of the file*************/

I compile it with :
mipsel-linux-gcc -c -O2 test.c -o test.o
but the result:
/tmp/ccMTigfE.s: Assembler messages:
/tmp/ccMTigfE.s:22: Error: illegal operands `sw'

compile with this:
mipsel-linux-gcc -c test.c -o test.o

will sucess.


the gcc manual says the use of #pragma is not good, 
so it doesn't support it.
I think  line 
#pragma pack(1)

is of no use , but it seems not the case.

my cross gcc is :
`    
 mipsel-linux-gcc -v

gcc version 2.95.3 19991030 (prerelease)

that's really a bug , I think.

should I upgrade my toolchain?  does the mipsel-gcc 3.1 ok at this case?

who knows the way to fix this?
                                        
            thanks.
