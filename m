Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 13:09:03 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:52010 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833383Ab3AWMIlyA7bx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 13:08:41 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RFC 01/11] MIPS: allow platforms to override cp0_compare_irq
Date:   Wed, 23 Jan 2013 13:05:45 +0100
Message-Id: <1358942755-25371-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Ralink SoC needs to be able to override cp0_compare_irq. We do this similar to
the way in which how cp0_compare_int can be overridden.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/time.h |    1 +
 arch/mips/kernel/traps.c     |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 761f2e9..c5ad468 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -51,6 +51,7 @@ extern int (*perf_irq)(void);
  * Initialize the calling CPU's compare interrupt as clockevent device
  */
 extern unsigned int __weak get_c0_compare_int(void);
+extern unsigned int __weak get_c0_compare_irq(void);
 extern int r4k_clockevent_init(void);
 
 static inline int mips_clockevent_init(void)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cf7ac54..260d7f6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -55,6 +55,7 @@
 #include <asm/types.h>
 #include <asm/stacktrace.h>
 #include <asm/uasm.h>
+#include <asm/time.h>
 
 extern void check_wait(void);
 extern asmlinkage void r4k_wait(void);
@@ -1616,7 +1617,11 @@ void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
 	 */
 	if (cpu_has_mips_r2) {
 		cp0_compare_irq_shift = CAUSEB_TI - CAUSEB_IP;
-		cp0_compare_irq = (read_c0_intctl() >> INTCTLB_IPTI) & 7;
+		if (get_c0_compare_irq)
+			cp0_compare_irq = get_c0_compare_irq();
+		else
+			cp0_compare_irq =
+				(read_c0_intctl() >> INTCTLB_IPTI) & 7;
 		cp0_perfcount_irq = (read_c0_intctl() >> INTCTLB_IPPCI) & 7;
 		if (cp0_perfcount_irq == cp0_compare_irq)
 			cp0_perfcount_irq = -1;
-- 
1.7.10.4
