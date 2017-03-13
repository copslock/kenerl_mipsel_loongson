Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 14:34:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34906 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993963AbdCMNdwX9IyT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 14:33:52 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 82ECD8428E6DB;
        Mon, 13 Mar 2017 13:33:41 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 13 Mar 2017 13:33:44 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 2/2] MIPS: rename cpu-features.h -> cpucaps.h
Date:   Mon, 13 Mar 2017 14:33:38 +0100
Message-ID: <1489412018-30387-3-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57151
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

With GENERIC_CPU_AUTOPROBE feature, a new arch header 'cpufeature.h' has
been added. This name is confusingly similar to an already existing
cpu-features.h (and its associated headers cpu-feature-overrides.h), so
rename the existing ones to cpucaps.h and cpucaps-overrides.h
(correspondingly).

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/dec/setup.c                                             | 2 +-
 arch/mips/dec/time.c                                              | 2 +-
 arch/mips/include/asm/atomic.h                                    | 2 +-
 arch/mips/include/asm/bitops.h                                    | 2 +-
 arch/mips/include/asm/branch.h                                    | 2 +-
 arch/mips/include/asm/cacheflush.h                                | 2 +-
 arch/mips/include/asm/{cpu-features.h => cpucaps.h}               | 8 ++++----
 arch/mips/include/asm/dsp.h                                       | 2 +-
 arch/mips/include/asm/fpu.h                                       | 2 +-
 arch/mips/include/asm/highmem.h                                   | 2 +-
 arch/mips/include/asm/io.h                                        | 2 +-
 .../mach-ath25/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 8 ++++----
 .../mach-ath79/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 8 ++++----
 .../mach-au1x00/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
 .../mach-bcm47xx/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
 .../mach-bcm63xx/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
 .../mach-bmips/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
 .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 4 ++--
 .../mach-cobalt/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
 .../asm/mach-dec/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
 .../mach-generic/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
 .../mach-ip22/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
 .../mach-ip27/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
 .../mach-ip28/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
 .../mach-ip32/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
 .../mach-jz4740/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 4 ++--
 .../falcon/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
 .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
 .../mach-malta/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
 .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
 .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
 .../mach-pic32/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
 .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
 .../mt7620/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
 .../mt7621/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
 .../rt288x/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
 .../rt305x/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
 .../rt3883/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
 .../mach-rc32434/{cpu-feature-overrides.h => cpucaps-overrides.h} | 8 ++++----
 .../asm/mach-rm/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
 .../mach-sibyte/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
 .../mach-tx49xx/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
 arch/mips/include/asm/r4kcache.h                                  | 2 +-
 arch/mips/include/asm/switch_to.h                                 | 2 +-
 arch/mips/include/asm/timex.h                                     | 2 +-
 arch/mips/include/asm/tlb.h                                       | 2 +-
 arch/mips/kernel/branch.c                                         | 2 +-
 arch/mips/kernel/cpu-probe.c                                      | 2 +-
 arch/mips/kernel/elf.c                                            | 2 +-
 arch/mips/kernel/proc.c                                           | 2 +-
 arch/mips/kernel/signal.c                                         | 2 +-
 arch/mips/kernel/signal_n32.c                                     | 2 +-
 arch/mips/kernel/smp-bmips.c                                      | 2 +-
 arch/mips/kernel/sysrq.c                                          | 2 +-
 arch/mips/kernel/time.c                                           | 2 +-
 arch/mips/kernel/uprobes.c                                        | 2 +-
 arch/mips/mm/c-octeon.c                                           | 2 +-
 arch/mips/mm/c-r4k.c                                              | 2 +-
 arch/mips/mm/cache.c                                              | 2 +-
 arch/mips/mm/gup.c                                                | 2 +-
 arch/mips/net/bpf_jit.c                                           | 2 +-
 arch/mips/netlogic/common/time.c                                  | 2 +-
 arch/mips/pistachio/irq.c                                         | 2 +-
 63 files changed, 135 insertions(+), 135 deletions(-)
 rename arch/mips/include/asm/{cpu-features.h => cpucaps.h} (99%)
 rename arch/mips/include/asm/mach-ath25/{cpu-feature-overrides.h => cpucaps-overrides.h} (86%)
 rename arch/mips/include/asm/mach-ath79/{cpu-feature-overrides.h => cpucaps-overrides.h} (85%)
 rename arch/mips/include/asm/mach-au1x00/{cpu-feature-overrides.h => cpucaps-overrides.h} (91%)
 rename arch/mips/include/asm/mach-bcm47xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (93%)
 rename arch/mips/include/asm/mach-bcm63xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
 rename arch/mips/include/asm/mach-bmips/{cpu-feature-overrides.h => cpucaps-overrides.h} (64%)
 rename arch/mips/include/asm/mach-cavium-octeon/{cpu-feature-overrides.h => cpucaps-overrides.h} (94%)
 rename arch/mips/include/asm/mach-cobalt/{cpu-feature-overrides.h => cpucaps-overrides.h} (90%)
 rename arch/mips/include/asm/mach-dec/{cpu-feature-overrides.h => cpucaps-overrides.h} (95%)
 rename arch/mips/include/asm/mach-generic/{cpu-feature-overrides.h => cpucaps-overrides.h} (61%)
 rename arch/mips/include/asm/mach-ip22/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
 rename arch/mips/include/asm/mach-ip27/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
 rename arch/mips/include/asm/mach-ip28/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
 rename arch/mips/include/asm/mach-ip32/{cpu-feature-overrides.h => cpucaps-overrides.h} (89%)
 rename arch/mips/include/asm/mach-jz4740/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
 rename arch/mips/include/asm/mach-lantiq/falcon/{cpu-feature-overrides.h => cpucaps-overrides.h} (85%)
 rename arch/mips/include/asm/mach-loongson64/{cpu-feature-overrides.h => cpucaps-overrides.h} (89%)
 rename arch/mips/include/asm/mach-malta/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
 rename arch/mips/include/asm/mach-netlogic/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
 rename arch/mips/include/asm/mach-paravirt/{cpu-feature-overrides.h => cpucaps-overrides.h} (83%)
 rename arch/mips/include/asm/mach-pic32/{cpu-feature-overrides.h => cpucaps-overrides.h} (82%)
 rename arch/mips/include/asm/mach-pmcs-msp71xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (76%)
 rename arch/mips/include/asm/mach-ralink/mt7620/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
 rename arch/mips/include/asm/mach-ralink/mt7621/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
 rename arch/mips/include/asm/mach-ralink/rt288x/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
 rename arch/mips/include/asm/mach-ralink/rt305x/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
 rename arch/mips/include/asm/mach-ralink/rt3883/{cpu-feature-overrides.h => cpucaps-overrides.h} (86%)
 rename arch/mips/include/asm/mach-rc32434/{cpu-feature-overrides.h => cpucaps-overrides.h} (90%)
 rename arch/mips/include/asm/mach-rm/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
 rename arch/mips/include/asm/mach-sibyte/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
 rename arch/mips/include/asm/mach-tx49xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (74%)

diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index 61a0bf1..02d27ca 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -24,7 +24,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/cpu-type.h>
 #include <asm/irq.h>
 #include <asm/irq_cpu.h>
diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 1914e56..bf9e093 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -11,7 +11,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/param.h>
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/ds1287.h>
 #include <asm/time.h>
 #include <asm/dec/interrupts.h>
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 0ab176b..753eaca 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -18,7 +18,7 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <asm/compiler.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/cmpxchg.h>
 #include <asm/war.h>
 
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index fa57cef..1eec0ce 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -18,7 +18,7 @@
 #include <asm/barrier.h>
 #include <asm/byteorder.h>		/* sigh ... */
 #include <asm/compiler.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/llsc.h>
 #include <asm/sgidefs.h>
 #include <asm/war.h>
diff --git a/arch/mips/include/asm/branch.h b/arch/mips/include/asm/branch.h
index de781cf..c99589a 100644
--- a/arch/mips/include/asm/branch.h
+++ b/arch/mips/include/asm/branch.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_BRANCH_H
 #define _ASM_BRANCH_H
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/mipsregs.h>
 #include <asm/ptrace.h>
 #include <asm/inst.h>
diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 4812d1f..858d365 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -11,7 +11,7 @@
 
 /* Keep includes the same across arches.  */
 #include <linux/mm.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 
 /* Cache flushing:
  *
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpucaps.h
similarity index 99%
rename from arch/mips/include/asm/cpu-features.h
rename to arch/mips/include/asm/cpucaps.h
index e961c8a..49f0029 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpucaps.h
@@ -6,12 +6,12 @@
  * Copyright (C) 2003, 2004 Ralf Baechle
  * Copyright (C) 2004  Maciej W. Rozycki
  */
-#ifndef __ASM_CPU_FEATURES_H
-#define __ASM_CPU_FEATURES_H
+#ifndef __ASM_CPUCAPS_H
+#define __ASM_CPUCAPS_H
 
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
-#include <cpu-feature-overrides.h>
+#include <cpucaps-overrides.h>
 
 /*
  * SMP assumption: Options of CPU 0 are a superset of all processors.
@@ -566,4 +566,4 @@
 #define cpu_guest_has_dyn_maar	(cpu_data[0].guest.options_dyn & MIPS_CPU_MAAR)
 #endif
 
-#endif /* __ASM_CPU_FEATURES_H */
+#endif /* __ASM_CPUCAPS_H */
diff --git a/arch/mips/include/asm/dsp.h b/arch/mips/include/asm/dsp.h
index 7bfad05..8acd283 100644
--- a/arch/mips/include/asm/dsp.h
+++ b/arch/mips/include/asm/dsp.h
@@ -11,7 +11,7 @@
 #define _ASM_DSP_H
 
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/hazards.h>
 #include <asm/mipsregs.h>
 
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index f94455f..1acdad1 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -18,7 +18,7 @@
 
 #include <asm/mipsregs.h>
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/fpu_emulator.h>
 #include <asm/hazards.h>
 #include <asm/processor.h>
diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index d34536e..39ae2fa 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -22,7 +22,7 @@
 #include <linux/bug.h>
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/kmap_types.h>
 
 /* declarations for highmem.c */
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index ecabc00..332efeb 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -21,7 +21,7 @@
 #include <asm/bug.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm-generic/iomap.h>
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath25/cpucaps-overrides.h
similarity index 86%
rename from arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ath25/cpucaps-overrides.h
index ade0356..fe23703 100644
--- a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath25/cpucaps-overrides.h
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2008 Gabor Juhos <juhosg@openwrt.org>
  *
- *  This file was derived from: include/asm-mips/cpu-features.h
+ *  This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -12,8 +12,8 @@
  *  by the Free Software Foundation.
  *
  */
-#ifndef __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_ATH25_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_ATH25_CPUCAPS_OVERRIDES_H
 
 /*
  * The Atheros AR531x/AR231x SoCs have MIPS 4Kc/4KEc core.
@@ -61,4 +61,4 @@
 #define cpu_has_64bit_gp_regs		0
 #define cpu_has_64bit_addresses		0
 
-#endif /* __ASM_MACH_ATH25_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_ATH25_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpucaps-overrides.h
similarity index 85%
rename from arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ath79/cpucaps-overrides.h
index 0089a74..6e3857b 100644
--- a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath79/cpucaps-overrides.h
@@ -4,7 +4,7 @@
  *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
- *  This file was derived from: include/asm-mips/cpu-features.h
+ *  This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -13,8 +13,8 @@
  *  by the Free Software Foundation.
  *
  */
-#ifndef __ASM_MACH_ATH79_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_ATH79_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_ATH79_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_ATH79_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
@@ -52,4 +52,4 @@
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
 
-#endif /* __ASM_MACH_ATH79_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_ATH79_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h b/arch/mips/include/asm/mach-au1x00/cpucaps-overrides.h
similarity index 91%
rename from arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-au1x00/cpucaps-overrides.h
index c5b6eef..87b68e7 100644
--- a/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-au1x00/cpucaps-overrides.h
@@ -4,8 +4,8 @@
  * for more details.
  */
 
-#ifndef __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_AU1X00_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_AU1X00_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb			1
 #define cpu_has_tlbinv			0
@@ -62,4 +62,4 @@
 #define cpu_has_vz			0
 #define cpu_has_msa			0
 
-#endif /* __ASM_MACH_AU1X00_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_AU1X00_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm47xx/cpucaps-overrides.h
similarity index 93%
rename from arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-bcm47xx/cpucaps-overrides.h
index b7992cd..68bf2f9 100644
--- a/arch/mips/include/asm/mach-bcm47xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bcm47xx/cpucaps-overrides.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_MACH_BCM47XX_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_BCM47XX_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_BCM47XX_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_BCM47XX_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb			1
 #define cpu_has_4kex			1
@@ -79,4 +79,4 @@
 #define cpu_scache_line_size()		0
 #define cpu_has_vz			0
 
-#endif /* __ASM_MACH_BCM47XX_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_BCM47XX_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm63xx/cpucaps-overrides.h
similarity index 87%
rename from arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-bcm63xx/cpucaps-overrides.h
index bc1167d..84b8879 100644
--- a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bcm63xx/cpucaps-overrides.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_MACH_BCM963XX_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_BCM963XX_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_BCM963XX_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_BCM963XX_CPUCAPS_OVERRIDES_H
 
 #include <bcm63xx_cpu.h>
 
@@ -49,4 +49,4 @@
 #define cpu_icache_line_size()		16
 #define cpu_scache_line_size()		0
 
-#endif /* __ASM_MACH_BCM963XX_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_BCM963XX_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bmips/cpucaps-overrides.h
similarity index 64%
rename from arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-bmips/cpucaps-overrides.h
index fa0583e..711741a 100644
--- a/arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-bmips/cpucaps-overrides.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_BMIPS_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_BMIPS_CPUCAPS_OVERRIDES_H
 
 /* Invariants across all BMIPS processors */
 #define cpu_has_vtag_icache		0
@@ -11,4 +11,4 @@
 #define cpu_has_mips64r1		0
 #define cpu_has_mips64r2		0
 
-#endif /* __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_BMIPS_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpucaps-overrides.h
similarity index 94%
rename from arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-cavium-octeon/cpucaps-overrides.h
index bd8b9bb..2c1ecd2 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpucaps-overrides.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2004 Cavium Networks
  */
-#ifndef __ASM_MACH_CAVIUM_OCTEON_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_CAVIUM_OCTEON_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_CAVIUM_OCTEON_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_CAVIUM_OCTEON_CPUCAPS_OVERRIDES_H
 
 #include <linux/types.h>
 #include <asm/mipsregs.h>
diff --git a/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cobalt/cpucaps-overrides.h
similarity index 90%
rename from arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-cobalt/cpucaps-overrides.h
index 30c5cd9..8c4b47a 100644
--- a/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cobalt/cpucaps-overrides.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2006, 07 Ralf Baechle (ralf@linux-mips.org)
  */
-#ifndef __ASM_COBALT_CPU_FEATURE_OVERRIDES_H
-#define __ASM_COBALT_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_COBALT_CPUCAPS_OVERRIDES_H
+#define __ASM_COBALT_CPUCAPS_OVERRIDES_H
 
 
 #define cpu_has_tlb		1
@@ -53,4 +53,4 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#endif /* __ASM_COBALT_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_COBALT_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h b/arch/mips/include/asm/mach-dec/cpucaps-overrides.h
similarity index 95%
rename from arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-dec/cpucaps-overrides.h
index 21eae03..71ca90d 100644
--- a/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-dec/cpucaps-overrides.h
@@ -9,8 +9,8 @@
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  */
-#ifndef __ASM_MACH_DEC_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_DEC_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_DEC_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_DEC_CPUCAPS_OVERRIDES_H
 
 /* Generic ones first.  */
 #define cpu_has_tlb			1
@@ -99,4 +99,4 @@
 #define cpu_scache_line_size()		32
 #endif /* CONFIG_CPU_R4X00 */
 
-#endif /* __ASM_MACH_DEC_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_DEC_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-generic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-generic/cpucaps-overrides.h
similarity index 61%
rename from arch/mips/include/asm/mach-generic/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-generic/cpucaps-overrides.h
index 42be9e9..c97fbc7 100644
--- a/arch/mips/include/asm/mach-generic/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-generic/cpucaps-overrides.h
@@ -5,9 +5,9 @@
  *
  * Copyright (C) 2003 Ralf Baechle
  */
-#ifndef __ASM_MACH_GENERIC_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_GENERIC_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_GENERIC_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_GENERIC_CPUCAPS_OVERRIDES_H
 
 /* Intentionally empty file ...	 */
 
-#endif /* __ASM_MACH_GENERIC_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_GENERIC_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip22/cpucaps-overrides.h
similarity index 88%
rename from arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ip22/cpucaps-overrides.h
index 9b19b72..d0d85be 100644
--- a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip22/cpucaps-overrides.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2003, 07 Ralf Baechle
  */
-#ifndef __ASM_MACH_IP22_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_IP22_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_IP22_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_IP22_CPUCAPS_OVERRIDES_H
 
 #include <asm/cpu.h>
 
@@ -47,4 +47,4 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#endif /* __ASM_MACH_IP22_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_IP22_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip27/cpucaps-overrides.h
similarity index 92%
rename from arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ip27/cpucaps-overrides.h
index 7449794..c762181 100644
--- a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip27/cpucaps-overrides.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2003, 07 Ralf Baechle
  */
-#ifndef __ASM_MACH_IP27_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_IP27_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_IP27_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_IP27_CPUCAPS_OVERRIDES_H
 
 #include <asm/cpu.h>
 
@@ -76,4 +76,4 @@
 #define cpu_icache_line_size()		64
 #define cpu_scache_line_size()		128
 
-#endif /* __ASM_MACH_IP27_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_IP27_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip28/cpucaps-overrides.h
similarity index 88%
rename from arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ip28/cpucaps-overrides.h
index 4cec06d..67a3fe1 100644
--- a/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip28/cpucaps-overrides.h
@@ -6,8 +6,8 @@
  * Copyright (C) 2003 Ralf Baechle
  * 6/2004	pf
  */
-#ifndef __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_IP28_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_IP28_CPUCAPS_OVERRIDES_H
 
 #include <asm/cpu.h>
 
@@ -50,4 +50,4 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#endif /* __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_IP28_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip32/cpucaps-overrides.h
similarity index 89%
rename from arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ip32/cpucaps-overrides.h
index 241409b..b11c138 100644
--- a/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip32/cpucaps-overrides.h
@@ -6,8 +6,8 @@
  * Copyright (C) 2005 Ilya A. Volynets-Evenbakh
  * Copyright (C) 2005, 07 Ralf Baechle (ralf@linux-mips.org)
  */
-#ifndef __ASM_MACH_IP32_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_IP32_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_IP32_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_IP32_CPUCAPS_OVERRIDES_H
 
 
 /*
@@ -47,4 +47,4 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#endif /* __ASM_MACH_IP32_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_IP32_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h b/arch/mips/include/asm/mach-jz4740/cpucaps-overrides.h
similarity index 92%
rename from arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-jz4740/cpucaps-overrides.h
index 0933f94..9ba91b9 100644
--- a/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-jz4740/cpucaps-overrides.h
@@ -4,8 +4,8 @@
  * for more details.
  *
  */
-#ifndef __ASM_MACH_JZ4740_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_JZ4740_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_JZ4740_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_JZ4740_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb 1
 #define cpu_has_4kex		1
diff --git a/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-lantiq/falcon/cpucaps-overrides.h
similarity index 85%
rename from arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-lantiq/falcon/cpucaps-overrides.h
index 096a100..b476f01 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/cpucaps-overrides.h
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2013 Thomas Langer, Lantiq Deutschland
  *
- *  This file was derived from: include/asm-mips/cpu-features.h
+ *  This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -12,8 +12,8 @@
  *  by the Free Software Foundation.
  *
  */
-#ifndef __ASM_MACH_FALCON_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_FALCON_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_FALCON_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_FALCON_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
@@ -55,4 +55,4 @@
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
 
-#endif /* __ASM_MACH_FALCON_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_FALCON_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpucaps-overrides.h
similarity index 89%
rename from arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-loongson64/cpucaps-overrides.h
index 89328a3d..34136b5 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpucaps-overrides.h
@@ -13,8 +13,8 @@
  *	loongson2f user manual.
  */
 
-#ifndef __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_LOONGSON64_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_LOONGSON64_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_32fpr		1
 #define cpu_has_3k_cache	0
@@ -50,4 +50,4 @@
 #define cpu_hwrena_impl_bits	0xc0000000
 #endif
 
-#endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_LOONGSON64_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h b/arch/mips/include/asm/mach-malta/cpucaps-overrides.h
similarity index 92%
rename from arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-malta/cpucaps-overrides.h
index de3b66a..a8d2311 100644
--- a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-malta/cpucaps-overrides.h
@@ -6,8 +6,8 @@
  * Copyright (C) 2003, 2004 Chris Dearman
  * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
  */
-#ifndef __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_MIPS_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_MIPS_CPUCAPS_OVERRIDES_H
 
 
 /*
@@ -67,4 +67,4 @@
 #define cpu_icache_snoops_remote_store 1
 #endif
 
-#endif /* __ASM_MACH_MIPS_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_MIPS_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpucaps-overrides.h
similarity index 88%
rename from arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-netlogic/cpucaps-overrides.h
index 091deb17..59b6ba1 100644
--- a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-netlogic/cpucaps-overrides.h
@@ -6,8 +6,8 @@
  * Copyright (C) 2011 Netlogic Microsystems
  * Copyright (C) 2003 Ralf Baechle
  */
-#ifndef __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_NETLOGIC_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_NETLOGIC_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_4kex		1
 #define cpu_has_4k_cache	1
@@ -53,4 +53,4 @@
 #error "Unknown Netlogic CPU"
 #endif
 
-#endif /* __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_NETLOGIC_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-paravirt/cpu-feature-overrides.h b/arch/mips/include/asm/mach-paravirt/cpucaps-overrides.h
similarity index 83%
rename from arch/mips/include/asm/mach-paravirt/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-paravirt/cpucaps-overrides.h
index 725e1ed..65aa7ee 100644
--- a/arch/mips/include/asm/mach-paravirt/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-paravirt/cpucaps-overrides.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2013 Cavium, Inc.
  */
-#ifndef __ASM_MACH_PARAVIRT_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_PARAVIRT_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_PARAVIRT_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_PARAVIRT_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_4kex		1
 #define cpu_has_3k_cache	0
@@ -33,4 +33,4 @@
 #define cpu_has_4k_cache	1
 #endif
 
-#endif /* __ASM_MACH_PARAVIRT_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_PARAVIRT_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-pic32/cpu-feature-overrides.h b/arch/mips/include/asm/mach-pic32/cpucaps-overrides.h
similarity index 82%
rename from arch/mips/include/asm/mach-pic32/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-pic32/cpucaps-overrides.h
index 4682308..4ecffdd 100644
--- a/arch/mips/include/asm/mach-pic32/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-pic32/cpucaps-overrides.h
@@ -6,8 +6,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
-#ifndef __ASM_MACH_PIC32_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_PIC32_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_PIC32_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_PIC32_CPUCAPS_OVERRIDES_H
 
 /*
  * CPU feature overrides for PIC32 boards
@@ -29,4 +29,4 @@
 #error This platform does not support 64bit.
 #endif
 
-#endif /* __ASM_MACH_PIC32_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_PIC32_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-pmcs-msp71xx/cpucaps-overrides.h
similarity index 76%
rename from arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/cpucaps-overrides.h
index 016fa94..6f85ae7 100644
--- a/arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-pmcs-msp71xx/cpucaps-overrides.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2003, 04, 07 Ralf Baechle (ralf@linux-mips.org)
  */
-#ifndef __ASM_MACH_MSP71XX_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_MSP71XX_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_MSP71XX_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_MSP71XX_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_mips16		1
 #define cpu_has_dsp		1
@@ -19,4 +19,4 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#endif /* __ASM_MACH_MSP71XX_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_MSP71XX_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/mt7620/cpucaps-overrides.h
similarity index 87%
rename from arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ralink/mt7620/cpucaps-overrides.h
index f7bb8cf..b2d5a3e 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620/cpucaps-overrides.h
@@ -4,7 +4,7 @@
  * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
- * This file was derived from: include/asm-mips/cpu-features.h
+ * This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -13,8 +13,8 @@
  * by the Free Software Foundation.
  *
  */
-#ifndef _MT7620_CPU_FEATURE_OVERRIDES_H
-#define _MT7620_CPU_FEATURE_OVERRIDES_H
+#ifndef _MT7620_CPUCAPS_OVERRIDES_H
+#define _MT7620_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
@@ -54,4 +54,4 @@
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
 
-#endif /* _MT7620_CPU_FEATURE_OVERRIDES_H */
+#endif /* _MT7620_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/mt7621/cpucaps-overrides.h
similarity index 88%
rename from arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ralink/mt7621/cpucaps-overrides.h
index 15db1b3..f86e2de 100644
--- a/arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/mt7621/cpucaps-overrides.h
@@ -5,7 +5,7 @@
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  * Copyright (C) 2015 Felix Fietkau <nbd@openwrt.org>
  *
- * This file was derived from: include/asm-mips/cpu-features.h
+ * This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -14,8 +14,8 @@
  * by the Free Software Foundation.
  *
  */
-#ifndef _MT7621_CPU_FEATURE_OVERRIDES_H
-#define _MT7621_CPU_FEATURE_OVERRIDES_H
+#ifndef _MT7621_CPUCAPS_OVERRIDES_H
+#define _MT7621_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
@@ -62,4 +62,4 @@
 #define cpu_has_tlbinv		0
 #define cpu_has_userlocal	1
 
-#endif /* _MT7621_CPU_FEATURE_OVERRIDES_H */
+#endif /* _MT7621_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt288x/cpucaps-overrides.h
similarity index 87%
rename from arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ralink/rt288x/cpucaps-overrides.h
index 72fc106..8b68d33 100644
--- a/arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt288x/cpucaps-overrides.h
@@ -4,7 +4,7 @@
  * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
- * This file was derived from: include/asm-mips/cpu-features.h
+ * This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -13,8 +13,8 @@
  * by the Free Software Foundation.
  *
  */
-#ifndef _RT288X_CPU_FEATURE_OVERRIDES_H
-#define _RT288X_CPU_FEATURE_OVERRIDES_H
+#ifndef _RT288X_CPUCAPS_OVERRIDES_H
+#define _RT288X_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
@@ -53,4 +53,4 @@
 #define cpu_dcache_line_size()	16
 #define cpu_icache_line_size()	16
 
-#endif /* _RT288X_CPU_FEATURE_OVERRIDES_H */
+#endif /* _RT288X_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt305x/cpucaps-overrides.h
similarity index 87%
rename from arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ralink/rt305x/cpucaps-overrides.h
index 917c286..9b684f4 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x/cpucaps-overrides.h
@@ -4,7 +4,7 @@
  * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
- * This file was derived from: include/asm-mips/cpu-features.h
+ * This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -13,8 +13,8 @@
  * by the Free Software Foundation.
  *
  */
-#ifndef _RT305X_CPU_FEATURE_OVERRIDES_H
-#define _RT305X_CPU_FEATURE_OVERRIDES_H
+#ifndef _RT305X_CPUCAPS_OVERRIDES_H
+#define _RT305X_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
@@ -53,4 +53,4 @@
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
 
-#endif /* _RT305X_CPU_FEATURE_OVERRIDES_H */
+#endif /* _RT305X_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ralink/rt3883/cpucaps-overrides.h
similarity index 86%
rename from arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-ralink/rt3883/cpucaps-overrides.h
index 181fbf4..7ec1d65 100644
--- a/arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ralink/rt3883/cpucaps-overrides.h
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2011-2013 Gabor Juhos <juhosg@openwrt.org>
  *
- * This file was derived from: include/asm-mips/cpu-features.h
+ * This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -12,8 +12,8 @@
  * by the Free Software Foundation.
  *
  */
-#ifndef _RT3883_CPU_FEATURE_OVERRIDES_H
-#define _RT3883_CPU_FEATURE_OVERRIDES_H
+#ifndef _RT3883_CPUCAPS_OVERRIDES_H
+#define _RT3883_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
@@ -52,4 +52,4 @@
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
 
-#endif /* _RT3883_CPU_FEATURE_OVERRIDES_H */
+#endif /* _RT3883_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h b/arch/mips/include/asm/mach-rc32434/cpucaps-overrides.h
similarity index 90%
rename from arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-rc32434/cpucaps-overrides.h
index b153075..92065b3 100644
--- a/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-rc32434/cpucaps-overrides.h
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
  *
- *  This file was derived from: include/asm-mips/cpu-features.h
+ *  This file was derived from: include/asm-mips/cpucaps.h
  *	Copyright (C) 2003, 2004 Ralf Baechle
  *	Copyright (C) 2004 Maciej W. Rozycki
  *
@@ -22,8 +22,8 @@
  *  Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
  *  Boston, MA  02110-1301, USA.
  */
-#ifndef __ASM_MACH_RC32434_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_RC32434_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_RC32434_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_RC32434_CPUCAPS_OVERRIDES_H
 
 /*
  * The IDT RC32434 SOC has a built-in MIPS 4Kc core.
@@ -74,4 +74,4 @@
 #define cpu_dcache_line_size()		16
 #define cpu_icache_line_size()		16
 
-#endif /* __ASM_MACH_RC32434_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_RC32434_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h b/arch/mips/include/asm/mach-rm/cpucaps-overrides.h
similarity index 87%
rename from arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-rm/cpucaps-overrides.h
index d38be66..a3e7f8b 100644
--- a/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-rm/cpucaps-overrides.h
@@ -7,8 +7,8 @@
  *
  * SNI RM200 C apparently was only shipped with R4600 V2.0 and R5000 processors.
  */
-#ifndef __ASM_MACH_RM200_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_RM200_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_RM200_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_RM200_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
@@ -38,4 +38,4 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#endif /* __ASM_MACH_RM200_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_RM200_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h b/arch/mips/include/asm/mach-sibyte/cpucaps-overrides.h
similarity index 87%
rename from arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-sibyte/cpucaps-overrides.h
index 92927b6..d4163b1 100644
--- a/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-sibyte/cpucaps-overrides.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 2003, 04, 07 Ralf Baechle (ralf@linux-mips.org)
  */
-#ifndef __ASM_MACH_SIBYTE_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_SIBYTE_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_SIBYTE_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_SIBYTE_CPUCAPS_OVERRIDES_H
 
 /*
  * Sibyte are MIPS64 processors wired to a specific configuration
@@ -45,4 +45,4 @@
 #define cpu_icache_line_size()	32
 #define cpu_scache_line_size()	32
 
-#endif /* __ASM_MACH_SIBYTE_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_SIBYTE_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-tx49xx/cpucaps-overrides.h
similarity index 74%
rename from arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-tx49xx/cpucaps-overrides.h
index 7f5144c..fcd60d8 100644
--- a/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-tx49xx/cpucaps-overrides.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_MACH_TX49XX_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_TX49XX_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_TX49XX_CPUCAPS_OVERRIDES_H
+#define __ASM_MACH_TX49XX_CPUCAPS_OVERRIDES_H
 
 #define cpu_has_llsc	1
 #define cpu_has_64bits	1
@@ -21,4 +21,4 @@
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 
-#endif /* __ASM_MACH_TX49XX_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_TX49XX_CPUCAPS_OVERRIDES_H */
diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 55fd94e..fa0b7b5 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -17,7 +17,7 @@
 #include <asm/asm.h>
 #include <asm/cacheops.h>
 #include <asm/compiler.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/cpu-type.h>
 #include <asm/mipsmtregs.h>
 #include <linux/uaccess.h> /* for segment_eq() */
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index e610473..b014ef1 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -12,7 +12,7 @@
 #ifndef _ASM_SWITCH_TO_H
 #define _ASM_SWITCH_TO_H
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/watch.h>
 #include <asm/dsp.h>
 #include <asm/cop2.h>
diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
index b05bb70..4383bc4 100644
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -14,7 +14,7 @@
 #include <linux/compiler.h>
 
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/mipsregs.h>
 #include <asm/cpu-type.h>
 
diff --git a/arch/mips/include/asm/tlb.h b/arch/mips/include/asm/tlb.h
index dd179fd..3337d35 100644
--- a/arch/mips/include/asm/tlb.h
+++ b/arch/mips/include/asm/tlb.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_TLB_H
 #define __ASM_TLB_H
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/mipsregs.h>
 
 /*
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index b11facd..68122ab 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -12,7 +12,7 @@
 #include <linux/export.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/inst.h>
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 07718bb..719337a 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -20,7 +20,7 @@
 
 #include <asm/bugs.h>
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/cpu-type.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 6430bff..ea4970e 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -13,7 +13,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/cpu-info.h>
 
 /* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 4eff2ae..b0ec24d 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -9,7 +9,7 @@
 #include <linux/seq_file.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/idle.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 9e22446..04214ee 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -34,7 +34,7 @@
 #include <asm/fpu.h>
 #include <asm/sim.h>
 #include <asm/ucontext.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/war.h>
 #include <asm/dsp.h>
 #include <asm/inst.h>
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index b672ceb..335ef22 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -36,7 +36,7 @@
 #include <linux/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/fpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/war.h>
 
 #include "signal-common.h"
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 1b070a7..6378f1b 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -37,7 +37,7 @@
 #include <asm/bmips.h>
 #include <asm/traps.h>
 #include <asm/barrier.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 
 static int __maybe_unused max_cpus = 1;
 
diff --git a/arch/mips/kernel/sysrq.c b/arch/mips/kernel/sysrq.c
index 5f05539..c46f4fc 100644
--- a/arch/mips/kernel/sysrq.c
+++ b/arch/mips/kernel/sysrq.c
@@ -9,7 +9,7 @@
 #include <linux/sysrq.h>
 #include <linux/workqueue.h>
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/mipsregs.h>
 #include <asm/tlbdebug.h>
 
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index a7f8126..1bbf989 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -23,7 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/cpu-type.h>
 #include <asm/div64.h>
 #include <asm/time.h>
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index e99e3fae..f045714 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -6,7 +6,7 @@
 #include <linux/uprobes.h>
 
 #include <asm/branch.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/ptrace.h>
 
 #include "probes-common.h"
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 0e45b06..6da6511 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -17,7 +17,7 @@
 #include <asm/bcache.h>
 #include <asm/bootinfo.h>
 #include <asm/cacheops.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/cpu-type.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e7f798d..6179c79 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -25,7 +25,7 @@
 #include <asm/cache.h>
 #include <asm/cacheops.h>
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/cpu-type.h>
 #include <asm/io.h>
 #include <asm/page.h>
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 6db3413..78afed0 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -19,7 +19,7 @@
 #include <asm/highmem.h>
 #include <asm/processor.h>
 #include <asm/cpu.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 
 /* Cache operations. */
 void (*flush_cache_all)(void);
diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index d8c3c15..c3d3245 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -12,7 +12,7 @@
 #include <linux/swap.h>
 #include <linux/hugetlb.h>
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/pgtable.h>
 
 static inline pte_t gup_get_pte(pte_t *ptep)
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 49a2e22..c619ddd 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -22,7 +22,7 @@
 #include <asm/asm.h>
 #include <asm/bitops.h>
 #include <asm/cacheflush.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/uasm.h>
 
 #include "bpf_jit.h"
diff --git a/arch/mips/netlogic/common/time.c b/arch/mips/netlogic/common/time.c
index cbbf0d4..def4439 100644
--- a/arch/mips/netlogic/common/time.c
+++ b/arch/mips/netlogic/common/time.c
@@ -35,7 +35,7 @@
 #include <linux/init.h>
 
 #include <asm/time.h>
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 
 #include <asm/netlogic/interrupt.h>
 #include <asm/netlogic/common.h>
diff --git a/arch/mips/pistachio/irq.c b/arch/mips/pistachio/irq.c
index 0a6b24c..2b8affb 100644
--- a/arch/mips/pistachio/irq.c
+++ b/arch/mips/pistachio/irq.c
@@ -13,7 +13,7 @@
 #include <linux/irqchip/mips-gic.h>
 #include <linux/kernel.h>
 
-#include <asm/cpu-features.h>
+#include <asm/cpucaps.h>
 #include <asm/irq_cpu.h>
 
 void __init arch_init_irq(void)
-- 
2.7.4
