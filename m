Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 11:54:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15263 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009493AbbJEJxAoDQS5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 11:53:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7C1BBF1307463
        for <linux-mips@linux-mips.org>; Mon,  5 Oct 2015 10:52:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 5 Oct 2015 10:52:54 +0100
Received: from mredfearn-linux.le.imgtec.org (192.168.154.117) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 5 Oct 2015 10:52:53 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [RFC PATCH 5/7] MIPS: Kernel: Add relocate.c
Date:   Mon, 5 Oct 2015 10:52:29 +0100
Message-ID: <1444038751-25105-6-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
References: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.117]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49430
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

arch/mips/kernel/relocate.c contains the functions
necessary to relocate the kernel elsewhere in memory

The kernel makes a copy of itself at the new address.
It uses the relocation table appended by the relocs tool
to fix symbol references within the new image.

If copy/relocation is sucessful then the entry point
of the new kernel is returned, otherwise fall back
to starting the kernel in place.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
Currently the destination address of the kernel is
hardcoded, but this can easily be changed to
a parameter from the command line, or a randomly
chosen address to implement KASLR.

Kernel 64bit support
---
 arch/mips/kernel/Makefile   |   2 +
 arch/mips/kernel/relocate.c | 225 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 arch/mips/kernel/relocate.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index fffa1ac86740..a02170f7c6d1 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -85,6 +85,8 @@ obj-$(CONFIG_I8253)		+= i8253.o
 
 obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 
+obj-$(CONFIG_RELOCATABLE)	+= relocate.o
+
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
new file mode 100644
index 000000000000..36d42f0fd198
--- /dev/null
+++ b/arch/mips/kernel/relocate.c
@@ -0,0 +1,225 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Copyright (C) 2015 Matt Redfearn (matt.redfearn@imgtec.com)
+ */
+#include <linux/start_kernel.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/elf.h>
+#include <asm/sections.h>
+#include <linux/sched.h>
+#include <asm/setup.h>
+#include <asm/cacheflush.h>
+
+extern long _relocation_start;	/* End kernel image / start relocation table */
+extern long _relocation_end;	/* End relocation table */
+
+extern long __start___ex_table;	/* Start exception table */
+extern long __stop___ex_table;	/* End exception table */
+
+
+#if 1
+#define PRINTK(...)
+#else
+#define PRINTK(...) printk(__VA_ARGS__)
+#endif
+
+static int __init apply_r_mips_64_rel(u32 *loc_orig, u32 *loc_new, long offset)
+{
+	*(u64*)loc_new += offset;
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
+	unsigned long target = (insn & 0xFFFF) << 16; /* high 16bits of target */
+
+	target += offset;
+	if (target > 0xFFFFFFFF)
+		/* Relocation would overflow */
+		return -ENOEXEC;
+
+	*loc_new = (insn & ~0xFFFF) | ((target >> 16) & 0xFFFF);
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
+	PRINTK(KERN_INFO "%s 0x%p -> 0x%p\n", __FUNCTION__, kbase_old, kbase_new);
+
+	for (r = (u32*)&_relocation_start; r < (u32*)&_relocation_end; r++) {
+		/* Sentinel for last relocation */
+		if (*r == 0)
+			break;
+
+		type = ((*r) >> 24) & 0xFF;
+		loc_orig = (void*)(kbase_old + ((*r) & 0x00FFFFFF));
+		loc_new = (void*)((unsigned long)loc_orig + offset);
+
+		PRINTK(KERN_INFO "relocation %d @0x%p -> 0x%p\n",
+		       type, loc_orig, loc_new);
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
+	/* New kernel has been written - flush the caches ready for execution */
+	//flush_cache_all();
+	return 0;
+}
+
+static int relocate_exception_table(long offset)
+{
+#ifdef CONFIG_64BIT
+	u64* etable_start, *etable_end, *e;
+#else
+	u32* etable_start, *etable_end, *e;
+#endif
+
+	etable_start = (void*)((unsigned long)&__start___ex_table + offset);
+	etable_end = (void*)((unsigned long)&__stop___ex_table + offset);
+
+	for (e = etable_start; e < etable_end; e++) {
+		*e += offset;
+	}
+	return 0;
+}
+
+static inline void __init *determine_relocation_address(void)
+{
+	/* Choose a new address for the kernel */
+	/* For now we'll hard code the destination */
+	return (void*)0xFFFFFFFF81000000;
+}
+
+static inline int __init relocation_addr_valid(void *loc_new)
+{
+	if ((unsigned long)loc_new & 0x0000FFFF)
+		return 0; /* Inappropriately aligned new location */
+	if ((unsigned long)loc_new < (unsigned long)&_end)
+		return 0; /* New location overlaps original kernel */
+	return 1;
+}
+
+void __init *relocate_kernel(void)
+{
+	void *loc_new;
+	unsigned long kernel_length = (long)(&_relocation_start)-(long)(&_text);
+	long offset = 0;
+	int res = 1;
+
+	loc_new = determine_relocation_address();
+	PRINTK(KERN_INFO "%s to 0x%p\n", __FUNCTION__, loc_new);
+
+	/* Sanity check relocation address */
+	if (relocation_addr_valid(loc_new))
+		offset = (unsigned long)loc_new - (unsigned long)(&_text);
+
+	if (offset) {
+		PRINTK(KERN_INFO "%s Copy %ld 0x%p -> %p\n",
+			__FUNCTION__, kernel_length, (&_text), loc_new);
+
+		/* Copy the kernel to it's new location */
+		memcpy(loc_new, &_text, kernel_length);
+
+		PRINTK(KERN_INFO "%s kernel copied\n", __FUNCTION__);
+
+		/* Perform relocations on the new kernel */
+		res = do_relocations(&_text, loc_new, offset);
+
+		if (res == 0)
+			res = relocate_exception_table(offset);
+	}
+
+	if (res == 0) {
+		void *bss_new = (void*)((long)&__bss_start + offset);
+		long bss_length = (long)&__bss_stop - (long)&__bss_start;
+
+		/* The original .bss has already been cleared, and
+		 * some variables such as command line parameters
+		 * stored to it so make a copy in the new location.
+		 */
+		memcpy(bss_new, &__bss_start, bss_length);
+
+		/* The current thread is now within the relocated image */
+		__current_thread_info = (void*)((long)&init_thread_union + offset);
+
+		/* Return the new kernel's entry point */
+		return(void*)((long)start_kernel + offset);
+	}
+	else {
+		/* Something went wrong in the relocation process
+		 * Just boot the original kernel */
+		return start_kernel;
+	}
+}
-- 
2.1.4
