Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2003 22:05:40 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:9883 "EHLO
	powerpuff.evo1.pas.lab") by linux-mips.org with ESMTP
	id <S8225346AbTKQWF2>; Mon, 17 Nov 2003 22:05:28 +0000
Received: from powerpuff.evo1.pas.lab (localhost.localdomain [127.0.0.1])
	by powerpuff.evo1.pas.lab (8.12.8/8.12.8) with ESMTP id hAHM4Vcg016761;
	Mon, 17 Nov 2003 14:04:31 -0800
Received: (from baitisj@localhost)
	by powerpuff.evo1.pas.lab (8.12.8/8.12.8/Submit) id hAHM4RdA016757;
	Mon, 17 Nov 2003 14:04:27 -0800
X-Authentication-Warning: powerpuff.evo1.pas.lab: baitisj set sender to baitisj@evolution.com using -f
Subject: Newbie R5K questions -- -mips2 vs -mips4; is n32 ABI supported by
	Linux?
From: Jeffrey Baitis <baitisj@evolution.com>
Reply-To: baitisj@evolution.com
To: linux-mips@linux-mips.org
Cc: Adam_Kiepul@pmc-sierra.com,
	"Mr. Brian R. Gunnison" <brian@evolution.com>,
	Francis Yu <francisyu@synergyrep.com>,
	Johnny Lam <Johnny_Lam@pmc-sierra.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1069106666.1829.323.camel@powerpuff.evo1.pas.lab>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Nov 2003 14:04:26 -0800
Return-Path: <baitisj@evolution.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hi all:

I'm currently trying to increase performance on our PMC-Sierra RM5231
system by taking advantage of the MIPS IV ISA. This processor has a
32-bit address bus interface with 64-bit GPRs, so I guess that the
choice of -mabi=n32 is ideal for this processor.

Why is it that the Linux kernel defaults to -mcpu=r5000 -mips2 for the
52XX? Wouldn't there be good reasons to use the enhancements present in
the MIPS IV instruction set?

I've tried modifying the mips Makefile so that the Nevada adds the
cflags -mabi=n32 -mcpu=r5000 -mips4. I also modified asm/unistd.h so
that __NR_sigreturn is defined for the case where _MIPS_SIM ==
_MIPS_SIM_NABI32. Unfortunately, I get link errors: (gcc 3.2.3)

        arch/mips/kernel/kernel.o(.data+0x4240): undefined reference to
        `sys_stat64'
        arch/mips/kernel/kernel.o(.data+0x4244): undefined reference to
        `sys_lstat64'
        arch/mips/kernel/kernel.o(.data+0x4248): undefined reference to
        `sys_fstat64'
        drivers/ide/idedriver.o(.data.init+0x8): undefined reference to
        `init_setup_it8172'
        

The goal is that I want to be able to execute MIPS IV or MIPS III
instructions in user mode, since the profiling program that I'm using is
based in userspace and does not measure kernel performance. I already
have measured performance using MIPS I binaries. Under a -mips1-compiled
uClibc/busybox root filesystem, I tried executing -mips2, -mips3, and
-mips4 binaries -- but it seemed that the ELF interpreter was unable to
recognize them as valid ELF files (resulting in a shell 'Syntax Error').

After doing some digging, I found some documentation on SGI's website
about different ABI levels:

http://www.parallab.uib.no/SGI_bookshelves/SGI_Developer/books/MproCplrDbx_TG/sgi_html/ch06.html#Z70233

Here, I read that the OS, my libraries, and, of course, the application
must support the ABI of my choice. So, this takes me to my second
question: does Linux support the n32 ABI? How do I enable this support,
so that it is possible to take advantage of MIPS IV instructions?

Is there a book or FAQ that can answer questions such as these?

Thank you very much for any help.

Regards,

Jeff


-- 
Jeffrey Baitis <baitisj@evolution.com>
