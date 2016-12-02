Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 09:59:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27927 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993039AbcLBI6nti890 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 09:58:43 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7B4425AC29342;
        Fri,  2 Dec 2016 08:58:34 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 08:58:36 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 3/4] MIPS: kexec: make current SMP handling conditional
Date:   Fri, 2 Dec 2016 09:58:30 +0100
Message-ID: <1480669111-15562-4-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1480669111-15562-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1480669111-15562-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55920
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

Current SMP implementation for kexec has been added during kexec
development for Cavium Octeon platforms and doesn't apply to all other
SOCs.

Guard current implementation with a new config symbol
SYS_KEXEC_SMP_BOOT_SECONDARY that is enabled for Cavium Octeon.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/Kconfig                  | 5 +++++
 arch/mips/include/asm/kexec.h      | 2 ++
 arch/mips/kernel/crash.c           | 3 ++-
 arch/mips/kernel/machine_kexec.c   | 4 +++-
 arch/mips/kernel/relocate_kernel.S | 6 +++---
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9d07bee..77e6b5a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -868,6 +868,7 @@ config CAVIUM_OCTEON_SOC
 	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_CAVIUM_OCTEON
+	select SYS_KEXEC_SMP_BOOT_SECONDARY
 	select HW_HAS_PCI
 	select ZONE_DMA32
 	select HOLES_IN_ZONE
@@ -2780,6 +2781,7 @@ source "kernel/Kconfig.preempt"
 config KEXEC
 	bool "Kexec system call"
 	select KEXEC_CORE
+	depends on SYS_KEXEC_SMP_BOOT_SECONDARY || !SMP
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
@@ -2794,6 +2796,9 @@ config KEXEC
 	  interface is strongly in flux, so no good recommendation can be
 	  made.
 
+config SYS_KEXEC_SMP_BOOT_SECONDARY
+	bool
+
 config CRASH_DUMP
 	bool "Kernel crash dumps"
 	help
diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 493a3cc..8934725 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -41,10 +41,12 @@ extern void (*_machine_kexec_shutdown)(void);
 extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 #ifdef CONFIG_SMP
+#ifdef CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY
 extern const unsigned char kexec_smp_wait[];
 extern unsigned long secondary_kexec_args[4];
 extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
+#endif
 extern void (*_crash_smp_send_stop)(void);
 #endif
 #endif
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 5a71518..feeb3b0 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -38,11 +38,12 @@ static void crash_shutdown_secondary(void *passed_regs)
 	if (!cpumask_test_cpu(cpu, &cpus_in_crash))
 		crash_save_cpu(regs, cpu);
 	cpumask_set_cpu(cpu, &cpus_in_crash);
-
+#ifdef CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY
 	while (!atomic_read(&kexec_ready_to_reboot))
 		cpu_relax();
 	relocated_kexec_smp_wait(NULL);
 	/* NOTREACHED */
+#endif
 }
 
 static void crash_kexec_prepare_cpus(void)
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 8b574bc..5f9a337 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -23,8 +23,10 @@ int (*_machine_kexec_prepare)(struct kimage *) = NULL;
 void (*_machine_kexec_shutdown)(void) = NULL;
 void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
 #ifdef CONFIG_SMP
+#ifdef CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY
 void (*relocated_kexec_smp_wait) (void *);
 atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
+#endif
 void (*_crash_smp_send_stop)(void) = NULL;
 #endif
 
@@ -126,7 +128,7 @@ machine_kexec(struct kimage *image)
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
 	__flush_cache_all();
-#ifdef CONFIG_SMP
+#ifdef CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY
 	/* All secondary cpus now may jump to kexec_wait cycle */
 	relocated_kexec_smp_wait = reboot_code_buffer +
 		(void *)(kexec_smp_wait - relocate_new_kernel);
diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index c6bbf21..dbdb963 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -69,7 +69,7 @@ copy_word:
 	b		process_entry
 
 done:
-#ifdef CONFIG_SMP
+#ifdef CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY
 	/* kexec_flag reset is signal to other CPUs what kernel
 	   was moved to it's location. Note - we need relocated address
 	   of kexec_flag.  */
@@ -100,7 +100,7 @@ done:
 	j		s1
 	END(relocate_new_kernel)
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY
 /*
  * Other CPUs should wait until code is relocated and
  * then start at entry (?) point.
@@ -156,7 +156,7 @@ arg2:	PTR		0x0
 arg3:	PTR		0x0
 	.size	kexec_args,PTRSIZE*4
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY
 /*
  * Secondary CPUs may have different kernel parameters in
  * their registers a0-a3. secondary_kexec_args[0..3] are used
-- 
2.7.4
