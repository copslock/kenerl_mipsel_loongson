Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 12:48:31 +0000 (GMT)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:1806
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225255AbUCZMsa>; Fri, 26 Mar 2004 12:48:30 +0000
Received: from comm1.baslerweb.com ([172.16.13.2]) by proxy.baslerweb.com
          (Post.Office MTA v3.5.3 release 223 ID# 0-0U10L2S100V35)
          with ESMTP id com for <linux-mips@linux-mips.org>;
          Fri, 26 Mar 2004 13:48:32 +0100
Received: from 172.16.13.253 (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id H3NK0ZJZ; Fri, 26 Mar 2004 13:48:27 +0100
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: linker script problem
Date: Fri, 26 Mar 2004 13:49:41 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
X-UID: 1298
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403261349.41783.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

I just ran into the folowing problem when building a kernel.
This is the first time I build a MIPS kernel, and so I may
be making mistakes. Here's what I found:

When building the kernel, the linker chokes on
arch/mips/kernel/vmlinux.lds.s, because it contains

OUTPUT_ARCH(mips)
ENTRY(kernel_entry)
jiffies = jiffies_64 + 4;
SECTIONS
{
  . = ;
 *** ^ ***

This has been generated from arch/mips/kernel/vmlinux.lds.S,
which contains

  . = LOADADDR;

which is in turn generated from arch/mips/kernel/.vmlinux.lds.s.cmd,
which contains

cmd_arch/mips/kernel/vmlinux.lds.s := mips-linux-gcc -E -Wp,-MD,arch/mips/kernel/.vmlinux.lds.s.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ -I /home/GERMANY/tkoeller/mips-linux/build/linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe  -finline-limit=100000 -mabi=32 -march=r5000 -Wa,-32 -Wa,-march=r5000 -Wa,-mips4 -Wa,--trap -Iinclude/asm-mips/mach-generic  -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -I /home/GERMANY/tkoeller/mips-linux/build/linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe  -finline-limit=100000 -mabi=32 -march=r5000 -Wa,-32 -Wa,-march=r5000 -Wa,-mips4 -Wa,--trap -Iinclude/asm-mips/mach-generic  -O2 -fomit-frame-pointer  -D"LOADADDR=" -D"JIFFIES=jiffies_64 + 4" -imacros /home/GERMANY/tkoeller/mips-linux/build/linux/include/asm-mips/sn/mapped_kernel.h -P -C -Umips    -o arch/mips/kernel/vmlinux.lds.s arch/mips/kernel/vmlinux.lds.S 

in line #1. The -D"LOADADDR=" looks suspicious, but I
have not been able to trace the problem beyond this point.

Can anybody help out?

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
