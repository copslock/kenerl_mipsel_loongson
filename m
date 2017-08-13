Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:57:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30818 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992054AbdHMCzRXz8B6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:55:17 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 511E4B004A9AB;
        Sun, 13 Aug 2017 03:55:08 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:55:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 17/19] MIPS: CPS: Have asm/mips-cps.h include CM & CPC headers
Date:   Sat, 12 Aug 2017 19:49:41 -0700
Message-ID: <20170813024943.14989-18-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59513
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

With Coherence Manager (CM) 3.5 information about the topology of the
system, which has previously only been available through & accessed from
the CM, is now also provided by the Cluster Power Controller (CPC). This
includes a new CPC_CONFIG register mirroring GCR_CONFIG, and similarly a
new CPC_Cx_CONFIG register mirroring GCR_Cx_CONFIG.

In preparation for adjusting functions such as mips_cm_numcores(), which
have previously only needed to access the CM, to also access the CPC
this patch modifies the way we use the various CPS headers. Rather than
having users include asm/mips-cm.h or asm/mips-cpc.h individually we
instead have users include asm/mips-cps.h which in turn includes
asm/mips-cm.h & asm/mips-cpc.h. This means that users will gain access
to both CM & CPC registers by including one header, and most importantly
it makes asm/mips-cps.h an ideal location for helper functions which
need to access the various components of the CPS.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cm.h    | 7 ++++---
 arch/mips/include/asm/mips-cpc.h   | 9 ++++++---
 arch/mips/include/asm/mips-cps.h   | 3 +++
 arch/mips/include/asm/smp-ops.h    | 2 +-
 arch/mips/kernel/mips-cm.c         | 2 +-
 arch/mips/kernel/mips-cpc.c        | 3 +--
 arch/mips/kernel/pm-cps.c          | 3 +--
 arch/mips/kernel/smp-cps.c         | 3 +--
 arch/mips/kernel/traps.c           | 3 +--
 arch/mips/mm/c-r4k.c               | 2 +-
 arch/mips/mm/sc-mips.c             | 2 +-
 arch/mips/mti-malta/malta-dtshim.c | 2 +-
 arch/mips/mti-malta/malta-init.c   | 3 +--
 arch/mips/mti-malta/malta-int.c    | 1 -
 arch/mips/mti-malta/malta-setup.c  | 2 +-
 arch/mips/pci/pci-malta.c          | 2 +-
 arch/mips/pistachio/init.c         | 3 +--
 arch/mips/ralink/mt7621.c          | 3 +--
 arch/mips/vdso/gettimeofday.c      | 1 -
 drivers/irqchip/irq-mips-gic.c     | 2 +-
 20 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index d42cc8e76dc2..3b82ebb5b35c 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -8,14 +8,15 @@
  * option) any later version.
  */
 
+#ifndef __MIPS_ASM_MIPS_CPS_H__
+# error Please include asm/mips-cps.h rather than asm/mips-cm.h
+#endif
+
 #ifndef __MIPS_ASM_MIPS_CM_H__
 #define __MIPS_ASM_MIPS_CM_H__
 
 #include <linux/bitops.h>
 #include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/types.h>
-#include <asm/mips-cps.h>
 
 /* The base address of the CM GCR block */
 extern void __iomem *mips_gcr_base;
diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
index 1d024cc6ccd8..f885051a8378 100644
--- a/arch/mips/include/asm/mips-cpc.h
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -8,12 +8,15 @@
  * option) any later version.
  */
 
+#ifndef __MIPS_ASM_MIPS_CPS_H__
+# error Please include asm/mips-cps.h rather than asm/mips-cpc.h
+#endif
+
 #ifndef __MIPS_ASM_MIPS_CPC_H__
 #define __MIPS_ASM_MIPS_CPC_H__
 
-#include <linux/io.h>
-#include <linux/types.h>
-#include <asm/mips-cps.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
 
 /* The base address of the CPC registers */
 extern void __iomem *mips_cpc_base;
diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
index 7ae32ad15599..2ac88ed4b381 100644
--- a/arch/mips/include/asm/mips-cps.h
+++ b/arch/mips/include/asm/mips-cps.h
@@ -105,4 +105,7 @@ static inline void clear_##unit##_##name(uint##sz##_t val)		\
 	CPS_ACCESSOR_W(unit, sz, name)					\
 	CPS_ACCESSOR_M(unit, sz, name)
 
+#include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
+
 #endif /* __MIPS_ASM_MIPS_CPS_H__ */
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index e5f49dd453c7..53b2cb8e5966 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -13,7 +13,7 @@
 
 #include <linux/errno.h>
 
-#include <asm/mips-cm.h>
+#include <asm/mips-cps.h>
 
 #ifdef CONFIG_SMP
 
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 602c6ec9c01d..b0d670af5cb1 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -12,7 +12,7 @@
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 
-#include <asm/mips-cm.h>
+#include <asm/mips-cps.h>
 #include <asm/mipsregs.h>
 
 void __iomem *mips_gcr_base;
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 06952bb34395..f66b05ebf637 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -12,8 +12,7 @@
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 
-#include <asm/mips-cm.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 
 void __iomem *mips_cpc_base;
 
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index daff76056609..d5e452f9bddf 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -17,8 +17,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cacheops.h>
 #include <asm/idle.h>
-#include <asm/mips-cm.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 #include <asm/mipsmtregs.h>
 #include <asm/pm.h>
 #include <asm/pm-cps.h>
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 4a4a25c722f1..57b331b85e54 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -19,8 +19,7 @@
 #include <linux/types.h>
 
 #include <asm/bcache.h>
-#include <asm/mips-cm.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 #include <asm/mips_mt.h>
 #include <asm/mipsregs.h>
 #include <asm/pm-cps.h>
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4cba2e778284..5669d3b8bd38 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -50,9 +50,8 @@
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/idle.h>
-#include <asm/mips-cm.h>
+#include <asm/mips-cps.h>
 #include <asm/mips-r2-to-r6-emul.h>
-#include <asm/mips-cm.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/module.h>
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 81d6a15c93d0..6f534b209971 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -37,7 +37,7 @@
 #include <asm/cacheflush.h> /* for run_uncached() */
 #include <asm/traps.h>
 #include <asm/dma-coherence.h>
-#include <asm/mips-cm.h>
+#include <asm/mips-cps.h>
 
 /*
  * Bits describing what cache ops an SMP callback function may perform.
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index cda878c0010b..acfb89273dad 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -14,7 +14,7 @@
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 #include <asm/r4kcache.h>
-#include <asm/mips-cm.h>
+#include <asm/mips-cps.h>
 
 /*
  * MIPS32/MIPS64 L2 cache handling
diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index 67602d57710c..59a723d9a95a 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -18,7 +18,7 @@
 #include <asm/fw/fw.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
-#include <asm/mips-cm.h>
+#include <asm/mips-cpc.h>
 #include <asm/page.h>
 
 #define ROCIT_REG_BASE			0x1f403000
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 0f3b881a3190..009f2918b320 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -21,8 +21,7 @@
 #include <asm/smp-ops.h>
 #include <asm/traps.h>
 #include <asm/fw/fw.h>
-#include <asm/mips-cm.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
 
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index b0f9b188e833..2e831f4abfb3 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -29,7 +29,6 @@
 #include <asm/i8259.h>
 #include <asm/irq_cpu.h>
 #include <asm/irq_regs.h>
-#include <asm/mips-cm.h>
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
 #include <asm/gt64120.h>
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index a01d5debfcaf..7f1868888d18 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -28,7 +28,7 @@
 
 #include <asm/fw/fw.h>
 #include <asm/mach-malta/malta-dtshim.h>
-#include <asm/mips-cm.h>
+#include <asm/mips-cps.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
index cfbbc3e3e914..de97b8f1c5a8 100644
--- a/arch/mips/pci/pci-malta.c
+++ b/arch/mips/pci/pci-malta.c
@@ -27,7 +27,7 @@
 #include <linux/init.h>
 
 #include <asm/gt64120.h>
-#include <asm/mips-cm.h>
+#include <asm/mips-cps.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/bonito64.h>
 #include <asm/mips-boards/msc01_pci.h>
diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
index 1c91cad7988f..0b06c953d293 100644
--- a/arch/mips/pistachio/init.c
+++ b/arch/mips/pistachio/init.c
@@ -19,8 +19,7 @@
 #include <asm/dma-coherence.h>
 #include <asm/fw/fw.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-cm.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 #include <asm/prom.h>
 #include <asm/smp-ops.h>
 #include <asm/traps.h>
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 0695c2d64e49..9661c50305b5 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -12,8 +12,7 @@
 
 #include <asm/mipsregs.h>
 #include <asm/smp-ops.h>
-#include <asm/mips-cm.h>
-#include <asm/mips-cpc.h>
+#include <asm/mips-cps.h>
 #include <asm/mach-ralink/ralink_regs.h>
 #include <asm/mach-ralink/mt7621.h>
 
diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index e2690d7ca4dd..fec7835b9de7 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -16,7 +16,6 @@
 
 #include <asm/clocksource.h>
 #include <asm/io.h>
-#include <asm/mips-cm.h>
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ae9f8e581d06..9e984cefdca0 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -17,7 +17,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
-#include <asm/mips-cm.h>
+#include <asm/mips-cps.h>
 #include <asm/setup.h>
 #include <asm/traps.h>
 
-- 
2.14.0
