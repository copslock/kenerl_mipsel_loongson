Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 02:01:54 +0200 (CEST)
Received: from fw1-az.mvista.com ([65.200.49.156]:55029 "EHLO
	shomer.az.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492853AbZFQABt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 02:01:49 +0200
Received: from shomer.az.mvista.com (localhost.localdomain [127.0.0.1])
	by shomer.az.mvista.com (8.14.2/8.14.2) with ESMTP id n5H00Zfq006406
	for <linux-mips@linux-mips.org>; Tue, 16 Jun 2009 17:00:35 -0700
Received: (from tsa@localhost)
	by shomer.az.mvista.com (8.14.2/8.14.2/Submit) id n5H00Zb4006405
	for linux-mips@linux-mips.org; Tue, 16 Jun 2009 17:00:35 -0700
Date:	Tue, 16 Jun 2009 17:00:35 -0700
From:	Tim Anderson <tanderson@mvista.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 4/5] Move gcmp_probe to before the SMP ops
Message-ID: <20090617000035.GG6346@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsa@shomer.az.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

This is to move the gcmp_probe call to before the
use of and selection of the smp_ops functions. This
allows malta with 1004K to work.

Signed-off-by: Tim Anderson <tanderson@mvista.com>
---
 arch/mips/include/asm/gcmpregs.h |    2 ++
 arch/mips/mti-malta/malta-init.c |   11 ++++++++++-
 arch/mips/mti-malta/malta-int.c  |    5 +----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/gcmpregs.h b/arch/mips/include/asm/gcmpregs.h
index d74a8a4..36fd969 100644
--- a/arch/mips/include/asm/gcmpregs.h
+++ b/arch/mips/include/asm/gcmpregs.h
@@ -114,4 +114,6 @@
 #define GCMP_CCB_DINTGROUP_OFS		0x0030		/* DINT Group Participate */
 #define GCMP_CCB_DBGGROUP_OFS		0x0100		/* DebugBreak Group */
 
+extern int __init gcmp_probe(unsigned long, unsigned long);
+
 #endif /* _ASM_GCMPREGS_H */
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 475038a..e988e33 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -30,6 +30,7 @@
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
 
+#include <asm/gcmpregs.h>
 #include <asm/mips-boards/prom.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/bonito64.h>
@@ -192,6 +193,8 @@ extern struct plat_smp_ops msmtc_smp_ops;
 
 void __init prom_init(void)
 {
+	int result;
+
 	prom_argc = fw_arg0;
 	_prom_argv = (int *) fw_arg1;
 	_prom_envp = (int *) fw_arg2;
@@ -358,10 +361,16 @@ void __init prom_init(void)
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	console_config();
 #endif
+	/* Early detection of CMP support */
+	result = gcmp_probe(GCMP_BASE_ADDR, GCMP_ADDRSPACE_SZ);
+
 #ifdef CONFIG_MIPS_CMP
-	register_smp_ops(&cmp_smp_ops);
+	if (result) register_smp_ops(&cmp_smp_ops);
 #endif
 #ifdef CONFIG_MIPS_MT_SMP
+#ifdef CONFIG_MIPS_CMP
+	if (!result)
+#endif
 	register_smp_ops(&vsmp_smp_ops);
 #endif
 #ifdef CONFIG_MIPS_MT_SMTC
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 44b23bf..107fb34 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -408,7 +408,7 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
 /*
  * GCMP needs to be detected before any SMP initialisation
  */
-static int __init gcmp_probe(unsigned long addr, unsigned long size)
+int __init gcmp_probe(unsigned long addr, unsigned long size)
 {
 	if (gcmp_present >= 0)
 		return gcmp_present;
@@ -448,14 +448,11 @@ static void __init fill_ipi_map(void)
 
 void __init arch_init_irq(void)
 {
-	int gic_present, gcmp_present;
-
 	init_i8259_irqs();
 
 	if (!cpu_has_veic)
 		mips_cpu_irq_init();
 
-	gcmp_present = gcmp_probe(GCMP_BASE_ADDR, GCMP_ADDRSPACE_SZ);
 	if (gcmp_present)  {
 		GCMPGCB(GICBA) = GIC_BASE_ADDR | GCMP_GCB_GICBA_EN_MSK;
 		gic_present = 1;
-- 
1.6.2.5.170.gf2181
