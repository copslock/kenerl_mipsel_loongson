Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Aug 2004 18:30:48 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.198]:17715 "EHLO
	mproxy.gmail.com") by linux-mips.org with ESMTP id <S8225212AbUHLRao>;
	Thu, 12 Aug 2004 18:30:44 +0100
Received: by mproxy.gmail.com with SMTP id 79so295472rnk
        for <linux-mips@linux-mips.org>; Thu, 12 Aug 2004 10:30:32 -0700 (PDT)
Received: by 10.38.171.68 with SMTP id t68mr80936rne;
        Thu, 12 Aug 2004 10:30:32 -0700 (PDT)
Message-ID: <b318a0150408121030389aa24c@mail.gmail.com>
Date: Thu, 12 Aug 2004 10:30:32 -0700
From: Manish Lohani <mlohani@gmail.com>
To: linux-mips@linux-mips.org
Subject: Busybox v0.60.2 insmod gives segmentation fault without any messages when trying to load a loadable module
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mlohani@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlohani@gmail.com
Precedence: bulk
X-list: linux-mips

I have a driver loadable module which i am compiling with the same gcc
flags as used to compile a kernel for a MIPS R5432 based NEC board.

On the development machine, to compile files driver1.c and driver2.c:
$ mips_fp_le-gcc -fomit-frame-pointer -fno-strict-aliasing -G 0
-mno-abicalls -fno-pic -pipe -mtune=r5000 -mlong-calls -mips2 -Wall -c
driver1.c

$mips_fp_le-ld -r -o driver --printmap --cref driver1.o driver2.o

mips_fp_le-gcc (GCC) version 3.3.1
mips_fp_le-ld (GNU ld) version 2.14

I have Busybox v0.60.2 on the target.

On the target:
# insmod ./driver
Using driver
Segmentation fault
#

Does anybody have any suggestions as to what could be wrong?

Thanks in advance,
Manu
