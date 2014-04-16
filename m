Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:54:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:54335 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834703AbaDPMxxPZUwP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:53:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2C36983B32124
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:53:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:53:46 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:53:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 01/39] MIPS: PM: Add CPU PM callbacks for general CPU context
Date:   Wed, 16 Apr 2014 13:52:52 +0100
Message-ID: <1397652810-4336-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

From: James Hogan <james.hogan@imgtec.com>

Add a CPU power management notifier callback for preserving general CPU
context. The CPU PM callbacks will be triggered by the powering down of
CPU cores, for example by cpuidle drivers & in the future by suspend to
RAM implementations.

The current state preserved is mostly related to the process context:
- FPU
- DSP
- ASID
- UserLocal
- Watch registers

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig         |  1 +
 arch/mips/kernel/Makefile |  2 +
 arch/mips/kernel/pm.c     | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 arch/mips/kernel/pm.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5cd695f..322bbe1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -50,6 +50,7 @@ config MIPS
 	select CLONE_BACKWARDS
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_CC_STACKPROTECTOR
+	select CPU_PM if CPU_IDLE
 
 menu "Machine selection"
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 277dab3..97540a8 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -107,6 +107,8 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_MIPS_CM)		+= mips-cm.o
 obj-$(CONFIG_MIPS_CPC)		+= mips-cpc.o
 
+obj-$(CONFIG_CPU_PM)		+= pm.o
+
 #
 # DSP ASE supported for MIPS32 or MIPS64 Release 2 cores only. It is not
 # safe to unconditionnaly use the assembler -mdsp / -mdspr2 switches
diff --git a/arch/mips/kernel/pm.c b/arch/mips/kernel/pm.c
new file mode 100644
index 0000000..112903f
--- /dev/null
+++ b/arch/mips/kernel/pm.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2014 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * CPU PM notifiers for saving/restoring general CPU state.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/init.h>
+
+#include <asm/dsp.h>
+#include <asm/fpu.h>
+#include <asm/mmu_context.h>
+#include <asm/watch.h>
+
+/**
+ * mips_cpu_save() - Save general CPU state.
+ * Ensures that general CPU context is saved, notably FPU and DSP.
+ */
+static int mips_cpu_save(void)
+{
+	/* Save FPU state */
+	lose_fpu(1);
+
+	/* Save DSP state */
+	save_dsp(current);
+
+	return 0;
+}
+
+/**
+ * mips_cpu_restore() - Restore general CPU state.
+ * Restores important CPU context.
+ */
+static void mips_cpu_restore(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	/* Restore ASID */
+	if (current->mm)
+		write_c0_entryhi(cpu_asid(cpu, current->mm));
+
+	/* Restore DSP state */
+	restore_dsp(current);
+
+	/* Restore UserLocal */
+	if (cpu_has_userlocal)
+		write_c0_userlocal(current_thread_info()->tp_value);
+
+	/* Restore watch registers */
+	__restore_watch();
+}
+
+/**
+ * mips_pm_notifier() - Notifier for preserving general CPU context.
+ * @self:	Notifier block.
+ * @cmd:	CPU PM event.
+ * @v:		Private data (unused).
+ *
+ * This is called when a CPU power management event occurs, and is used to
+ * ensure that important CPU context is preserved across a CPU power down.
+ */
+static int mips_pm_notifier(struct notifier_block *self, unsigned long cmd,
+			    void *v)
+{
+	int ret;
+
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		ret = mips_cpu_save();
+		if (ret)
+			return NOTIFY_STOP;
+		break;
+	case CPU_PM_ENTER_FAILED:
+	case CPU_PM_EXIT:
+		mips_cpu_restore();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mips_pm_notifier_block = {
+	.notifier_call = mips_pm_notifier,
+};
+
+static int __init mips_pm_init(void)
+{
+	return cpu_pm_register_notifier(&mips_pm_notifier_block);
+}
+arch_initcall(mips_pm_init);
-- 
1.8.5.3
