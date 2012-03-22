Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2012 10:56:29 +0100 (CET)
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:52863 "EHLO
        e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903627Ab2CVJ4T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Mar 2012 10:56:19 +0100
Received: from /spool/local
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <raghavendra.kt@linux.vnet.ibm.com>;
        Thu, 22 Mar 2012 09:51:29 +1000
Received: from d23relay03.au.ibm.com (202.81.31.245)
        by e23smtp06.au.ibm.com (202.81.31.212) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 22 Mar 2012 09:51:23 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2M9tkY2987184;
        Thu, 22 Mar 2012 20:55:46 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2M9tj7W005777;
        Thu, 22 Mar 2012 20:55:46 +1100
Received: from [9.124.158.167] ([9.124.158.167])
        by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2M9tQSH005396;
        Thu, 22 Mar 2012 20:55:43 +1100
From:   Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 22 Mar 2012 15:25:08 +0530
Message-Id: <20120322095502.30866.75756.sendpatchset@codeblue>
Subject: [PATCH 1/1] config: simplify INLINE_SPIN_UNLOCK
x-cbid: 12032123-7014-0000-0000-000000C50D9E
X-archive-position: 32736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghavendra.kt@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Patch simplifies current INLINE_SPIN_UNLOCK. compile tested on x86_64 

Change log:
get rid of INLINE_SPIN_UNLOCK entirely replacing it with UNINLINE_SPIN_UNLOCK 
instead with the reverse meaning.

whover wants to uninline the spinlocks (like spinlock debugging, paravirt etc
all just do select UNINLINE_SPIN_UNLOCK

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 Please refer : https://lkml.org/lkml/2012/3/21/357

 arch/mips/configs/db1300_defconfig  |    2 +-
 arch/tile/configs/tilegx_defconfig  |    2 +-
 arch/tile/configs/tilepro_defconfig |    2 +-
 arch/xtensa/configs/iss_defconfig   |    2 +-
 include/linux/spinlock_api_smp.h    |    2 +-
 kernel/Kconfig.locks                |    4 ++--
 kernel/Kconfig.preempt              |    1 +
 kernel/spinlock.c                   |    2 +-
 lib/Kconfig.debug                   |    1 +
 9 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/configs/db1300_defconfig b/arch/mips/configs/db1300_defconfig
index c38b190..3590ab5 100644
--- a/arch/mips/configs/db1300_defconfig
+++ b/arch/mips/configs/db1300_defconfig
@@ -133,7 +133,7 @@ CONFIG_BLK_DEV_BSG=y
 CONFIG_IOSCHED_NOOP=y
 CONFIG_DEFAULT_NOOP=y
 CONFIG_DEFAULT_IOSCHED="noop"
-CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_UNINLINE_SPIN_UNLOCK is not set
 CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
 CONFIG_INLINE_READ_UNLOCK=y
 CONFIG_INLINE_READ_UNLOCK_IRQ=y
diff --git a/arch/tile/configs/tilegx_defconfig b/arch/tile/configs/tilegx_defconfig
index dafdbba..db93926 100644
--- a/arch/tile/configs/tilegx_defconfig
+++ b/arch/tile/configs/tilegx_defconfig
@@ -187,7 +187,7 @@ CONFIG_PADATA=y
 # CONFIG_INLINE_SPIN_LOCK_BH is not set
 # CONFIG_INLINE_SPIN_LOCK_IRQ is not set
 # CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
-CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_UNINLINE_SPIN_UNLOCK is not set
 # CONFIG_INLINE_SPIN_UNLOCK_BH is not set
 CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
 # CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
diff --git a/arch/tile/configs/tilepro_defconfig b/arch/tile/configs/tilepro_defconfig
index 6f05f96..a039032 100644
--- a/arch/tile/configs/tilepro_defconfig
+++ b/arch/tile/configs/tilepro_defconfig
@@ -153,7 +153,7 @@ CONFIG_DEFAULT_IOSCHED="noop"
 # CONFIG_INLINE_SPIN_LOCK_BH is not set
 # CONFIG_INLINE_SPIN_LOCK_IRQ is not set
 # CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
-CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_UNINLINE_SPIN_UNLOCK is not set
 # CONFIG_INLINE_SPIN_UNLOCK_BH is not set
 CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
 # CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
diff --git a/arch/xtensa/configs/iss_defconfig b/arch/xtensa/configs/iss_defconfig
index f932b30..ddab37b 100644
--- a/arch/xtensa/configs/iss_defconfig
+++ b/arch/xtensa/configs/iss_defconfig
@@ -113,7 +113,7 @@ CONFIG_DEFAULT_IOSCHED="noop"
 # CONFIG_INLINE_SPIN_LOCK_BH is not set
 # CONFIG_INLINE_SPIN_LOCK_IRQ is not set
 # CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
-CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_UNINLINE_SPIN_UNLOCK is not set
 # CONFIG_INLINE_SPIN_UNLOCK_BH is not set
 CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
 # CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index e253ccd..51df117 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -67,7 +67,7 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #define _raw_spin_trylock_bh(lock) __raw_spin_trylock_bh(lock)
 #endif
 
-#ifdef CONFIG_INLINE_SPIN_UNLOCK
+#ifndef CONFIG_UNINLINE_SPIN_UNLOCK
 #define _raw_spin_unlock(lock) __raw_spin_unlock(lock)
 #endif
 
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 5068e2a..2251882 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -124,8 +124,8 @@ config INLINE_SPIN_LOCK_IRQSAVE
 	def_bool !DEBUG_SPINLOCK && !GENERIC_LOCKBREAK && \
 		 ARCH_INLINE_SPIN_LOCK_IRQSAVE
 
-config INLINE_SPIN_UNLOCK
-	def_bool !DEBUG_SPINLOCK && (!PREEMPT || ARCH_INLINE_SPIN_UNLOCK)
+config UNINLINE_SPIN_UNLOCK
+	bool
 
 config INLINE_SPIN_UNLOCK_BH
 	def_bool !DEBUG_SPINLOCK && ARCH_INLINE_SPIN_UNLOCK_BH
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 24e7cb0..3f9c974 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -36,6 +36,7 @@ config PREEMPT_VOLUNTARY
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	select PREEMPT_COUNT
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
diff --git a/kernel/spinlock.c b/kernel/spinlock.c
index 84c7d96..5cdd806 100644
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -163,7 +163,7 @@ void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_lock_bh);
 #endif
 
-#ifndef CONFIG_INLINE_SPIN_UNLOCK
+#ifdef CONFIG_UNINLINE_SPIN_UNLOCK
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__raw_spin_unlock(lock);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8745ac7..286b8af 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -495,6 +495,7 @@ config RT_MUTEX_TESTER
 config DEBUG_SPINLOCK
 	bool "Spinlock and rw-lock debugging: basic checks"
 	depends on DEBUG_KERNEL
+	select UNINLINE_SPIN_UNLOCK
 	help
 	  Say Y here and build SMP to catch missing spinlock initialization
 	  and certain other kinds of spinlock errors commonly made.  This is
