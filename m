Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 14:47:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53989 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023777AbYDNNrL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2008 14:47:11 +0100
Received: from localhost (p6040-ipad303funabasi.chiba.ocn.ne.jp [123.217.152.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1F399AA6A; Mon, 14 Apr 2008 22:47:05 +0900 (JST)
Date:	Mon, 14 Apr 2008 22:47:59 +0900 (JST)
Message-Id: <20080414.224759.130241483.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Do not build spram.o unconditionally
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
X-archive-position: 18915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Patch against linux-queue tree.

 arch/mips/kernel/Makefile    |    3 ++-
 arch/mips/kernel/cpu-probe.c |    4 ++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 80c5aba..27dbbaa 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y		:= head.o init_task.o vmlinux.lds
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
 		   time.o topology.o traps.o unaligned.o \
-		   spram.o irq-gic.o
+		   irq-gic.o
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
 obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
@@ -53,6 +53,7 @@ obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMTC)	+= smtc.o smtc-asm.o smtc-proc.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
+obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
 
 obj-$(CONFIG_MIPS_APSP_KSPD)	+= kspd.o
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index dd26322..335a6ae 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -676,7 +676,11 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 		return;
 }
 
+#ifdef CONFIG_CPU_MIPSR2
 extern void spram_config(void);
+#else
+static inline void spram_config(void) {}
+#endif
 
 static inline void cpu_probe_mips(struct cpuinfo_mips *c)
 {
