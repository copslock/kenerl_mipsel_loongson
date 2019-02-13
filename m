Return-Path: <SRS0=gFuS=QU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64784C43381
	for <linux-mips@archiver.kernel.org>; Wed, 13 Feb 2019 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275A3222A4
	for <linux-mips@archiver.kernel.org>; Wed, 13 Feb 2019 22:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbfBMWBH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:01:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395055AbfBMWBG (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 13 Feb 2019 17:01:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C655B37F46;
        Wed, 13 Feb 2019 22:01:04 +0000 (UTC)
Received: from llong.com (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64B77600C0;
        Wed, 13 Feb 2019 22:00:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/3] locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all archs
Date:   Wed, 13 Feb 2019 17:00:16 -0500
Message-Id: <1550095217-12047-3-git-send-email-longman@redhat.com>
In-Reply-To: <1550095217-12047-1-git-send-email-longman@redhat.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 13 Feb 2019 22:01:05 +0000 (UTC)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Currently, we have two different implementation of rwsem:
 1) CONFIG_RWSEM_GENERIC_SPINLOCK (rwsem-spinlock.c)
 2) CONFIG_RWSEM_XCHGADD_ALGORITHM (rwsem-xadd.c)

As we are going to use a single generic implementation for rwsem-xadd.c
and no architecture-specific code will be needed, there is no point
in keeping two different implementations of rwsem. In most cases, the
performance of rwsem-spinlock.c will be worse. It also doesn't get all
the performance tuning and optimizations that had been implemented in
rwsem-xadd.c over the years.

For simplication, we are going to remove rwsem-spinlock.c and make all
architectures use a single implementation of rwsem - rwsem-xadd.c.

All references to RWSEM_GENERIC_SPINLOCK and RWSEM_XCHGADD_ALGORITHM
in the code are removed.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/alpha/Kconfig              |   7 -
 arch/arc/Kconfig                |   3 -
 arch/arm/Kconfig                |   4 -
 arch/arm64/Kconfig              |   3 -
 arch/c6x/Kconfig                |   3 -
 arch/csky/Kconfig               |   3 -
 arch/h8300/Kconfig              |   3 -
 arch/hexagon/Kconfig            |   6 -
 arch/ia64/Kconfig               |   4 -
 arch/m68k/Kconfig               |   7 -
 arch/microblaze/Kconfig         |   6 -
 arch/mips/Kconfig               |   7 -
 arch/nds32/Kconfig              |   3 -
 arch/nios2/Kconfig              |   3 -
 arch/openrisc/Kconfig           |   6 -
 arch/parisc/Kconfig             |   6 -
 arch/powerpc/Kconfig            |   7 -
 arch/riscv/Kconfig              |   3 -
 arch/s390/Kconfig               |   6 -
 arch/sh/Kconfig                 |   6 -
 arch/sparc/Kconfig              |   8 -
 arch/unicore32/Kconfig          |   6 -
 arch/x86/Kconfig                |   3 -
 arch/x86/um/Kconfig             |   6 -
 arch/xtensa/Kconfig             |   3 -
 include/linux/rwsem-spinlock.h  |  47 ------
 include/linux/rwsem.h           |   5 -
 kernel/Kconfig.locks            |   2 +-
 kernel/locking/Makefile         |   4 +-
 kernel/locking/rwsem-spinlock.c | 339 ----------------------------------------
 kernel/locking/rwsem.h          |   3 -
 31 files changed, 2 insertions(+), 520 deletions(-)
 delete mode 100644 include/linux/rwsem-spinlock.h
 delete mode 100644 kernel/locking/rwsem-spinlock.c

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 584a6e1..27c8712 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -49,13 +49,6 @@ config MMU
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config ARCH_HAS_ILOG2_U32
 	bool
 	default n
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a..c0dd229 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -63,9 +63,6 @@ config SCHED_OMIT_FRAME_POINTER
 config GENERIC_CSUM
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool n
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918..4d81f69 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -176,10 +176,6 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default !CPU_V7M
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d3..24bbcfa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -238,9 +238,6 @@ config LOCKDEP_SUPPORT
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 456e154..f114655 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -26,9 +26,6 @@ config MMU
 config FPU
 	def_bool n
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c..90279a1 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -93,9 +93,6 @@ config GENERIC_HWEIGHT
 config MMU
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config STACKTRACE_SUPPORT
 	def_bool y
 
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 6472a06..ba33326 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -26,9 +26,6 @@ config H8300
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index fb2fbfc..5d07c8d 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -64,12 +64,6 @@ config GENERIC_CSUM
 config GENERIC_IRQ_PROBE
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool n
-
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 8d7396b..73a26f0 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -83,10 +83,6 @@ config STACKTRACE_SUPPORT
 config GENERIC_LOCKBREAK
 	def_bool n
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config HUGETLB_PAGE_SIZE_VARIABLE
 	bool
 	depends on HUGETLB_PAGE
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index e173ea2..6ace0b2 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -31,13 +31,6 @@ config M68K
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 58aff26..d459c70 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -57,15 +57,9 @@ config CPU_LITTLE_ENDIAN
 
 endchoice
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config ZONE_DMA
 	def_bool y
 
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a84c24d..6ad1882 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1037,13 +1037,6 @@ source "arch/mips/paravirt/Kconfig"
 
 endmenu
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index dda1906..6a3c53d 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -59,9 +59,6 @@ config GENERIC_LOCKBREAK
         def_bool y
 	depends on PREEMPT
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 532343e..715e6c0 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -39,9 +39,6 @@ config NO_IOPORT_MAP
 config FPU
 	def_bool n
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool n
 
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 09ab59e..9f51da5 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -42,12 +42,6 @@ config CPU_BIG_ENDIAN
 config MMU
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool n
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 7ca2c3e..8efbeea 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -74,12 +74,6 @@ config GENERIC_LOCKBREAK
 	default y
 	depends on SMP && PREEMPT
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config ARCH_HAS_ILOG2_U32
 	bool
 	default n
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36..466e90f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -103,13 +103,6 @@ config LOCKDEP_SUPPORT
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_LOCKBREAK
 	bool
 	default y
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 515fc3c..2b34482 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -69,9 +69,6 @@ config STACKTRACE_SUPPORT
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ed554b0..0ec9d8e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -14,12 +14,6 @@ config LOCKDEP_SUPPORT
 config STACKTRACE_SUPPORT
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index a9c36f9..4f8c747 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -89,12 +89,6 @@ config ARCH_DEFCONFIG
 	default "arch/sh/configs/shx3_defconfig" if SUPERH32
 	default "arch/sh/configs/cayman_defconfig" if SUPERH64
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG && SUPERH32
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index d5dd652..6d0036a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -190,14 +190,6 @@ config NR_CPUS
 
 source "kernel/Kconfig.hz"
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y if SPARC32
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y if SPARC64
-
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index c3a41bf..e080087 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -38,12 +38,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config RWSEM_GENERIC_SPINLOCK
-	def_bool y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-
 config ARCH_HAS_ILOG2_U32
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6826143..be6cc2c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -269,9 +269,6 @@ config ARCH_MAY_HAVE_PC_FDC
 	def_bool y
 	depends on ISA_DMA_API
 
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index f518b47..4dc3217 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -32,12 +32,6 @@ config ARCH_DEFCONFIG
 	default "arch/um/configs/i386_defconfig" if X86_32
 	default "arch/um/configs/x86_64_defconfig" if X86_64
 
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool 64BIT
-
-config RWSEM_GENERIC_SPINLOCK
-	def_bool !RWSEM_XCHGADD_ALGORITHM
-
 config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables" if !64BIT
 	default 64BIT
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index ce91682..4f0a903 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -43,9 +43,6 @@ config XTENSA
 	  with reasonable minimum requirements.  The Xtensa Linux project has
 	  a home page at <http://www.linux-xtensa.org/>.
 
-config RWSEM_XCHGADD_ALGORITHM
-	def_bool y
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/include/linux/rwsem-spinlock.h b/include/linux/rwsem-spinlock.h
deleted file mode 100644
index e475683..0000000
--- a/include/linux/rwsem-spinlock.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* rwsem-spinlock.h: fallback C implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from ideas by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-
-#ifndef _LINUX_RWSEM_SPINLOCK_H
-#define _LINUX_RWSEM_SPINLOCK_H
-
-#ifndef _LINUX_RWSEM_H
-#error "please don't include linux/rwsem-spinlock.h directly, use linux/rwsem.h instead"
-#endif
-
-#ifdef __KERNEL__
-/*
- * the rw-semaphore definition
- * - if count is 0 then there are no active readers or writers
- * - if count is +ve then that is the number of active readers
- * - if count is -1 then there is one active writer
- * - if wait_list is not empty, then there are processes waiting for the semaphore
- */
-struct rw_semaphore {
-	__s32			count;
-	raw_spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-};
-
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-
-extern void __down_read(struct rw_semaphore *sem);
-extern int __must_check __down_read_killable(struct rw_semaphore *sem);
-extern int __down_read_trylock(struct rw_semaphore *sem);
-extern void __down_write(struct rw_semaphore *sem);
-extern int __must_check __down_write_killable(struct rw_semaphore *sem);
-extern int __down_write_trylock(struct rw_semaphore *sem);
-extern void __up_read(struct rw_semaphore *sem);
-extern void __up_write(struct rw_semaphore *sem);
-extern void __downgrade_write(struct rw_semaphore *sem);
-extern int rwsem_is_locked(struct rw_semaphore *sem);
-
-#endif /* __KERNEL__ */
-#endif /* _LINUX_RWSEM_SPINLOCK_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 6e56006..0fc4106 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -22,10 +22,6 @@
 
 struct rw_semaphore;
 
-#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
-#include <linux/rwsem-spinlock.h> /* use a generic implementation */
-#define __RWSEM_INIT_COUNT(name)	.count = RWSEM_UNLOCKED_VALUE
-#else
 /* All arch specific implementations share the same struct */
 struct rw_semaphore {
 	atomic_long_t count;
@@ -65,7 +61,6 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 
 #define RWSEM_UNLOCKED_VALUE		0L
 #define __RWSEM_INIT_COUNT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
-#endif
 
 /* Common initializer macros and functions */
 
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 84d882f..74775ed 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -229,7 +229,7 @@ config MUTEX_SPIN_ON_OWNER
 
 config RWSEM_SPIN_ON_OWNER
        def_bool y
-       depends on SMP && RWSEM_XCHGADD_ALGORITHM && ARCH_SUPPORTS_ATOMIC_RMW
+       depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
 
 config LOCK_SPIN_ON_OWNER
        def_bool y
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 392c7f2..1af83e9 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -3,7 +3,7 @@
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT		:= n
 
-obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
+obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o rwsem-xadd.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
@@ -25,8 +25,6 @@ obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
 obj-$(CONFIG_DEBUG_RT_MUTEXES) += rtmutex-debug.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
-obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
-obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem-xadd.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
 obj-$(CONFIG_LOCK_TORTURE_TEST) += locktorture.o
 obj-$(CONFIG_WW_MUTEX_SELFTEST) += test-ww_mutex.o
diff --git a/kernel/locking/rwsem-spinlock.c b/kernel/locking/rwsem-spinlock.c
deleted file mode 100644
index a7ffb2a..0000000
--- a/kernel/locking/rwsem-spinlock.c
+++ /dev/null
@@ -1,339 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* rwsem-spinlock.c: R/W semaphores: contention handling functions for
- * generic spinlock implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-#include <linux/rwsem.h>
-#include <linux/sched/signal.h>
-#include <linux/sched/debug.h>
-#include <linux/export.h>
-
-enum rwsem_waiter_type {
-	RWSEM_WAITING_FOR_WRITE,
-	RWSEM_WAITING_FOR_READ
-};
-
-struct rwsem_waiter {
-	struct list_head list;
-	struct task_struct *task;
-	enum rwsem_waiter_type type;
-};
-
-int rwsem_is_locked(struct rw_semaphore *sem)
-{
-	int ret = 1;
-	unsigned long flags;
-
-	if (raw_spin_trylock_irqsave(&sem->wait_lock, flags)) {
-		ret = (sem->count != 0);
-		raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-	}
-	return ret;
-}
-EXPORT_SYMBOL(rwsem_is_locked);
-
-/*
- * initialise the semaphore
- */
-void __init_rwsem(struct rw_semaphore *sem, const char *name,
-		  struct lock_class_key *key)
-{
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	/*
-	 * Make sure we are not reinitializing a held semaphore:
-	 */
-	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
-	lockdep_init_map(&sem->dep_map, name, key, 0);
-#endif
-	sem->count = 0;
-	raw_spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
-EXPORT_SYMBOL(__init_rwsem);
-
-/*
- * handle the lock release when processes blocked on it that can now run
- * - if we come here, then:
- *   - the 'active count' _reached_ zero
- *   - the 'waiting count' is non-zero
- * - the spinlock must be held by the caller
- * - woken process blocks are discarded from the list after having task zeroed
- * - writers are only woken if wakewrite is non-zero
- */
-static inline struct rw_semaphore *
-__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
-{
-	struct rwsem_waiter *waiter;
-	struct task_struct *tsk;
-	int woken;
-
-	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
-
-	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
-		if (wakewrite)
-			/* Wake up a writer. Note that we do not grant it the
-			 * lock - it will have to acquire it when it runs. */
-			wake_up_process(waiter->task);
-		goto out;
-	}
-
-	/* grant an infinite number of read locks to the front of the queue */
-	woken = 0;
-	do {
-		struct list_head *next = waiter->list.next;
-
-		list_del(&waiter->list);
-		tsk = waiter->task;
-		/*
-		 * Make sure we do not wakeup the next reader before
-		 * setting the nil condition to grant the next reader;
-		 * otherwise we could miss the wakeup on the other
-		 * side and end up sleeping again. See the pairing
-		 * in rwsem_down_read_failed().
-		 */
-		smp_mb();
-		waiter->task = NULL;
-		wake_up_process(tsk);
-		put_task_struct(tsk);
-		woken++;
-		if (next == &sem->wait_list)
-			break;
-		waiter = list_entry(next, struct rwsem_waiter, list);
-	} while (waiter->type != RWSEM_WAITING_FOR_WRITE);
-
-	sem->count += woken;
-
- out:
-	return sem;
-}
-
-/*
- * wake a single writer
- */
-static inline struct rw_semaphore *
-__rwsem_wake_one_writer(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter *waiter;
-
-	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
-	wake_up_process(waiter->task);
-
-	return sem;
-}
-
-/*
- * get a read lock on the semaphore
- */
-int __sched __down_read_common(struct rw_semaphore *sem, int state)
-{
-	struct rwsem_waiter waiter;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-
-	if (sem->count >= 0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->count++;
-		raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-		goto out;
-	}
-
-	/* set up my own style of waitqueue */
-	waiter.task = current;
-	waiter.type = RWSEM_WAITING_FOR_READ;
-	get_task_struct(current);
-
-	list_add_tail(&waiter.list, &sem->wait_list);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.task)
-			break;
-		if (signal_pending_state(state, current))
-			goto out_nolock;
-		set_current_state(state);
-		raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-		schedule();
-		raw_spin_lock_irqsave(&sem->wait_lock, flags);
-	}
-
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
- out:
-	return 0;
-
-out_nolock:
-	/*
-	 * We didn't take the lock, so that there is a writer, which
-	 * is owner or the first waiter of the sem. If it's a waiter,
-	 * it will be woken by current owner. Not need to wake anybody.
-	 */
-	list_del(&waiter.list);
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-	return -EINTR;
-}
-
-void __sched __down_read(struct rw_semaphore *sem)
-{
-	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
-}
-
-int __sched __down_read_killable(struct rw_semaphore *sem)
-{
-	return __down_read_common(sem, TASK_KILLABLE);
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-int __down_read_trylock(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-	int ret = 0;
-
-
-	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-
-	if (sem->count >= 0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->count++;
-		ret = 1;
-	}
-
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-
-	return ret;
-}
-
-/*
- * get a write lock on the semaphore
- */
-int __sched __down_write_common(struct rw_semaphore *sem, int state)
-{
-	struct rwsem_waiter waiter;
-	unsigned long flags;
-	int ret = 0;
-
-	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-
-	/* set up my own style of waitqueue */
-	waiter.task = current;
-	waiter.type = RWSEM_WAITING_FOR_WRITE;
-	list_add_tail(&waiter.list, &sem->wait_list);
-
-	/* wait for someone to release the lock */
-	for (;;) {
-		/*
-		 * That is the key to support write lock stealing: allows the
-		 * task already on CPU to get the lock soon rather than put
-		 * itself into sleep and waiting for system woke it or someone
-		 * else in the head of the wait list up.
-		 */
-		if (sem->count == 0)
-			break;
-		if (signal_pending_state(state, current))
-			goto out_nolock;
-
-		set_current_state(state);
-		raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-		schedule();
-		raw_spin_lock_irqsave(&sem->wait_lock, flags);
-	}
-	/* got the lock */
-	sem->count = -1;
-	list_del(&waiter.list);
-
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-
-	return ret;
-
-out_nolock:
-	list_del(&waiter.list);
-	if (!list_empty(&sem->wait_list) && sem->count >= 0)
-		__rwsem_do_wake(sem, 0);
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-
-	return -EINTR;
-}
-
-void __sched __down_write(struct rw_semaphore *sem)
-{
-	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
-}
-
-int __sched __down_write_killable(struct rw_semaphore *sem)
-{
-	return __down_write_common(sem, TASK_KILLABLE);
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-int __down_write_trylock(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-
-	if (sem->count == 0) {
-		/* got the lock */
-		sem->count = -1;
-		ret = 1;
-	}
-
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-
-	return ret;
-}
-
-/*
- * release a read lock on the semaphore
- */
-void __up_read(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-
-	if (--sem->count == 0 && !list_empty(&sem->wait_list))
-		sem = __rwsem_wake_one_writer(sem);
-
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-}
-
-/*
- * release a write lock on the semaphore
- */
-void __up_write(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-
-	sem->count = 0;
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 1);
-
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-}
-
-/*
- * downgrade a write lock into a read lock
- * - just wake up any readers at the front of the queue
- */
-void __downgrade_write(struct rw_semaphore *sem)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-
-	sem->count = 1;
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 0);
-
-	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
-}
-
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 067e265..45ee002 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -153,7 +153,6 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
-#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 /*
  * lock for reading
  */
@@ -260,5 +259,3 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	if (tmp < 0)
 		rwsem_downgrade_wake(sem);
 }
-
-#endif /* CONFIG_RWSEM_XCHGADD_ALGORITHM */
-- 
1.8.3.1

