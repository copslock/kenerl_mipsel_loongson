Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2008 17:29:16 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:35783 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S30624640AbYDYQ3O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2008 17:29:14 +0100
Received: from localhost (p6035-ipad308funabasi.chiba.ocn.ne.jp [123.217.192.35])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0CFDDB897; Sat, 26 Apr 2008 01:29:08 +0900 (JST)
Date:	Sat, 26 Apr 2008 01:30:09 +0900 (JST)
Message-Id: <20080426.013009.96686503.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make irq-gic on only malta platform
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Patch against linux-queue tree.

 arch/mips/Kconfig         |    4 ++++
 arch/mips/kernel/Makefile |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b59f65d..e5a7c5d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -223,6 +223,7 @@ config MIPS_MALTA
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
 	select IRQ_CPU
+	select IRQ_GIC
 	select HW_HAS_PCI
 	select I8253
 	select I8259
@@ -926,6 +927,9 @@ config IRQ_TXX9
 config IRQ_GT641XX
 	bool
 
+config IRQ_GIC
+	bool
+
 config MIPS_BOARDS_GEN
 	bool
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 3538b9f..5cb9299 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -4,7 +4,7 @@
 
 extra-y		:= head.o init_task.o vmlinux.lds
 
-obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o irq-gic.o \
+obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o \
 		   process.o ptrace.o reset.o setup.o signal.o syscall.o \
 		   time.o topology.o traps.o unaligned.o
 
@@ -67,6 +67,7 @@ obj-$(CONFIG_IRQ_CPU_RM9K)	+= irq-rm9000.o
 obj-$(CONFIG_MIPS_BOARDS_GEN)	+= irq-msc01.o
 obj-$(CONFIG_IRQ_TXX9)		+= irq_txx9.o
 obj-$(CONFIG_IRQ_GT641XX)	+= irq-gt641xx.o
+obj-$(CONFIG_IRQ_GIC)		+= irq-gic.o
 
 obj-$(CONFIG_32BIT)		+= scall32-o32.o
 obj-$(CONFIG_64BIT)		+= scall64-64.o
