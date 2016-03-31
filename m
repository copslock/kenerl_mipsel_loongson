Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 11:09:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47536 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025679AbcCaJGZIr2kq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 11:06:25 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 85A551E1E86C4;
        Thu, 31 Mar 2016 10:06:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:18 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:17 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kernel-hardening@lists.openwall.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/11] MIPS: Kernel: Implement KASLR using CONFIG_RELOCATABLE
Date:   Thu, 31 Mar 2016 10:05:41 +0100
Message-ID: <1459415142-3412-11-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 52818
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

This patch adds KASLR to the MIPS kernel.

Entropy is derived from the banner, which will change every build and
random_get_entropy() which should provide additional runtime entropy.
Additionally the bootloader may pass entropy via the /chosen/kaslr-seed
node in device tree.

The kernel is relocated by up to RANDOMIZE_BASE_MAX_OFFSET bytes from
its link address (PHYSICAL_START). Because relocation happens so early
in the kernel boot, the amount of physical memory has not yet been
determined. This means the only way to limit relocation within the
available memory is via Kconfig.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v2:
- Accept the "nokaslr" command line option
- Add a kernel panic notifier to print the relocation information
- Accept entropy via the /chosen/kaslr-seed property in device tree
- Tested on MIPS Malta, Boston and SEAD3 platforms

 arch/mips/Kconfig           |  30 +++++++++
 arch/mips/kernel/relocate.c | 146 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4bf1814e57a5..d00f0f596680 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2512,6 +2512,36 @@ config RELOCATION_TABLE_SIZE
 
 	  If unsure, leave at the default value.
 
+config RANDOMIZE_BASE
+	bool "Randomize the address of the kernel image"
+	depends on RELOCATABLE
+	---help---
+	   Randomizes the physical and virtual address at which the
+	   kernel image is loaded, as a security feature that
+	   deters exploit attempts relying on knowledge of the location
+	   of kernel internals.
+
+	   Entropy is generated using any coprocessor 0 registers available.
+
+	   The kernel will be offset by up to RANDOMIZE_BASE_MAX_OFFSET.
+
+	   If unsure, say N.
+
+config RANDOMIZE_BASE_MAX_OFFSET
+	hex "Maximum kASLR offset" if EXPERT
+	depends on RANDOMIZE_BASE
+	range 0x0 0x40000000 if EVA || 64BIT
+	range 0x0 0x08000000
+	default "0x01000000"
+	---help---
+	  When kASLR is active, this provides the maximum offset that will
+	  be applied to the kernel image. It should be set according to the
+	  amount of physical RAM available in the target system minus
+	  PHYSICAL_START and must be a power of 2.
+
+	  This is limited by the size of KSEG0, 256Mb on 32-bit or 1Gb with
+	  EVA or 64-bit. The default is 16Mb.
+
 config NODES_SHIFT
 	int
 	default "6"
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 742cc7a50dad..ca1cc30c0891 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -8,15 +8,20 @@
  * Copyright (C) 2015, Imagination Technologies Ltd.
  * Authors: Matt Redfearn (matt.redfearn@imgtec.com)
  */
+#include <asm/bootinfo.h>
 #include <asm/cacheflush.h>
+#include <asm/fw/fw.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/timex.h>
 #include <linux/elf.h>
 #include <linux/kernel.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
 #include <linux/sched.h>
 #include <linux/start_kernel.h>
 #include <linux/string.h>
+#include <linux/printk.h>
 
 #define RELOCATED(x) ((void *)((long)x + offset))
 
@@ -165,6 +170,94 @@ static int __init relocate_exception_table(long offset)
 	return 0;
 }
 
+#ifdef CONFIG_RANDOMIZE_BASE
+
+static inline __init unsigned long rotate_xor(unsigned long hash,
+					      const void *area, size_t size)
+{
+	size_t i;
+	unsigned long *ptr = (unsigned long *)area;
+
+	for (i = 0; i < size / sizeof(hash); i++) {
+		/* Rotate by odd number of bits and XOR. */
+		hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
+		hash ^= ptr[i];
+	}
+
+	return hash;
+}
+
+static inline __init unsigned long get_random_boot(void)
+{
+	unsigned long entropy = random_get_entropy();
+	unsigned long hash = 0;
+
+	/* Attempt to create a simple but unpredictable starting entropy. */
+	hash = rotate_xor(hash, linux_banner, strlen(linux_banner));
+
+	/* Add in any runtime entropy we can get */
+	hash = rotate_xor(hash, &entropy, sizeof(entropy));
+
+#if defined(CONFIG_USE_OF)
+	/* Get any additional entropy passed in device tree */
+	{
+		int node, len;
+		u64 *prop;
+
+		node = fdt_path_offset(initial_boot_params, "/chosen");
+		if (node >= 0) {
+			prop = fdt_getprop_w(initial_boot_params, node,
+					     "kaslr-seed", &len);
+			if (prop && (len == sizeof(u64)))
+				hash = rotate_xor(hash, prop, sizeof(*prop));
+		}
+	}
+#endif /* CONFIG_USE_OF */
+
+	return hash;
+}
+
+static inline __init bool kaslr_disabled(void)
+{
+	char *str;
+
+#if defined(CONFIG_CMDLINE_BOOL)
+	const char *builtin_cmdline = CONFIG_CMDLINE;
+
+	str = strstr(builtin_cmdline, "nokaslr");
+	if (str == builtin_cmdline ||
+	    (str > builtin_cmdline && *(str - 1) == ' '))
+		return true;
+#endif
+	str = strstr(arcs_cmdline, "nokaslr");
+	if (str == arcs_cmdline || (str > arcs_cmdline && *(str - 1) == ' '))
+		return true;
+
+	return false;
+}
+
+static inline void __init *determine_relocation_address(void)
+{
+	/* Choose a new address for the kernel */
+	unsigned long kernel_length;
+	void *dest = &_text;
+	unsigned long offset;
+
+	if (kaslr_disabled())
+		return dest;
+
+	kernel_length = (long)_end - (long)(&_text);
+
+	offset = get_random_boot() << 16;
+	offset &= (CONFIG_RANDOMIZE_BASE_MAX_OFFSET - 1);
+	if (offset < kernel_length)
+		offset += ALIGN(kernel_length, 0xffff);
+
+	return RELOCATED(dest);
+}
+
+#else
+
 static inline void __init *determine_relocation_address(void)
 {
 	/*
@@ -174,6 +267,8 @@ static inline void __init *determine_relocation_address(void)
 	return (void *)0xffffffff81000000;
 }
 
+#endif
+
 static inline int __init relocation_addr_valid(void *loc_new)
 {
 	if ((unsigned long)loc_new & 0x0000ffff) {
@@ -197,6 +292,17 @@ void *__init relocate_kernel(void)
 	/* Default to original kernel entry point */
 	void *kernel_entry = start_kernel;
 
+	/* Get the command line */
+	fw_init_cmdline();
+#if defined(CONFIG_USE_OF)
+	/* Deal with the device tree */
+	early_init_dt_scan(plat_get_fdt());
+	if (boot_command_line[0]) {
+		/* Boot command line was passed in device tree */
+		strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	}
+#endif /* CONFIG_USE_OF */
+
 	kernel_length = (long)(&_relocation_start) - (long)(&_text);
 	bss_length = (long)&__bss_stop - (long)&__bss_start;
 
@@ -206,6 +312,9 @@ void *__init relocate_kernel(void)
 	if (relocation_addr_valid(loc_new))
 		offset = (unsigned long)loc_new - (unsigned long)(&_text);
 
+	/* Reset the command line now so we don't end up with a duplicate */
+	arcs_cmdline[0] = '\0';
+
 	if (offset) {
 		/* Copy the kernel to it's new location */
 		memcpy(loc_new, &_text, kernel_length);
@@ -238,3 +347,40 @@ void *__init relocate_kernel(void)
 out:
 	return kernel_entry;
 }
+
+/*
+ * Show relocation information on panic.
+ */
+void show_kernel_relocation(const char *level)
+{
+	unsigned long offset;
+
+	offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
+
+	if (IS_ENABLED(CONFIG_RELOCATABLE) && offset > 0) {
+		printk(level);
+		pr_cont("Kernel relocated by 0x%pK\n", (void *)offset);
+		pr_cont(" .text @ 0x%pK\n", _text);
+		pr_cont(" .data @ 0x%pK\n", _sdata);
+		pr_cont(" .bss  @ 0x%pK\n", __bss_start);
+	}
+}
+
+static int kernel_location_notifier_fn(struct notifier_block *self,
+				       unsigned long v, void *p)
+{
+	show_kernel_relocation(KERN_EMERG);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kernel_location_notifier = {
+	.notifier_call = kernel_location_notifier_fn
+};
+
+static int __init register_kernel_offset_dumper(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &kernel_location_notifier);
+	return 0;
+}
+__initcall(register_kernel_offset_dumper);
-- 
2.5.0
