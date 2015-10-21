Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 10:57:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21443 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009210AbbJUI55l8W-X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 10:57:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 11EBA4C0E7952;
        Wed, 21 Oct 2015 09:57:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Oct 2015 09:57:49 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.37) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 21 Oct 2015 09:57:48 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>, <linux-kernel@vger.kernel.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>
Subject: [PATCH v3 3/3] MIPS: VDSO: Add implementations of gettimeofday() and clock_gettime()
Date:   Wed, 21 Oct 2015 09:57:44 +0100
Message-ID: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1444645496-32046-1-git-send-email-markos.chandras@imgtec.com>
References: <1444645496-32046-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.37]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Alex Smith <alex.smith@imgtec.com>

Add user-mode implementations of gettimeofday() and clock_gettime() to
the VDSO. This is currently usable with 2 clocksources: the CP0 count
register, which is accessible to user-mode via RDHWR on R2 and later
cores, or the MIPS Global Interrupt Controller (GIC) timer, which
provides a "user-mode visible" section containing a mirror of its
counter registers. This section must be mapped into user memory, which
is done below the VDSO data page.

When a supported clocksource is not in use, the VDSO functions will
return -ENOSYS, which causes libc to fall back on the standard syscall
path.

When support for neither of these clocksources is compiled into the
kernel at all, the VDSO still provides clock_gettime(), as the coarse
realtime/monotonic clocks can still be implemented. However,
gettimeofday() is not provided in this case as nothing can be done
without a suitable clocksource. This causes the symbol lookup to fail
in libc and it will then always use the standard syscall path.

This patch includes a workaround for a bug in QEMU which results in
RDHWR on the CP0 count register always returning a constant (incorrect)
value. A fix for this has been submitted, and the workaround can be
removed after the fix has been in stable releases for a reasonable
amount of time.

A simple performance test which calls gettimeofday() 1000 times in a
loop and calculates the average execution time gives the following
results on a Malta + I6400 (running at 20MHz):

 - Syscall:    ~31000 ns
 - VDSO (GIC): ~15000 ns
 - VDSO (CP0): ~9500 ns

[markos.chandras@imgtec.com:
- Minor code re-arrangements in order for mappings to be made
in the order they appear to the process' address space.
- Move do_{monotonic, realtime} outside of the MIPS_CLOCK_VSYSCALL ifdef
- Use gic_get_usm_range so we can do the GIC mapping in the
arch/mips/kernel/vdso instead of the GIC irqchip driver]

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v2:
- Do not export VDSO symbols if the toolchain does not have proper support
for the VDSO.

Changes since v1:
- Use gic_get_usm_range so we can do the GIC mapping in the
arch/mips/kernel/vdso instead of the GIC irqchip driver
---
 arch/mips/Kconfig                    |   5 +
 arch/mips/include/asm/clocksource.h  |  29 +++++
 arch/mips/include/asm/vdso.h         |  68 +++++++++-
 arch/mips/kernel/csrc-r4k.c          |  44 +++++++
 arch/mips/kernel/vdso.c              |  71 ++++++++++-
 arch/mips/vdso/gettimeofday.c        | 232 +++++++++++++++++++++++++++++++++++
 arch/mips/vdso/vdso.h                |   9 ++
 arch/mips/vdso/vdso.lds.S            |   5 +
 drivers/clocksource/mips-gic-timer.c |   7 +-
 9 files changed, 460 insertions(+), 10 deletions(-)
 create mode 100644 arch/mips/include/asm/clocksource.h
 create mode 100644 arch/mips/vdso/gettimeofday.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0b4ef1..68f4f246887c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -60,6 +60,8 @@ config MIPS
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select GENERIC_TIME_VSYSCALL
+	select ARCH_CLOCKSOURCE_DATA
 
 menu "Machine selection"
 
@@ -1036,6 +1038,9 @@ config CSRC_R4K
 config CSRC_SB1250
 	bool
 
+config MIPS_CLOCK_VSYSCALL
+	def_bool CSRC_R4K || CLKSRC_MIPS_GIC
+
 config GPIO_TXX9
 	select ARCH_REQUIRE_GPIOLIB
 	bool
diff --git a/arch/mips/include/asm/clocksource.h b/arch/mips/include/asm/clocksource.h
new file mode 100644
index 000000000000..3deb1d0c1a94
--- /dev/null
+++ b/arch/mips/include/asm/clocksource.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_CLOCKSOURCE_H
+#define __ASM_CLOCKSOURCE_H
+
+#include <linux/types.h>
+
+/* VDSO clocksources. */
+#define VDSO_CLOCK_NONE		0	/* No suitable clocksource. */
+#define VDSO_CLOCK_R4K		1	/* Use the coprocessor 0 count. */
+#define VDSO_CLOCK_GIC		2	/* Use the GIC. */
+
+/**
+ * struct arch_clocksource_data - Architecture-specific clocksource information.
+ * @vdso_clock_mode: Method the VDSO should use to access the clocksource.
+ */
+struct arch_clocksource_data {
+	u8 vdso_clock_mode;
+};
+
+#endif /* __ASM_CLOCKSOURCE_H */
diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index db2d45be8f2e..8f4ca5dd992b 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -13,6 +13,8 @@
 
 #include <linux/mm_types.h>
 
+#include <asm/barrier.h>
+
 /**
  * struct mips_vdso_image - Details of a VDSO image.
  * @data: Pointer to VDSO image data (page-aligned).
@@ -53,18 +55,82 @@ extern struct mips_vdso_image vdso_image_n32;
 
 /**
  * union mips_vdso_data - Data provided by the kernel for the VDSO.
+ * @xtime_sec:		Current real time (seconds part).
+ * @xtime_nsec:		Current real time (nanoseconds part, shifted).
+ * @wall_to_mono_sec:	Wall-to-monotonic offset (seconds part).
+ * @wall_to_mono_nsec:	Wall-to-monotonic offset (nanoseconds part).
+ * @seq_count:		Counter to synchronise updates (odd = updating).
+ * @cs_shift:		Clocksource shift value.
+ * @clock_mode:		Clocksource to use for time functions.
+ * @cs_mult:		Clocksource multiplier value.
+ * @cs_cycle_last:	Clock cycle value at last update.
+ * @cs_mask:		Clocksource mask value.
+ * @tz_minuteswest:	Minutes west of Greenwich (from timezone).
+ * @tz_dsttime:		Type of DST correction (from timezone).
  *
  * This structure contains data needed by functions within the VDSO. It is
- * populated by the kernel and mapped read-only into user memory.
+ * populated by the kernel and mapped read-only into user memory. The time
+ * fields are mirrors of internal data from the timekeeping infrastructure.
  *
  * Note: Care should be taken when modifying as the layout must remain the same
  * for both 64- and 32-bit (for 32-bit userland on 64-bit kernel).
  */
 union mips_vdso_data {
 	struct {
+		u64 xtime_sec;
+		u64 xtime_nsec;
+		u32 wall_to_mono_sec;
+		u32 wall_to_mono_nsec;
+		u32 seq_count;
+		u32 cs_shift;
+		u8 clock_mode;
+		u32 cs_mult;
+		u64 cs_cycle_last;
+		u64 cs_mask;
+		s32 tz_minuteswest;
+		s32 tz_dsttime;
 	};
 
 	u8 page[PAGE_SIZE];
 };
 
+static inline u32 vdso_data_read_begin(const union mips_vdso_data *data)
+{
+	u32 seq;
+
+	while (true) {
+		seq = ACCESS_ONCE(data->seq_count);
+		if (likely(!(seq & 1))) {
+			/* Paired with smp_wmb() in vdso_data_write_*(). */
+			smp_rmb();
+			return seq;
+		}
+
+		cpu_relax();
+	}
+}
+
+static inline bool vdso_data_read_retry(const union mips_vdso_data *data,
+					u32 start_seq)
+{
+	/* Paired with smp_wmb() in vdso_data_write_*(). */
+	smp_rmb();
+	return unlikely(data->seq_count != start_seq);
+}
+
+static inline void vdso_data_write_begin(union mips_vdso_data *data)
+{
+	++data->seq_count;
+
+	/* Ensure sequence update is written before other data page values. */
+	smp_wmb();
+}
+
+static inline void vdso_data_write_end(union mips_vdso_data *data)
+{
+	/* Ensure data values are written before updating sequence again. */
+	smp_wmb();
+	++data->seq_count;
+}
+
 #endif /* __ASM_VDSO_H */
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e5ed7ada1433..1f910563fdf6 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -28,6 +28,43 @@ static u64 notrace r4k_read_sched_clock(void)
 	return read_c0_count();
 }
 
+static inline unsigned int rdhwr_count(void)
+{
+	unsigned int count;
+
+	__asm__ __volatile__(
+	"	.set push\n"
+	"	.set mips32r2\n"
+	"	rdhwr	%0, $2\n"
+	"	.set pop\n"
+	: "=r" (count));
+
+	return count;
+}
+
+static bool rdhwr_count_usable(void)
+{
+	unsigned int prev, curr, i;
+
+	/*
+	 * Older QEMUs have a broken implementation of RDHWR for the CP0 count
+	 * which always returns a constant value. Try to identify this and don't
+	 * use it in the VDSO if it is broken. This workaround can be removed
+	 * once the fix has been in QEMU stable for a reasonable amount of time.
+	 */
+	for (i = 0, prev = rdhwr_count(); i < 100; i++) {
+		curr = rdhwr_count();
+
+		if (curr != prev)
+			return true;
+
+		prev = curr;
+	}
+
+	pr_warn("Not using R4K clocksource in VDSO due to broken RDHWR\n");
+	return false;
+}
+
 int __init init_r4k_clocksource(void)
 {
 	if (!cpu_has_counter || !mips_hpt_frequency)
@@ -36,6 +73,13 @@ int __init init_r4k_clocksource(void)
 	/* Calculate a somewhat reasonable rating value */
 	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
 
+	/*
+	 * R2 onwards makes the count accessible to user mode so it can be used
+	 * by the VDSO (HWREna is configured by configure_hwrena()).
+	 */
+	if (cpu_has_mips_r2_r6 && rdhwr_count_usable())
+		clocksource_mips.archdata.vdso_clock_mode = VDSO_CLOCK_R4K;
+
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
 
 	sched_clock_register(r4k_read_sched_clock, 32, mips_hpt_frequency);
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 56cc3c4377fb..975e99759bab 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -12,9 +12,12 @@
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/irqchip/mips-gic.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
 #include <asm/vdso.h>
@@ -23,7 +26,7 @@
 static union mips_vdso_data vdso_data __page_aligned_data;
 
 /*
- * Mapping for the VDSO data pages. The real pages are mapped manually, as
+ * Mapping for the VDSO data/GIC pages. The real pages are mapped manually, as
  * what we map and where within the area they are mapped is determined at
  * runtime.
  */
@@ -64,25 +67,67 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+void update_vsyscall(struct timekeeper *tk)
+{
+	vdso_data_write_begin(&vdso_data);
+
+	vdso_data.xtime_sec = tk->xtime_sec;
+	vdso_data.xtime_nsec = tk->tkr_mono.xtime_nsec;
+	vdso_data.wall_to_mono_sec = tk->wall_to_monotonic.tv_sec;
+	vdso_data.wall_to_mono_nsec = tk->wall_to_monotonic.tv_nsec;
+	vdso_data.cs_shift = tk->tkr_mono.shift;
+
+	vdso_data.clock_mode = tk->tkr_mono.clock->archdata.vdso_clock_mode;
+	if (vdso_data.clock_mode != VDSO_CLOCK_NONE) {
+		vdso_data.cs_mult = tk->tkr_mono.mult;
+		vdso_data.cs_cycle_last = tk->tkr_mono.cycle_last;
+		vdso_data.cs_mask = tk->tkr_mono.mask;
+	}
+
+	vdso_data_write_end(&vdso_data);
+}
+
+void update_vsyscall_tz(void)
+{
+	if (vdso_data.clock_mode != VDSO_CLOCK_NONE) {
+		vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
+		vdso_data.tz_dsttime = sys_tz.tz_dsttime;
+	}
+}
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
 	struct mm_struct *mm = current->mm;
-	unsigned long base, vdso_addr;
+	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
 	struct vm_area_struct *vma;
+	struct resource gic_res;
 	int ret;
 
 	down_write(&mm->mmap_sem);
 
-	base = get_unmapped_area(NULL, 0, PAGE_SIZE + image->size, 0, 0);
+	/*
+	 * Determine total area size. This includes the VDSO data itself, the
+	 * data page, and the GIC user page if present. Always create a mapping
+	 * for the GIC user area if the GIC is present regardless of whether it
+	 * is the current clocksource, in case it comes into use later on. We
+	 * only map a page even though the total area is 64K, as we only need
+	 * the counter registers at the start.
+	 */
+	gic_size = gic_present ? PAGE_SIZE : 0;
+	vvar_size = gic_size + PAGE_SIZE;
+	size = vvar_size + image->size;
+
+	base = get_unmapped_area(NULL, 0, size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
 	}
 
-	vdso_addr = base + PAGE_SIZE;
+	data_addr = base + gic_size;
+	vdso_addr = data_addr + PAGE_SIZE;
 
-	vma = _install_special_mapping(mm, base, PAGE_SIZE,
+	vma = _install_special_mapping(mm, base, vvar_size,
 				       VM_READ | VM_MAYREAD,
 				       &vdso_vvar_mapping);
 	if (IS_ERR(vma)) {
@@ -90,8 +135,22 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		goto out;
 	}
 
+	/* Map GIC user page. */
+	if (gic_size) {
+		ret = gic_get_usm_range(&gic_res);
+		if (ret)
+			goto out;
+
+		ret = io_remap_pfn_range(vma, base,
+					 gic_res.start >> PAGE_SHIFT,
+					 gic_size,
+					 pgprot_noncached(PAGE_READONLY));
+		if (ret)
+			goto out;
+	}
+
 	/* Map data page. */
-	ret = remap_pfn_range(vma, base,
+	ret = remap_pfn_range(vma, data_addr,
 			      virt_to_phys(&vdso_data) >> PAGE_SHIFT,
 			      PAGE_SIZE, PAGE_READONLY);
 	if (ret)
diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
new file mode 100644
index 000000000000..ce89c9e294f9
--- /dev/null
+++ b/arch/mips/vdso/gettimeofday.c
@@ -0,0 +1,232 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include "vdso.h"
+
+#include <linux/compiler.h>
+#include <linux/irqchip/mips-gic.h>
+#include <linux/time.h>
+
+#include <asm/clocksource.h>
+#include <asm/io.h>
+#include <asm/mips-cm.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+
+static __always_inline int do_realtime_coarse(struct timespec *ts,
+					      const union mips_vdso_data *data)
+{
+	u32 start_seq;
+
+	do {
+		start_seq = vdso_data_read_begin(data);
+
+		ts->tv_sec = data->xtime_sec;
+		ts->tv_nsec = data->xtime_nsec >> data->cs_shift;
+	} while (vdso_data_read_retry(data, start_seq));
+
+	return 0;
+}
+
+static __always_inline int do_monotonic_coarse(struct timespec *ts,
+					       const union mips_vdso_data *data)
+{
+	u32 start_seq;
+	u32 to_mono_sec;
+	u32 to_mono_nsec;
+
+	do {
+		start_seq = vdso_data_read_begin(data);
+
+		ts->tv_sec = data->xtime_sec;
+		ts->tv_nsec = data->xtime_nsec >> data->cs_shift;
+
+		to_mono_sec = data->wall_to_mono_sec;
+		to_mono_nsec = data->wall_to_mono_nsec;
+	} while (vdso_data_read_retry(data, start_seq));
+
+	ts->tv_sec += to_mono_sec;
+	timespec_add_ns(ts, to_mono_nsec);
+
+	return 0;
+}
+
+#ifdef CONFIG_CSRC_R4K
+
+static __always_inline u64 read_r4k_count(void)
+{
+	unsigned int count;
+
+	__asm__ __volatile__(
+	"	.set push\n"
+	"	.set mips32r2\n"
+	"	rdhwr	%0, $2\n"
+	"	.set pop\n"
+	: "=r" (count));
+
+	return count;
+}
+
+#endif
+
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+
+static __always_inline u64 read_gic_count(const union mips_vdso_data *data)
+{
+	void __iomem *gic = get_gic(data);
+	u32 hi, hi2, lo;
+
+	do {
+		hi = __raw_readl(gic + GIC_UMV_SH_COUNTER_63_32_OFS);
+		lo = __raw_readl(gic + GIC_UMV_SH_COUNTER_31_00_OFS);
+		hi2 = __raw_readl(gic + GIC_UMV_SH_COUNTER_63_32_OFS);
+	} while (hi2 != hi);
+
+	return (((u64)hi) << 32) + lo;
+}
+
+#endif
+
+static __always_inline u64 get_ns(const union mips_vdso_data *data)
+{
+	u64 cycle_now, delta, nsec;
+
+	switch (data->clock_mode) {
+#ifdef CONFIG_CSRC_R4K
+	case VDSO_CLOCK_R4K:
+		cycle_now = read_r4k_count();
+		break;
+#endif
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+	case VDSO_CLOCK_GIC:
+		cycle_now = read_gic_count(data);
+		break;
+#endif
+	default:
+		return 0;
+	}
+
+	delta = (cycle_now - data->cs_cycle_last) & data->cs_mask;
+
+	nsec = (delta * data->cs_mult) + data->xtime_nsec;
+	nsec >>= data->cs_shift;
+
+	return nsec;
+}
+
+static __always_inline int do_realtime(struct timespec *ts,
+				       const union mips_vdso_data *data)
+{
+	u32 start_seq;
+	u64 ns;
+
+	do {
+		start_seq = vdso_data_read_begin(data);
+
+		if (data->clock_mode == VDSO_CLOCK_NONE)
+			return -ENOSYS;
+
+		ts->tv_sec = data->xtime_sec;
+		ns = get_ns(data);
+	} while (vdso_data_read_retry(data, start_seq));
+
+	ts->tv_nsec = 0;
+	timespec_add_ns(ts, ns);
+
+	return 0;
+}
+
+static __always_inline int do_monotonic(struct timespec *ts,
+					const union mips_vdso_data *data)
+{
+	u32 start_seq;
+	u64 ns;
+	u32 to_mono_sec;
+	u32 to_mono_nsec;
+
+	do {
+		start_seq = vdso_data_read_begin(data);
+
+		if (data->clock_mode == VDSO_CLOCK_NONE)
+			return -ENOSYS;
+
+		ts->tv_sec = data->xtime_sec;
+		ns = get_ns(data);
+
+		to_mono_sec = data->wall_to_mono_sec;
+		to_mono_nsec = data->wall_to_mono_nsec;
+	} while (vdso_data_read_retry(data, start_seq));
+
+	ts->tv_sec += to_mono_sec;
+	ts->tv_nsec = 0;
+	timespec_add_ns(ts, ns + to_mono_nsec);
+
+	return 0;
+}
+
+#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
+
+/*
+ * This is behind the ifdef so that we don't provide the symbol when there's no
+ * possibility of there being a usable clocksource, because there's nothing we
+ * can do without it. When libc fails the symbol lookup it should fall back on
+ * the standard syscall path.
+ */
+int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	const union mips_vdso_data *data = get_vdso_data();
+	struct timespec ts;
+	int ret;
+
+	ret = do_realtime(&ts, data);
+	if (ret)
+		return ret;
+
+	if (tv) {
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = ts.tv_nsec / 1000;
+	}
+
+	if (tz) {
+		tz->tz_minuteswest = data->tz_minuteswest;
+		tz->tz_dsttime = data->tz_dsttime;
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_CLKSRC_MIPS_GIC */
+
+int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
+{
+	const union mips_vdso_data *data = get_vdso_data();
+	int ret;
+
+	switch (clkid) {
+	case CLOCK_REALTIME_COARSE:
+		ret = do_realtime_coarse(ts, data);
+		break;
+	case CLOCK_MONOTONIC_COARSE:
+		ret = do_monotonic_coarse(ts, data);
+		break;
+	case CLOCK_REALTIME:
+		ret = do_realtime(ts, data);
+		break;
+	case CLOCK_MONOTONIC:
+		ret = do_monotonic(ts, data);
+		break;
+	default:
+		ret = -ENOSYS;
+		break;
+	}
+
+	/* If we return -ENOSYS libc should fall back to a syscall. */
+	return ret;
+}
diff --git a/arch/mips/vdso/vdso.h b/arch/mips/vdso/vdso.h
index 0bb6b1adc385..cfb1be441dec 100644
--- a/arch/mips/vdso/vdso.h
+++ b/arch/mips/vdso/vdso.h
@@ -77,4 +77,13 @@ static inline const union mips_vdso_data *get_vdso_data(void)
 	return (const union mips_vdso_data *)(get_vdso_base() - PAGE_SIZE);
 }
 
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+
+static inline void __iomem *get_gic(const union mips_vdso_data *data)
+{
+	return (void __iomem *)data - PAGE_SIZE;
+}
+
+#endif /* CONFIG_CLKSRC_MIPS_GIC */
+
 #endif /* __ASSEMBLY__ */
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 21655b6fefc5..8df7dd53e8e0 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -95,6 +95,11 @@ PHDRS
 VERSION
 {
 	LINUX_2.6 {
+#ifndef DISABLE_MIPS_VDSO
+	global:
+		__vdso_clock_gettime;
+		__vdso_gettimeofday;
+#endif
 	local: *;
 	};
 }
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 02a1945e5093..89d3e4d7900c 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -140,9 +140,10 @@ static cycle_t gic_hpt_read(struct clocksource *cs)
 }
 
 static struct clocksource gic_clocksource = {
-	.name	= "GIC",
-	.read	= gic_hpt_read,
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.name		= "GIC",
+	.read		= gic_hpt_read,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.archdata	= { .vdso_clock_mode = VDSO_CLOCK_GIC },
 };
 
 static void __init __gic_clocksource_init(void)
-- 
2.6.2
