Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 May 2004 06:16:47 +0100 (BST)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:54814
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224896AbUETFQq>; Thu, 20 May 2004 06:16:46 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 20 May 2004 05:16:44 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 57DF0239E2C; Thu, 20 May 2004 14:18:21 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i4K5GZwB016163;
	Thu, 20 May 2004 14:16:35 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 20 May 2004 14:17:32 +0900 (JST)
Message-Id: <20040520.141732.74755661.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: fix 2.4 mips64 build (CONFIG_NEW_TIME_C)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

CONFIG_NEW_TIME_C no longer exists.  Please apply this to 2.4 tree.

diff -u linux-mips/arch/mips64/kernel/Makefile linux/arch/mips64/kernel/Makefile
--- linux-mips/arch/mips64/kernel/Makefile	Thu Mar 11 10:13:45 2004
+++ linux/arch/mips64/kernel/Makefile	Thu May 20 13:41:46 2004
@@ -17,12 +17,11 @@
 obj-y		:= branch.o cpu-probe.o entry.o irq.o proc.o process.o \
 		   ptrace.o r4k_cache.o r4k_fpu.o r4k_genex.o r4k_switch.o \
 		   reset.o scall_64.o semaphore.o setup.o signal.o syscall.o \
-		   traps.o unaligned.o
+		   time.o traps.o unaligned.o
 
 obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
 obj-$(CONFIG_IRQ_CPU_RM7K)	+= irq-rm7000.o
-obj-$(CONFIG_NEW_TIME_C)	+= time.o
 
 obj-$(CONFIG_MODULES)		+= mips64_ksyms.o
 obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o signal32.o ioctl32.o

---
Atsushi Nemoto
