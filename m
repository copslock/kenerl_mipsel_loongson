Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:50:26 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53145 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903649Ab2D3LuU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:50:20 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 14/14] MIPS: lantiq: cleanup reset code
Date:   Mon, 30 Apr 2012 13:33:09 +0200
Message-Id: <1335785589-32532-14-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add 2 new soc specifc handlers and remove superflous pr_notice calls.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-lantiq/lantiq.h         |    3 +-
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   10 ++++
 arch/mips/lantiq/xway/reset.c                      |   48 +++++++++++++++-----
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index ce2f029..7a90190 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -48,7 +48,8 @@ extern spinlock_t ebu_lock;
 extern void ltq_disable_irq(struct irq_data *data);
 extern void ltq_mask_and_ack_irq(struct irq_data *data);
 extern void ltq_enable_irq(struct irq_data *data);
-
+/* find out what bootsource we have */
+extern unsigned char ltq_boot_select(void);
 /* find out what caused the last cpu reset */
 extern int ltq_reset_cause(void);
 #define LTQ_RST_CAUSE_WDTRST	0x20
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index af6c0f0..15eb4dc 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -49,6 +49,16 @@
 #define LTQ_ASC1_BASE_ADDR	0x1E100C00
 #define LTQ_ASC_SIZE		0x400
 
+/* BOOT_SEL - find what boot media we have */
+#define BS_EXT_ROM		0x0
+#define BS_FLASH		0x1
+#define BS_MII0			0x2
+#define BS_PCI			0x3
+#define BS_UART1		0x4
+#define BS_SPI			0x5
+#define BS_NAND			0x6
+#define BS_RMII0		0x7
+
 /*
  * during early_printk no ioremap is possible
  * lets use KSEG1 instead
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 8b66bd8..3327211 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -11,19 +11,31 @@
 #include <linux/ioport.h>
 #include <linux/pm.h>
 #include <linux/export.h>
+#include <linux/delay.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
 #include <asm/reboot.h>
 
 #include <lantiq_soc.h>
 
+#include "../prom.h"
+
 #define ltq_rcu_w32(x, y)	ltq_w32((x), ltq_rcu_membase + (y))
 #define ltq_rcu_r32(x)		ltq_r32(ltq_rcu_membase + (x))
 
-/* register definitions */
-#define LTQ_RCU_RST		0x0010
-#define LTQ_RCU_RST_ALL		0x40000000
+/* reset request register */
+#define RCU_RST_REQ		0x0010
+/* reset status register */
+#define RCU_RST_STAT		0x0014
 
-#define LTQ_RCU_RST_STAT	0x0014
-#define LTQ_RCU_STAT_SHIFT	26
+/* reboot bit */
+#define RCU_RD_SRST		BIT(30)
+/* reset cause */
+#define RCU_STAT_SHIFT		26
+/* boot selection */
+#define RCU_BOOT_SEL_SHIFT	26
+#define RCU_BOOT_SEL_MASK	0x7
 
 static struct resource ltq_rcu_resource = {
 	.name   = "rcu",
@@ -38,29 +50,41 @@ static void __iomem *ltq_rcu_membase;
 /* This function is used by the watchdog driver */
 int ltq_reset_cause(void)
 {
-	u32 val = ltq_rcu_r32(LTQ_RCU_RST_STAT);
-	return val >> LTQ_RCU_STAT_SHIFT;
+	u32 val = ltq_rcu_r32(RCU_RST_STAT);
+	return val >> RCU_STAT_SHIFT;
 }
 EXPORT_SYMBOL_GPL(ltq_reset_cause);
 
+/* allow platform code to find out what source we booted from */
+unsigned char ltq_boot_select(void)
+{
+	u32 val = ltq_rcu_r32(RCU_RST_STAT);
+	return (val >> RCU_BOOT_SEL_SHIFT) & RCU_BOOT_SEL_MASK;
+}
+
+/* reset a io domain for u micro seconds */
+void ltq_reset_once(unsigned int module, ulong u)
+{
+	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | module, RCU_RST_REQ);
+	udelay(u);
+	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) & ~module, RCU_RST_REQ);
+}
+
 static void ltq_machine_restart(char *command)
 {
-	pr_notice("System restart\n");
 	local_irq_disable();
-	ltq_rcu_w32(ltq_rcu_r32(LTQ_RCU_RST) | LTQ_RCU_RST_ALL, LTQ_RCU_RST);
+	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | RCU_RD_SRST, RCU_RST_REQ);
 	unreachable();
 }
 
 static void ltq_machine_halt(void)
 {
-	pr_notice("System halted.\n");
 	local_irq_disable();
 	unreachable();
 }
 
 static void ltq_machine_power_off(void)
 {
-	pr_notice("Please turn off the power now.\n");
 	local_irq_disable();
 	unreachable();
 }
@@ -79,7 +103,7 @@ static int __init mips_reboot_setup(void)
 	ltq_rcu_membase = ioremap_nocache(ltq_rcu_resource.start,
 				resource_size(&ltq_rcu_resource));
 	if (!ltq_rcu_membase)
-		panic("Failed to remap rcu memory");
+		panic("Failed to remap core memory");
 
 	_machine_restart = ltq_machine_restart;
 	_machine_halt = ltq_machine_halt;
-- 
1.7.9.1
