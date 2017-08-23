Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 22:54:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53184 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994853AbdHWUyBWxLds (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 22:54:01 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6D04137DC2E9E;
        Wed, 23 Aug 2017 21:53:50 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 23 Aug 2017 21:53:54
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/2] MIPS: Hang more efficiently on halt/powerdown/restart
Date:   Wed, 23 Aug 2017 13:53:16 -0700
Message-ID: <20170823205317.4828-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170823205317.4828-1-paul.burton@imgtec.com>
References: <20170823205317.4828-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The generic MIPS implementations of halting, powering down or restarting
the system all hang using a busy loop as a last resort. We have many
platforms which avoid this loop by implementing their own, many using
some variation upon executing a wait instruction to lower CPU power
usage if we reach this point.

In order to prepare for cleaning up these various custom implementations
of the same thing, this patch makes the generic machine_halt(),
machine_power_off() & machine_restart() functions each make use of the
wait instruction to lower CPU power usage in cases where we know that
the wait instruction is available. If wait isn't known to be supported
then we fall back to calling cpu_wait(), and if we don't have a
cpu_wait() callback then we effectively continue using a busy loop.

In effect the new machine_hang() function provides a superset of the
functionality that the various platforms currently provide differing
subsets of.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/reset.c | 68 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 7c746d3458e7..6288780b779e 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -13,6 +13,9 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 
+#include <asm/compiler.h>
+#include <asm/idle.h>
+#include <asm/mipsregs.h>
 #include <asm/reboot.h>
 
 /*
@@ -26,6 +29,62 @@ void (*pm_power_off)(void);
 
 EXPORT_SYMBOL(pm_power_off);
 
+static void machine_hang(void)
+{
+	/*
+	 * We're hanging the system so we don't want to be interrupted anymore.
+	 * Any interrupt handlers that ran would at best be useless & at worst
+	 * go awry because the system isn't in a functional state.
+	 */
+	local_irq_disable();
+
+	/*
+	 * Mask all interrupts, giving us a better chance of remaining in the
+	 * low power wait state.
+	 */
+	clear_c0_status(ST0_IM);
+
+	while (true) {
+		if (cpu_has_mips_r) {
+			/*
+			 * We know that the wait instruction is supported so
+			 * make use of it directly, leaving interrupts
+			 * disabled.
+			 */
+			asm volatile(
+				".set	push\n\t"
+				".set	" MIPS_ISA_ARCH_LEVEL "\n\t"
+				"wait\n\t"
+				".set	pop");
+		} else if (cpu_wait) {
+			/*
+			 * Try the cpu_wait() callback. This isn't ideal since
+			 * it'll re-enable interrupts, but that ought to be
+			 * harmless given that they're all masked.
+			 */
+			cpu_wait();
+			local_irq_disable();
+		} else {
+			/*
+			 * We're going to burn some power running round the
+			 * loop, but we don't really have a choice. This isn't
+			 * a path we should expect to run for long during
+			 * typical use anyway.
+			 */
+		}
+
+		/*
+		 * In most modern MIPS CPUs interrupts will cause the wait
+		 * instruction to graduate even when disabled, and in some
+		 * cases even when masked. In order to prevent a timer
+		 * interrupt from continuously taking us out of the low power
+		 * wait state, we clear any pending timer interrupt here.
+		 */
+		if (cpu_has_counter)
+			write_c0_compare(0);
+	}
+}
+
 void machine_restart(char *command)
 {
 	if (_machine_restart)
@@ -38,8 +97,7 @@ void machine_restart(char *command)
 	do_kernel_restart(command);
 	mdelay(1000);
 	pr_emerg("Reboot failed -- System halted\n");
-	local_irq_disable();
-	while (1);
+	machine_hang();
 }
 
 void machine_halt(void)
@@ -51,8 +109,7 @@ void machine_halt(void)
 	preempt_disable();
 	smp_send_stop();
 #endif
-	local_irq_disable();
-	while (1);
+	machine_hang();
 }
 
 void machine_power_off(void)
@@ -64,6 +121,5 @@ void machine_power_off(void)
 	preempt_disable();
 	smp_send_stop();
 #endif
-	local_irq_disable();
-	while (1);
+	machine_hang();
 }
-- 
2.14.1
