Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 11:11:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51578 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012437AbbLCKIfacVTZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 11:08:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 829B5FD11425C
        for <linux-mips@linux-mips.org>; Thu,  3 Dec 2015 10:08:27 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 3 Dec 2015 10:08:29 +0000
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 3 Dec 2015 10:08:28 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 9/9] MIPS: Kernel: Implement kASLR using CONFIG_RELOCATABLE
Date:   Thu, 3 Dec 2015 10:08:17 +0000
Message-ID: <1449137297-30464-10-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 50314
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

This patch adds kASLR to the MIPS kernel.

Entropy is derived from the banner, which will change every build and
random_get_entropy() which should provide additional runtime entropy.

The kernel is relocated by up to RANDOMIZE_BASE_MAX_OFFSET bytes from
its link address (PHYSICAL_START). Because relocation happens so early
in the kernel boot, the amount of physical memory has not yet been
determined, nor has the command line been parsed. This means the only
way to limit relocation within the available memory is via Kconfig.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 arch/mips/Kconfig           | 30 +++++++++++++++++++++
 arch/mips/kernel/relocate.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5b0339c91a33..0f8425e5414b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2452,6 +2452,36 @@ config RELOCATION_TABLE_SIZE
 	  This option allows the amount of space reserved for the table to be
 	  adjusted, although the default of 1Mb should be ok in most cases.
 
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
 	  If unsure, leave at the default value.
 
 config NODES_SHIFT
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 3cb97ab25a5f..965d0af28a37 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/start_kernel.h>
 #include <linux/string.h>
+#include <linux/printk.h>
 
 extern long _relocation_start;	/* End kernel image / start relocation table */
 extern long _relocation_end;	/* End relocation table */
@@ -160,6 +161,54 @@ static int __init relocate_exception_table(long offset)
 	return 0;
 }
 
+#ifdef CONFIG_RANDOMIZE_BASE
+
+static inline unsigned long rotate_xor(unsigned long hash, const void *area,
+				size_t size)
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
+static inline unsigned long get_random_boot(void)
+{
+	unsigned long entropy = random_get_entropy();
+	unsigned long hash = 0;
+
+	/* Attempt to create a simple but unpredictable starting entropy. */
+	hash = rotate_xor(hash, linux_banner, strlen(linux_banner));
+
+	/* Add in runtime entropy */
+	hash = rotate_xor(hash, &entropy, sizeof(entropy));
+
+	return hash;
+}
+
+static inline void __init *determine_relocation_address(void)
+{
+	/* Choose a new address for the kernel */
+	unsigned long dest = (unsigned long)_end;
+	unsigned long offset;
+
+	/* Round _end up to next 64k boundary */
+	dest = ALIGN(dest, 0xffff);
+
+	offset = get_random_boot() << 16;
+	offset &= (CONFIG_RANDOMIZE_BASE_MAX_OFFSET-1);
+
+	return (void *)(dest + offset);
+}
+
+#else
+
 static inline void __init *determine_relocation_address(void)
 {
 	/*
@@ -169,6 +218,8 @@ static inline void __init *determine_relocation_address(void)
 	return (void *)0xffffffff81000000;
 }
 
+#endif
+
 static inline int __init relocation_addr_valid(void *loc_new)
 {
 	if ((unsigned long)loc_new & 0x0000ffff)
@@ -210,10 +261,23 @@ void __init *relocate_kernel(void)
 	if (res == 0) {
 		void *bss_new = (void *)((long)&__bss_start + offset);
 		long bss_length = (long)&__bss_stop - (long)&__bss_start;
+#if (defined CONFIG_DEBUG_KERNEL) && (defined CONFIG_DEBUG_INFO)
+		/*
+		 * This information is necessary when debugging the kernel
+		 * But is a security vulnerability otherwise!
+		 */
+		void *data_new = (void *)((long)&_sdata + offset);
+
+		pr_info("Booting relocated kernel\n");
+		pr_info(" .text @ 0x%pK\n", loc_new);
+		pr_info(" .data @ 0x%pK\n", data_new);
+		pr_info(" .bss  @ 0x%pK\n", bss_new);
+#endif
 		/*
 		 * The original .bss has already been cleared, and
 		 * some variables such as command line parameters
-		 * stored to it so make a copy in the new location.
+		 * (and possibly the above printk's) stored to it
+		 * so make a copy in the new location.
 		 */
 		memcpy(bss_new, &__bss_start, bss_length);
 
-- 
2.1.4
