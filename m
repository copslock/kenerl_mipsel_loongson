Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2005 15:20:57 +0100 (BST)
Received: from krt.tmd.ns.ac.yu ([IPv6:::ffff:147.91.177.65]:47845 "EHLO
	krt.neobee.net") by linux-mips.org with ESMTP id <S8225941AbVEKOUm>;
	Wed, 11 May 2005 15:20:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j4BEP6ZF017571
	for <linux-mips@linux-mips.org>; Wed, 11 May 2005 16:25:07 +0200
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 17140-04 for <linux-mips@linux-mips.org>;
 Wed, 11 May 2005 16:25:06 +0200 (CEST)
Received: from davidovic ([192.168.0.89])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j4BEOu1p017560
	for <linux-mips@linux-mips.org>; Wed, 11 May 2005 16:24:56 +0200
Message-Id: <200505111424.j4BEOu1p017560@krt.neobee.net>
Reply-To: <mile.davidovic@micronasnit.com>
From:	"Mile Davidovic" <mile.davidovic@micronasnit.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Mips 4KEC
Date:	Wed, 11 May 2005 16:20:53 +0200
Organization: MicronasNIT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcVWNKOCiTGfbgnLQ5CxCzsEl5x71g==
X-Virus-Scanned: by amavisd-new at krt.neobee.net
Return-Path: <mile.davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mile.davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello all

I tried to port linux 2.6.11-mipscvs-20050313 on MIPS 4KEC processor.

But I faced with some problems.

1. I have question regarding toolchain, I use toolchain which came from
uclibc buildroot
application. Gcc version is 3.4.2, is it ok?

2. I tried to use sde-lite 5.03 toolchain but this toolchain (sde-gcc)
failed to build kernel. 
    Please any comments regarding this issue? 

3. I tried to remove optimization from kernel: 
		ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
		CFLAGS		+= -Os
		else
		#CFLAGS		+= -O2
		endif
but kernel failed to compile with next messages:
	init/built-in.o(.init.text+0x216c): In function
`identify_ramdisk_image':
	init/do_mounts_rd.c:92: undefined reference to `ntohl'
	kernel/built-in.o(.text+0xf6f4): In function `put_files_struct':
	include/asm/system.h:270: undefined reference to
`__xchg_u64_unsupported_on_32bit_kernels'
	kernel/built-in.o(.text+0xf708):include/asm/system.h:273: undefined
reference to `__xchg_called_with_bad_pointer'
	kernel/built-in.o(.text+0x13264): In function `wait_task_zombie':
	include/asm/system.h:270: undefined reference to
`__xchg_u64_unsupported_on_32bit_kernels'
	kernel/built-in.o(.text+0x13278):include/asm/system.h:273: undefined
reference to `__xchg_called_with_bad_pointer'
	....
I tried with googling but it seems that nobody faced similar problem? Is it
possible to buidl kernel without optimization?

Best regards Mile
