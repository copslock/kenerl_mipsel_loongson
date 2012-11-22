Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:36:22 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:54526 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828071Ab2KVCeq02dLC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:34:46 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:34:37 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 8FF4D63027A; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 05/18] KVM/MIPS32: KVM Guest kernel support.
Date:   Wed, 21 Nov 2012 18:34:03 -0800
Message-Id: <1353551656-23579-6-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Both Guest kernel and Guest Userspace execute in UM. The memory map is as follows:
Guest User address space:   0x00000000 -> 0x40000000
Guest Kernel Unmapped:      0x40000000 -> 0x60000000
Guest Kernel Mapped:        0x60000000 -> 0x80000000
- Guest Usermode virtual memory is limited to 1GB.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/mach-generic/spaces.h |  9 ++++++++-
 arch/mips/include/asm/processor.h           |  5 +++++
 arch/mips/include/asm/uaccess.h             | 11 ++++++++++-
 arch/mips/kernel/binfmt_elfo32.c            |  4 ++++
 arch/mips/kernel/cevt-r4k.c                 |  4 ++++
 arch/mips/kernel/traps.c                    |  7 ++++++-
 arch/mips/mti-malta/malta-time.c            | 13 +++++++++++++
 7 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index d7a9efd..ff64289 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -20,14 +20,21 @@
 #endif
 
 #ifdef CONFIG_32BIT
-
+#ifdef CONFIG_KVM_GUEST
+#define CAC_BASE		_AC(0x40000000, UL)
+#else
 #define CAC_BASE		_AC(0x80000000, UL)
+#endif
 #define IO_BASE			_AC(0xa0000000, UL)
 #define UNCAC_BASE		_AC(0xa0000000, UL)
 
 #ifndef MAP_BASE
+#ifdef CONFIG_KVM_GUEST
+#define MAP_BASE		_AC(0x60000000, UL)
+#else
 #define MAP_BASE		_AC(0xc0000000, UL)
 #endif
+#endif
 
 /*
  * Memory above this physical address will be considered highmem.
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 5e33fab..7df9f06 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -44,11 +44,16 @@ extern unsigned int vced_count, vcei_count;
 #define SPECIAL_PAGES_SIZE PAGE_SIZE
 
 #ifdef CONFIG_32BIT
+#ifdef CONFIG_KVM_GUEST
+/* User space process size is limited to 1GB in KVM Guest Mode */
+#define TASK_SIZE	0x3fff8000UL
+#else
 /*
  * User space process size: 2GB. This is hardcoded into a few places,
  * so don't change it unless you know what you are doing.
  */
 #define TASK_SIZE	0x7fff8000UL
+#endif
 
 #ifdef __KERNEL__
 #define STACK_TOP_MAX	TASK_SIZE
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 3b92efe..61ec84d 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -23,7 +23,11 @@
  */
 #ifdef CONFIG_32BIT
 
-#define __UA_LIMIT	0x80000000UL
+#ifdef CONFIG_KVM_GUEST
+#define __UA_LIMIT 0x40000000UL
+#else
+#define __UA_LIMIT 0x80000000UL
+#endif
 
 #define __UA_ADDR	".word"
 #define __UA_LA		"la"
@@ -55,8 +59,13 @@ extern u64 __ua_limit;
  * address in this range it's the process's problem, not ours :-)
  */
 
+#ifdef CONFIG_KVM_GUEST
+#define KERNEL_DS	((mm_segment_t) { 0x80000000UL })
+#define USER_DS		((mm_segment_t) { 0xC0000000UL })
+#else
 #define KERNEL_DS	((mm_segment_t) { 0UL })
 #define USER_DS		((mm_segment_t) { __UA_LIMIT })
+#endif
 
 #define VERIFY_READ    0
 #define VERIFY_WRITE   1
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index ff44823..8793ead 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -48,7 +48,11 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 	__res;								\
 })
 
+#ifdef CONFIG_KVM_GUEST
+#define TASK32_SIZE		0x3fff8000UL
+#else
 #define TASK32_SIZE		0x7fff8000UL
+#endif
 #undef ELF_ET_DYN_BASE
 #define ELF_ET_DYN_BASE         (TASK32_SIZE / 3 * 2)
 
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 7532392..eebb05b 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -118,6 +118,10 @@ int c0_compare_int_usable(void)
 	unsigned int delta;
 	unsigned int cnt;
 
+#ifdef CONFIG_KVM_GUEST
+    return 1;
+#endif
+
 	/*
 	 * IP7 already pending?  Try to clear it by acking the timer.
 	 */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9260986..1413aef 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1709,7 +1709,12 @@ void __init trap_init(void)
 		ebase = (unsigned long)
 			__alloc_bootmem(size, 1 << fls(size), 0);
 	} else {
-		ebase = CKSEG0;
+#ifdef CONFIG_KVM_GUEST
+#define KVM_GUEST_KSEG0     0x40000000
+        ebase = KVM_GUEST_KSEG0;
+#else
+        ebase = CKSEG0;
+#endif
 		if (cpu_has_mips_r2)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 115f5bc..1e6bd99 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -72,6 +72,19 @@ static unsigned int __init estimate_cpu_frequency(void)
 	unsigned long flags;
 	unsigned int start;
 
+#if defined (CONFIG_KVM_GUEST) && defined (CONFIG_KVM_HOST_FREQ)
+	/*
+	 * XXXKYMA: hardwire the CPU frequency to Host Freq/4 
+	 */
+	count = (CONFIG_KVM_HOST_FREQ * 1000000) >> 3;
+	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
+	    (prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
+		count *= 2;
+
+	mips_hpt_frequency = count;
+	return count;
+#endif
+
 	local_irq_save(flags);
 
 	/* Start counter exactly on falling edge of update flag */
-- 
1.7.11.3
