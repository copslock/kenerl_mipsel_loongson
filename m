Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 10:51:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33486 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012979AbbESIvKZK0Iw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 10:51:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6002F6C2275FF;
        Tue, 19 May 2015 09:51:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 19 May 2015 09:51:06 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 19 May 2015 09:51:06 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH RFC v2 01/10] MIPS: Add SysRq operation to dump TLBs on all CPUs
Date:   Tue, 19 May 2015 09:50:29 +0100
Message-ID: <1432025438-26431-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add a MIPS specific SysRq operation to dump the TLB entries on all CPUs,
using the 'x' trigger key.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
This was mainly for debug purposes, however I've included it for
completeness as an RFC patch, in case others find it helpful.
---
 arch/mips/kernel/Makefile |  1 +
 arch/mips/kernel/sysrq.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/sysrq.c       |  1 +
 3 files changed, 79 insertions(+)
 create mode 100644 arch/mips/kernel/sysrq.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index d3d2ff2d76dc..a2debcbedb6d 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o
 
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
+obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 
 obj-$(CONFIG_64BIT)		+= cpu-bugs64.o
 
diff --git a/arch/mips/kernel/sysrq.c b/arch/mips/kernel/sysrq.c
new file mode 100644
index 000000000000..5b539f5fc9d9
--- /dev/null
+++ b/arch/mips/kernel/sysrq.c
@@ -0,0 +1,77 @@
+/*
+ * MIPS specific sysrq operations.
+ *
+ * Copyright (C) 2015 Imagination Technologies Ltd.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/sysrq.h>
+#include <linux/workqueue.h>
+
+#include <asm/cpu-features.h>
+#include <asm/mipsregs.h>
+#include <asm/tlbdebug.h>
+
+/*
+ * Dump TLB entries on all CPUs.
+ */
+
+static DEFINE_SPINLOCK(show_lock);
+
+static void sysrq_tlbdump_single(void *dummy)
+{
+	const int field = 2 * sizeof(unsigned long);
+	unsigned long flags;
+
+	spin_lock_irqsave(&show_lock, flags);
+
+	pr_info("CPU%d:\n", smp_processor_id());
+	pr_info("Index	: %0x\n", read_c0_index());
+	pr_info("Pagemask: %0x\n", read_c0_pagemask());
+	pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
+	pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
+	pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
+	pr_info("Wired   : %0x\n", read_c0_wired());
+	pr_info("Pagegrain: %0x\n", read_c0_pagegrain());
+	if (cpu_has_htw) {
+		pr_info("PWField : %0*lx\n", field, read_c0_pwfield());
+		pr_info("PWSize  : %0*lx\n", field, read_c0_pwsize());
+		pr_info("PWCtl   : %0x\n", read_c0_pwctl());
+	}
+	pr_info("\n");
+	dump_tlb_all();
+	pr_info("\n");
+
+	spin_unlock_irqrestore(&show_lock, flags);
+}
+
+#ifdef CONFIG_SMP
+static void sysrq_tlbdump_othercpus(struct work_struct *dummy)
+{
+	smp_call_function(sysrq_tlbdump_single, NULL, 0);
+}
+
+static DECLARE_WORK(sysrq_tlbdump, sysrq_tlbdump_othercpus);
+#endif
+
+static void sysrq_handle_tlbdump(int key)
+{
+	sysrq_tlbdump_single(NULL);
+#ifdef CONFIG_SMP
+	schedule_work(&sysrq_tlbdump);
+#endif
+}
+
+static struct sysrq_key_op sysrq_tlbdump_op = {
+	.handler        = sysrq_handle_tlbdump,
+	.help_msg       = "show-tlbs(x)",
+	.action_msg     = "Show TLB entries",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
+};
+
+static int __init mips_sysrq_init(void)
+{
+	return register_sysrq_key('x', &sysrq_tlbdump_op);
+}
+arch_initcall(mips_sysrq_init);
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 843f2cdc280b..8ba52e56bb8b 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -463,6 +463,7 @@ static struct sysrq_key_op *sysrq_key_table[36] = {
 	/* v: May be registered for frame buffer console restore */
 	NULL,				/* v */
 	&sysrq_showstate_blocked_op,	/* w */
+	/* x: May be registered on mips for TLB dump */
 	/* x: May be registered on ppc/powerpc for xmon */
 	/* x: May be registered on sparc64 for global PMU dump */
 	NULL,				/* x */
-- 
2.3.6
