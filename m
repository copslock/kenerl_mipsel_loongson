Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Mar 2003 07:03:45 +0000 (GMT)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:14208
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8224861AbTC2HDn>; Sat, 29 Mar 2003 07:03:43 +0000
Received: from mail.inspiretech.com (mail.inspiretech.com [150.1.1.1])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h2T7NYq6006229
	for <linux-mips@linux-mips.org>; Sat, 29 Mar 2003 12:53:40 +0530
Message-Id: <200303290723.h2T7NYq6006229@smtp.inspirtek.com>
Received: from WorldClient [150.1.1.1] by inspiretech.com [150.1.1.1]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Sat, 29 Mar 2003 12:24:43 +0530
Date: Sat, 29 Mar 2003 12:24:42 +0530
From: "Avinash S." <avinash.s@inspiretech.com>
To: "linux" <linux-mips@linux-mips.org>
Subject: 
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 150.1.1.1
X-Return-Path: avinash.s@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <avinash.s@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: avinash.s@inspiretech.com
Precedence: bulk
X-list: linux-mips

Hello,

Im trying to build a kernel config for a big endian IDT79S334 board. I 
have sucessfully mangaged to get a vmlinux image using Embedix tools for 
little endian but am having problems with big endian configs. I am using 
binutils version 2.8. I get an error when i reaches irq.c saying:
Unknown ISA level 
Unknown opcode 'clz'

im using a mips-linux-gcc from egcs pacakge(1.1.2-4). Does anyone know 
how to solve this problem or where can i get a mips-linux-gcc that 
supports the opcode.

Thanks in advance
Avinash


pS: here is the make dump that shows the error.
--------------------------------------------------------------------------
make[1]: Entering directory 
`/home1/ixe2424/proj/ixe2424/IDT/linux/arch/mips/rc32300/79S334'
make all_targets
make[2]: Entering directory 
`/home1/ixe2424/proj/ixe2424/IDT/linux/arch/mips/rc32300/79S334'
mips-linux-gcc -I /home1/ixe2424/proj/ixe2424/IDT/linux/include/asm/gcc -
D__KERNEL__ -I/home1/ixe2424/proj/ixe2424/IDT/linux/include -Wall -
Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer  -fno-common -
fno-strict-aliasing -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--
trap -pipe   -DKBUILD_BASENAME=irq  -c -o irq.o irq.c
{standard input}: Assembler messages:
{standard input}:1076: Error: unknown ISA level
{standard input}:1077: Error: unrecognized opcode `clz'
{standard input}:1116: Error: unknown ISA level
{standard input}:1117: Error: unrecognized opcode `clz'
{standard input}:1193: Error: unknown ISA level
{standard input}:1194: Error: unrecognized opcode `clz'
make[2]: *** [irq.o] Error 1
make[2]: Leaving directory 
`/home1/ixe2424/proj/ixe2424/IDT/linux/arch/mips/rc32300/79S334'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory 
`/home1/ixe2424/proj/ixe2424/IDT/linux/arch/mips/rc32300/79S334'
make: *** [_dir_arch/mips/rc32300/79S334] Error 2
