Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 21:18:52 +0100 (BST)
Received: from sccrmhc11.comcast.net ([204.127.202.55]:1209 "EHLO
	sccrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133577AbVJGUSe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 21:18:34 +0100
Received: from buzz (c-67-171-115-157.hsd1.ut.comcast.net[67.171.115.157])
          by comcast.net (sccrmhc11) with SMTP
          id <20051007201826011009fu6ue>; Fri, 7 Oct 2005 20:18:26 +0000
From:	"Kyle Unice" <unixe@comcast.net>
To:	<linux-mips@linux-mips.org>
Subject: Cross-compiling Linux problem
Date:	Fri, 7 Oct 2005 14:18:24 -0600
Message-ID: <002b01c5cb7c$45c181e0$0400a8c0@buzz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <unixe@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: unixe@comcast.net
Precedence: bulk
X-list: linux-mips

  LD      arch/mips/au1000/common/built-in.o
  CC      arch/mips/kernel/cpu-probe.o
  CC      arch/mips/kernel/branch.o
  AS      arch/mips/kernel/entry.o
  AS      arch/mips/kernel/genex.o
  CC      arch/mips/kernel/irq.o
  CC      arch/mips/kernel/process.o
  CC      arch/mips/kernel/ptrace.o
  CC      arch/mips/kernel/reset.o
  CC      arch/mips/kernel/semaphore.o
  CC      arch/mips/kernel/setup.o
  CC      arch/mips/kernel/signal.o
  CC      arch/mips/kernel/syscall.o
  CC      arch/mips/kernel/time.o
  CC      arch/mips/kernel/traps.o
  CC      arch/mips/kernel/unaligned.o
  CC      arch/mips/kernel/mips_ksyms.o
  CC      arch/mips/kernel/module.o
  AS      arch/mips/kernel/r4k_fpu.o
  AS      arch/mips/kernel/r4k_switch.o
  AS      arch/mips/kernel/scall32-o32.o
  CC      arch/mips/kernel/proc.o
  LD      arch/mips/kernel/built-in.o
  AS      arch/mips/kernel/head.o
  CC      arch/mips/kernel/init_task.o
  LDS     arch/mips/kernel/vmlinux.lds
  CC      arch/mips/mm/cache.o
  CC      arch/mips/mm/extable.o
  CC      arch/mips/mm/fault.o
  CC      arch/mips/mm/init.o
  CC      arch/mips/mm/pgtable.o
  CC      arch/mips/mm/tlbex.o
arch/mips/mm/tlbex.c:516:5: warning: "CONFIG_64BIT" is not defined
  AS      arch/mips/mm/tlbex-fault.o
  CC      arch/mips/mm/ioremap.o
arch/mips/mm/ioremap.c: In function `__ioremap':
include/asm-mips/mach-au1x00/ioremap.h:15: sorry, unimplemented: inlining
failed
 in call to '__fixup_bigphys_addr': function body not available
arch/mips/mm/ioremap.c:28: sorry, unimplemented: called from here
make[1]: *** [arch/mips/mm/ioremap.o] Error 1
make: *** [arch/mips/mm] Error 2
