Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 23:40:04 +0000 (GMT)
Received: from zcars04f.nortelnetworks.com ([IPv6:::ffff:47.129.242.57]:23008
	"EHLO zcars04f.nortelnetworks.com") by linux-mips.org with ESMTP
	id <S8225402AbTKDXjc>; Tue, 4 Nov 2003 23:39:32 +0000
Received: from zcard309.ca.nortel.com (zcard309.ca.nortel.com [47.129.242.69])
	by zcars04f.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id hA4NdOt01506
	for <linux-mips@linux-mips.org>; Tue, 4 Nov 2003 18:39:24 -0500 (EST)
Received: from zcard0k6.ca.nortel.com ([47.129.242.158]) by zcard309.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id VRTPF5YL; Tue, 4 Nov 2003 18:39:25 -0500
Received: from americasm01.nt.com (wcary3hh.ca.nortel.com [47.129.112.118]) by zcard0k6.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id V8PGYY3X; Tue, 4 Nov 2003 18:39:24 -0500
Message-ID: <3FA838AC.4040807@americasm01.nt.com>
Date: Tue, 04 Nov 2003 18:39:24 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Lijun Chen" <chenli@nortelnetworks.com>
Organization: Nortel Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: MIPS64 cross compiling errors: cpu-probe.c:167: error: unknown register
 name `accum' in `asm'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chenli@nortelnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenli@nortelnetworks.com
Precedence: bulk
X-list: linux-mips

Hi,

I am cross compiling a 64-bit MIPS kernel for BCM1250. The cross 
compiler is
from Broadcom sbtools: mips64-linux-gcc. Now I got the following errors:

gcc -D__KERNEL__ -I/src/kernel/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-I /src/kernel/include/asm/gcc -mabi=64 -G 0 -mno-abicalls -fno-pic 
-Wa,--trap -pipe -  -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=cpu_probe  -c -o cpu-probe.o cpu-probe.c
cpu-probe.c: In function `align_mod':

cpu-probe.c:118: warning: asm operand 0 probably doesn't match constraints
cpu-probe.c:118: warning: asm operand 1 probably doesn't match constraints
cpu-probe.c: In function `mult_sh_align_mod':

cpu-probe.c:118: warning: asm operand 0 probably doesn't match constraints
cpu-probe.c:118: warning: asm operand 1 probably doesn't match constraints
cpu-probe.c:167: error: unknown register name `accum' in `asm'
cpu-probe.c:118: warning: asm operand 0 probably doesn't match constraints
cpu-probe.c:118: warning: asm operand 1 probably doesn't match constraints
cpu-probe.c: In function `check_mult_sh':

cpu-probe.c:167: error: unknown register name `accum' in `asm'
cpu-probe.c:167: error: unknown register name `accum' in `asm'
cpu-probe.c:167: error: unknown register name `accum' in `asm'
cpu-probe.c:167: error: unknown register name `accum' in `asm'
cpu-probe.c:167: error: unknown register name `accum' in `asm'
cpu-probe.c:167: error: unknown register name `accum' in `asm'
cpu-probe.c:167: error: unknown register name `accum' in `asm'
cpu-probe.c:167: error: unknown register name `accum' in `asm'

The gcc is a wrapper that is actually:
/usr/local/sbtools/x86-linux-rh6.0/mips64-linux-2.8.24/bin/mips64-linux-gcc 
-msb1-pass2-workarounds "$@"

The kernel is 2.4.22.

Any suggestions what is the cause? Thanks in advance.

Lijun
