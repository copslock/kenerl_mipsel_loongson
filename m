Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 11:08:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14717 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025611AbcCaJGUwfP-q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 11:06:20 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 5B915DAD2B22C;
        Thu, 31 Mar 2016 10:06:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:13 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:13 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kernel-hardening@lists.openwall.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        James Hogan <james.hogan@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>
Subject: [PATCH v2 05/11] MIPS: Kernel: Add relocate.c
Date:   Thu, 31 Mar 2016 10:05:36 +0100
Message-ID: <1459415142-3412-6-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52813
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

Changes in v2: None

 arch/mips/kernel/Makefile   |   2 +
 arch/mips/kernel/relocate.c | 240 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+)
 create mode 100644 arch/mips/kernel/relocate.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 68e2b7db9348..debffb89d51a 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -84,6 +84,8 @@ obj-$(CONFIG_I8253)		+= i8253.o
 
 obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 
+obj-$(CONFIG_RELOCATABLE)	+= relocate.o
+
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
new file mode 100644
index 000000000000..742cc7a50dad
--- /dev/null
+++ b/arch/mips/kernel/relocate.c
@@ -0,0 +1,240 @@
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
+#define RELOCATED(x) ((void *)((long)x + offset))
+
+extern u32 _relocation_start[];	/* End kernel image / start relocation table */
+extern u32 _relocation_end[];	/* End relocation table */
+
+extern long __start___ex_table;	/* Start exception table */
+extern long __stop___ex_table;	/* End exception table */
+
+static inline u32 __init get_synci_step(void)
+{
+	u32 res;
+
+	__asm__("rdhwr  %0, $1" : "=r" (res));
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
+	target_addr += offset;
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
+	for (r = _relocation_start; r < _relocation_end; r++) {
+		/* Sentinel for last relocation */
+		if (*r == 0)
+			break;
+
+		type = (*r >> 24) & 0xff;
+		loc_orig = (void *)(kbase_old + ((*r & 0x00ffffff) << 2));
+		loc_new = RELOCATED(loc_orig);
+
+		if (reloc_handlers_rel[type] == NULL) {
+			/* Unsupported relocation */
+			pr_err("Unhandled relocation type %d at 0x%pK\n",
+			       type, loc_orig);
+			return -ENOEXEC;
+		}
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
+ * The exception table is filled in by the relocs tool after vmlinux is linked.
+ * It must be relocated separately since there will not be any relocation
+ * information for it filled in by the linker.
+ */
+static int __init relocate_exception_table(long offset)
+{
+	unsigned long *etable_start, *etable_end, *e;
+
+	etable_start = RELOCATED(&__start___ex_table);
+	etable_end = RELOCATED(&__stop___ex_table);
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
+	if ((unsigned long)loc_new & 0x0000ffff) {
+		/* Inappropriately aligned new location */
+		return 0;
+	}
+	if ((unsigned long)loc_new < (unsigned long)&_end) {
+		/* New location overlaps original kernel */
+		return 0;
+	}
+	return 1;
+}
+
+void *__init relocate_kernel(void)
+{
+	void *loc_new;
+	unsigned long kernel_length;
+	unsigned long bss_length;
+	long offset = 0;
+	int res = 1;
+	/* Default to original kernel entry point */
+	void *kernel_entry = start_kernel;
+
+	kernel_length = (long)(&_relocation_start) - (long)(&_text);
+	bss_length = (long)&__bss_stop - (long)&__bss_start;
+
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
+		if (res < 0)
+			goto out;
+
+		/* Sync the caches ready for execution of new kernel */
+		sync_icache(loc_new, kernel_length);
+
+		res = relocate_exception_table(offset);
+		if (res < 0)
+			goto out;
+
+		/*
+		 * The original .bss has already been cleared, and
+		 * some variables such as command line parameters
+		 * stored to it so make a copy in the new location.
+		 */
+		memcpy(RELOCATED(&__bss_start), &__bss_start, bss_length);
+
+		/* The current thread is now within the relocated image */
+		__current_thread_info = RELOCATED(&init_thread_union);
+
+		/* Return the new kernel's entry point */
+		kernel_entry = RELOCATED(start_kernel);
+	}
+out:
+	return kernel_entry;
+}
-- 
2.5.0
