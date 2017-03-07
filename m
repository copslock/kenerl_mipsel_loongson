Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 14:20:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37649 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993892AbdCGNULzb4K0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 14:20:11 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F227A23AC0920;
        Tue,  7 Mar 2017 13:20:02 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 7 Mar 2017 13:20:05 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH] MIPS: enable GENERIC_CPU_AUTOPROBE
Date:   Tue, 7 Mar 2017 14:19:56 +0100
Message-ID: <1488892796-20134-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Add missing macros and methods that are required by
CONFIG_GENERIC_CPU_AUTOPROBE: MAX_CPU_FEATURES, cpu_have_feature(),
cpu_feature().

Also set a default elf platform as currently it is not set for most MIPS
platforms resulting in incorrectly specified modalias values in cpu
autoprobe ("cpu:type:(null):feature:...").

Export 'elf_hwcap' symbol so that it can be accessed from modules that
use module_cpu_feature_match()

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

---
 arch/mips/Kconfig                  |  1 +
 arch/mips/include/asm/cpufeature.h | 26 ++++++++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c       |  7 +++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/mips/include/asm/cpufeature.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a008a9f..ac181c0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -46,6 +46,7 @@ config MIPS
 	select ARCH_DISCARD_MEMBLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select BUILDTIME_EXTABLE_SORT
+	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_CMOS_UPDATE
diff --git a/arch/mips/include/asm/cpufeature.h b/arch/mips/include/asm/cpufeature.h
new file mode 100644
index 0000000..c63ec05
--- /dev/null
+++ b/arch/mips/include/asm/cpufeature.h
@@ -0,0 +1,26 @@
+/*
+ * CPU feature definitions for module loading, used by
+ * module_cpu_feature_match(), see uapi/asm/hwcap.h for MIPS CPU features.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __ASM_CPUFEATURE_H
+#define __ASM_CPUFEATURE_H
+
+#include <uapi/asm/hwcap.h>
+#include <asm/elf.h>
+
+#define MAX_CPU_FEATURES (8 * sizeof(elf_hwcap))
+
+#define cpu_feature(x)		ilog2(HWCAP_ ## x)
+
+static inline bool cpu_have_feature(unsigned int num)
+{
+	return elf_hwcap & (1UL << num);
+}
+
+#endif /* __ASM_CPUFEATURE_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 07718bb..82cb2f7 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -34,6 +34,7 @@
 
 /* Hardware capabilities */
 unsigned int elf_hwcap __read_mostly;
+EXPORT_SYMBOL_GPL(elf_hwcap);
 
 /*
  * Get the FPU Implementation/Revision.
@@ -1946,6 +1947,12 @@ void cpu_probe(void)
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int cpu = smp_processor_id();
 
+	/*
+	 * Set a default elf platform, cpu probe may later
+	 * overwrite it with a more precise value
+	 */
+	set_elf_platform(cpu, "mips");
+
 	c->processor_id = PRID_IMP_UNKNOWN;
 	c->fpu_id	= FPIR_IMP_NONE;
 	c->cputype	= CPU_UNKNOWN;
-- 
2.7.4
