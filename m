Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 11:10:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55900 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012925AbbLCKIcxCS3Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 11:08:32 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id A8F5A67DD02A8
        for <linux-mips@linux-mips.org>; Thu,  3 Dec 2015 10:08:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 3 Dec 2015 10:08:26 +0000
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 3 Dec 2015 10:08:25 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 5/9] MIPS: Kernel: Add relocate.c
Date:   Thu, 3 Dec 2015 10:08:13 +0000
Message-ID: <1449137297-30464-6-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

arch/mips/kernel/relocate.c contains the functions necessary to relocate
the kernel elsewhere in memory

The kernel makes a copy of itself at the new address. It uses the
relocation table inserted by the relocs tool to fix symbol references
within the new image.

If copy/relocation is sucessful then the entry point of the new kernel
is returned, otherwise fall back to starting the kernel in place.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 arch/mips/kernel/Makefile   |   2 +
 arch/mips/kernel/relocate.c | 232 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 arch/mips/kernel/relocate.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index d982be1ea1c3..694d54b1e7bf 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -83,6 +83,8 @@ obj-$(CONFIG_I8253)		+= i8253.o
 
 obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 
+obj-$(CONFIG_RELOCATABLE)	+= relocate.o
+
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
new file mode 100644
index 000000000000..3cb97ab25a5f
--- /dev/null
+++ b/arch/mips/kernel/relocate.c
@@ -0,0 +1,232 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Support for Kernel relocation at boot time
+ *
+ * Copyright (C) 2015, Imagination Technologies Ltd.
+ * Authors: Matt Redfearn (matt.redfearn@imgtec.com)
+ */
+#include <asm/cacheflush.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/timex.h>
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/start_kernel.h>
+#include <linux/string.h>
+
+extern long _relocation_start;	/* End kernel image / start relocation table */
+extern long _relocation_end;	/* End relocation table */
+
+extern long __start___ex_table;	/* Start exception table */
+extern long __stop___ex_table;	/* End exception table */
+
+static inline u32 __init get_synci_step(void)
+{
+	u32 res;
+
+	__asm__ __volatile__("rdhwr  %0, $1" : "=r" (res));
+
+	return res;
+}
+
+static void __init sync_icache(void *kbase, unsigned long kernel_length)
+{
+	void *kend = kbase + kernel_length;
+	u32 step = get_synci_step();
+
+	do {
+		__asm__ __volatile__(
+			"synci  0(%0)"
+			: /* no output */
+			: "r" (kbase));
+
+		kbase += step;
+	} while (kbase < kend);
+
+	/* Completion barrier */
+	__sync();
+}
+
+static int __init apply_r_mips_64_rel(u32 *loc_orig, u32 *loc_new, long offset)
+{
+	*(u64 *)loc_new += offset;
+
+	return 0;
+}
+
+static int __init apply_r_mips_32_rel(u32 *loc_orig, u32 *loc_new, long offset)
+{
+	*loc_new += offset;
+
+	return 0;
+}
+
+static int __init apply_r_mips_26_rel(u32 *loc_orig, u32 *loc_new, long offset)
+{
+	unsigned long target_addr = (*loc_orig) & 0x03ffffff;
+
+	if (offset % 4) {
+		pr_err("Dangerous R_MIPS_26 REL relocation\n");
+		return -ENOEXEC;
+	}
+
+	/* Original target address */
+	target_addr <<= 2;
+	target_addr += (unsigned long)loc_orig & ~0x03ffffff;
+
+	/* Get the new target address */
+	target_addr = (long)target_addr + offset;
+
+	if ((target_addr & 0xf0000000) != ((unsigned long)loc_new & 0xf0000000)) {
+		pr_err("R_MIPS_26 REL relocation overflow\n");
+		return -ENOEXEC;
+	}
+
+	target_addr -= (unsigned long)loc_new & ~0x03ffffff;
+	target_addr >>= 2;
+
+	*loc_new = (*loc_new & ~0x03ffffff) | (target_addr & 0x03ffffff);
+
+	return 0;
+}
+
+
+static int __init apply_r_mips_hi16_rel(u32 *loc_orig, u32 *loc_new, long offset)
+{
+	unsigned long insn = *loc_orig;
+	unsigned long target = (insn & 0xffff) << 16; /* high 16bits of target */
+
+	target += offset;
+
+	*loc_new = (insn & ~0xffff) | ((target >> 16) & 0xffff);
+	return 0;
+}
+
+static int (*reloc_handlers_rel[]) (u32 *, u32 *, long) __initdata = {
+	[R_MIPS_64]		= apply_r_mips_64_rel,
+	[R_MIPS_32]		= apply_r_mips_32_rel,
+	[R_MIPS_26]		= apply_r_mips_26_rel,
+	[R_MIPS_HI16]		= apply_r_mips_hi16_rel,
+};
+
+int __init do_relocations(void *kbase_old, void *kbase_new, long offset)
+{
+	u32 *r;
+	u32 *loc_orig;
+	u32 *loc_new;
+	int type;
+	int res;
+
+	for (r = (u32 *)&_relocation_start; r < (u32 *)&_relocation_end; r++) {
+		/* Sentinel for last relocation */
+		if (*r == 0)
+			break;
+
+		type = (*r >> 24) & 0xff;
+		loc_orig = (void *)(kbase_old + ((*r & 0x00ffffff) << 2));
+		loc_new = (void *)((unsigned long)loc_orig + offset);
+
+		if (reloc_handlers_rel[type] == NULL)
+			/* Unsupported relocation */
+			return -ENOEXEC;
+
+		res = reloc_handlers_rel[type](loc_orig, loc_new, offset);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+/*
+ * The exception table is filled in by a tool after vmlinux is linked.
+ * It must be relocated separately since there will not be any relocation
+ * information for it filled in by the linker.
+ */
+static int __init relocate_exception_table(long offset)
+{
+	unsigned long *etable_start, *etable_end, *e;
+
+	etable_start = (void *)((unsigned long)&__start___ex_table + offset);
+	etable_end = (void *)((unsigned long)&__stop___ex_table + offset);
+
+	for (e = etable_start; e < etable_end; e++)
+		*e += offset;
+
+	return 0;
+}
+
+static inline void __init *determine_relocation_address(void)
+{
+	/*
+	 * Choose a new address for the kernel
+	 * For now we'll hard code the destination
+	 */
+	return (void *)0xffffffff81000000;
+}
+
+static inline int __init relocation_addr_valid(void *loc_new)
+{
+	if ((unsigned long)loc_new & 0x0000ffff)
+		return 0; /* Inappropriately aligned new location */
+	if ((unsigned long)loc_new < (unsigned long)&_end)
+		return 0; /* New location overlaps original kernel */
+	return 1;
+}
+
+void __init *relocate_kernel(void)
+{
+	void *loc_new;
+	unsigned long kernel_length;
+	long offset = 0;
+	int res = 1;
+
+	kernel_length = (long)(&_relocation_start) - (long)(&_text);
+	loc_new = determine_relocation_address();
+
+	/* Sanity check relocation address */
+	if (relocation_addr_valid(loc_new))
+		offset = (unsigned long)loc_new - (unsigned long)(&_text);
+
+	if (offset) {
+		/* Copy the kernel to it's new location */
+		memcpy(loc_new, &_text, kernel_length);
+
+		/* Perform relocations on the new kernel */
+		res = do_relocations(&_text, loc_new, offset);
+
+		if (res == 0) {
+			/* Sync the caches ready for execution of new kernel */
+			sync_icache(loc_new, kernel_length);
+
+			res = relocate_exception_table(offset);
+		}
+	}
+
+	if (res == 0) {
+		void *bss_new = (void *)((long)&__bss_start + offset);
+		long bss_length = (long)&__bss_stop - (long)&__bss_start;
+		/*
+		 * The original .bss has already been cleared, and
+		 * some variables such as command line parameters
+		 * stored to it so make a copy in the new location.
+		 */
+		memcpy(bss_new, &__bss_start, bss_length);
+
+		/* The current thread is now within the relocated image */
+		__current_thread_info = (void *)((long)&init_thread_union + offset);
+
+		/* Return the new kernel's entry point */
+		return (void *)((long)start_kernel + offset);
+	} else {
+		/*
+		 * Something went wrong in the relocation process
+		 * Just boot the original kernel
+		 */
+		return start_kernel;
+	}
+}
-- 
2.1.4
