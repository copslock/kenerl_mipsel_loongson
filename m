Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 15:02:35 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38402 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827622AbaAOOBYKQrIh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 15:01:24 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 08/10] MIPS: support use of cpuidle
Date:   Wed, 15 Jan 2014 13:55:35 +0000
Message-ID: <1389794137-11361-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_14_01_18
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39009
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

This patch lays the groundwork for MIPS platforms to make use of the
cpuidle framework. The arch_cpu_idle function simply calls cpuidle &
falls back to the regular cpu_wait path if cpuidle should fail (eg. if
it's not selected or no driver is registered). A generic cpuidle state
for the wait instruction is introduced, intended to ease use of the wait
instruction from cpuidle drivers and reduce code duplication.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 arch/mips/Kconfig            |  2 ++
 arch/mips/include/asm/idle.h | 14 ++++++++++++++
 arch/mips/kernel/idle.c      | 20 +++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5bc27c0..95f2f11 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1838,6 +1838,8 @@ config CPU_R4K_CACHE_TLB
 	bool
 	default y if !(CPU_R3000 || CPU_R8000 || CPU_SB1 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
 
+source "drivers/cpuidle/Kconfig"
+
 choice
 	prompt "MIPS MT options"
 
diff --git a/arch/mips/include/asm/idle.h b/arch/mips/include/asm/idle.h
index d192158..d9f932d 100644
--- a/arch/mips/include/asm/idle.h
+++ b/arch/mips/include/asm/idle.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_IDLE_H
 #define __ASM_IDLE_H
 
+#include <linux/cpuidle.h>
 #include <linux/linkage.h>
 
 extern void (*cpu_wait)(void);
@@ -20,4 +21,17 @@ static inline int address_is_in_r4k_wait_irqoff(unsigned long addr)
 	       addr < (unsigned long)__pastwait;
 }
 
+extern int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
+				   struct cpuidle_driver *drv, int index);
+
+#define MIPS_CPUIDLE_WAIT_STATE {\
+	.enter			= mips_cpuidle_wait_enter,\
+	.exit_latency		= 1,\
+	.target_residency	= 1,\
+	.power_usage		= UINT_MAX,\
+	.flags			= CPUIDLE_FLAG_TIME_VALID,\
+	.name			= "wait",\
+	.desc			= "MIPS wait",\
+}
+
 #endif /* __ASM_IDLE_H  */
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 3553243..64e91e4 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -11,6 +11,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
@@ -239,7 +240,7 @@ static void smtc_idle_hook(void)
 #endif
 }
 
-void arch_cpu_idle(void)
+static void mips_cpu_idle(void)
 {
 	smtc_idle_hook();
 	if (cpu_wait)
@@ -247,3 +248,20 @@ void arch_cpu_idle(void)
 	else
 		local_irq_enable();
 }
+
+void arch_cpu_idle(void)
+{
+	if (cpuidle_idle_call())
+		mips_cpu_idle();
+}
+
+#ifdef CONFIG_CPU_IDLE
+
+int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	mips_cpu_idle();
+	return index;
+}
+
+#endif
-- 
1.8.4.2
