Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Apr 2011 13:36:01 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53648 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490992Ab1DZLfz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Apr 2011 13:35:55 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: lantiq: allow WDT to read reset cause bit from the RCU registers
Date:   Tue, 26 Apr 2011 13:37:01 +0200
Message-Id: <1303817821-19491-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

The watchdog needs to know if the last reset cause was the watchdog itself.
This patch adds a function to easily read the relevant bits form the RCU
registers.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mach-lantiq/lantiq.h |    4 ++++
 arch/mips/lantiq/xway/reset.c              |   12 ++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index 1a705b4..ce2f029 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -49,6 +49,10 @@ extern void ltq_disable_irq(struct irq_data *data);
 extern void ltq_mask_and_ack_irq(struct irq_data *data);
 extern void ltq_enable_irq(struct irq_data *data);
 
+/* find out what caused the last cpu reset */
+extern int ltq_reset_cause(void);
+#define LTQ_RST_CAUSE_WDTRST	0x20
+
 #define IOPORT_RESOURCE_START	0x10000000
 #define IOPORT_RESOURCE_END	0xffffffff
 #define IOMEM_RESOURCE_START	0x10000000
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index e3ec635..a1be36d 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/pm.h>
+#include <linux/module.h>
 #include <asm/reboot.h>
 
 #include <lantiq_soc.h>
@@ -21,6 +22,9 @@
 #define LTQ_RCU_RST		0x0010
 #define LTQ_RCU_RST_ALL		0x40000000
 
+#define LTQ_RCU_RST_STAT	0x0014
+#define LTQ_RCU_STAT_SHIFT	26
+
 static struct resource ltq_rcu_resource = {
 	.name   = "rcu",
 	.start  = LTQ_RCU_BASE_ADDR,
@@ -31,6 +35,14 @@ static struct resource ltq_rcu_resource = {
 /* remapped base addr of the reset control unit */
 static void __iomem *ltq_rcu_membase;
 
+/* This function is used by the watchdog driver */
+int ltq_reset_cause(void)
+{
+	u32 val = ltq_rcu_r32(LTQ_RCU_RST_STAT);
+	return val >> LTQ_RCU_STAT_SHIFT;
+}
+EXPORT_SYMBOL_GPL(ltq_reset_cause);
+
 static void ltq_machine_restart(char *command)
 {
 	pr_notice("System restart\n");
-- 
1.7.2.3
