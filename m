Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 10:00:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38469 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993040AbcLBI6oNEes0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 09:58:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4978AF5EC75DC;
        Fri,  2 Dec 2016 08:58:35 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 08:58:37 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 4/4] MIPS: kexec: add SMP hooks for generic platform
Date:   Fri, 2 Dec 2016 09:58:31 +0100
Message-ID: <1480669111-15562-5-git-send-email-marcin.nowakowski@imgtec.com>
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
X-archive-position: 55921
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

Use disable_nonboot_cpus to shutdown all cores when preparing to switch
to a new kexec'ed kernel.

This new method of switching is preferred to the earlier used (and now
guarded by CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY) for all systems that
boot with all cores/threads stopped that are expected to be started by
linux kernel, but the kexec switch to the new kernel is very
platform-specific, so neither of the solutions may be applicable to all
existing platforms.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/Kconfig         | 2 +-
 arch/mips/generic/kexec.c | 7 +++++++
 arch/mips/kernel/crash.c  | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 77e6b5a..11bd8d7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2781,7 +2781,7 @@ source "kernel/Kconfig.preempt"
 config KEXEC
 	bool "Kexec system call"
 	select KEXEC_CORE
-	depends on SYS_KEXEC_SMP_BOOT_SECONDARY || !SMP
+	depends on SYS_KEXEC_SMP_BOOT_SECONDARY || !SMP || PM_SLEEP_SMP
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/mips/generic/kexec.c b/arch/mips/generic/kexec.c
index 61f812b..cdfd966 100644
--- a/arch/mips/generic/kexec.c
+++ b/arch/mips/generic/kexec.c
@@ -8,6 +8,7 @@
  * option) any later version.
  */
 
+#include <linux/cpu.h>
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
 #include <linux/uaccess.h>
@@ -36,9 +37,15 @@ static int generic_kexec_prepare(struct kimage *image)
 	return 0;
 }
 
+static void generic_kexec_machine_shutdown(void)
+{
+	disable_nonboot_cpus();
+}
+
 static int __init register_generic_kexec(void)
 {
 	_machine_kexec_prepare = generic_kexec_prepare;
+	_machine_kexec_shutdown = generic_kexec_machine_shutdown;
 	return 0;
 }
 arch_initcall(register_generic_kexec);
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index feeb3b0..e9d36d7 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -3,6 +3,7 @@
 #include <linux/reboot.h>
 #include <linux/kexec.h>
 #include <linux/bootmem.h>
+#include <linux/cpu.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
@@ -60,6 +61,10 @@ static void crash_kexec_prepare_cpus(void)
 	smp_call_function(crash_shutdown_secondary, NULL, 0);
 	smp_wmb();
 
+#ifndef CONFIG_SYS_KEXEC_SMP_BOOT_SECONDARY
+	disable_nonboot_cpus();
+#endif
+
 	/*
 	 * The crash CPU sends an IPI and wait for other CPUs to
 	 * respond. Delay of at least 10 seconds.
-- 
2.7.4
