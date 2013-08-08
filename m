Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:13:34 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54686 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865306Ab3HHLNH7Tlgh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 13:13:07 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: ralink: add support for reset-controller API
Date:   Thu,  8 Aug 2013 13:05:50 +0200
Message-Id: <1375959950-31024-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375959950-31024-1-git-send-email-blogic@openwrt.org>
References: <1375959950-31024-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37458
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

Add a helper for reseting different devices on the SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig         |    1 +
 arch/mips/ralink/common.h |    2 ++
 arch/mips/ralink/of.c     |    3 +++
 arch/mips/ralink/reset.c  |   62 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 45b4356..bb69e12 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -375,6 +375,7 @@ config MACH_VR41XX
 	select CSRC_R4K
 	select SYS_HAS_CPU_VR41XX
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_RESET_CONTROLLER
 
 config NXP_STB220
 	bool "NXP STB220 board"
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 83144c3..42dfd61 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -46,6 +46,8 @@ extern void ralink_of_remap(void);
 extern void ralink_clk_init(void);
 extern void ralink_clk_add(const char *dev, unsigned long rate);
 
+extern void ralink_rst_init(void);
+
 extern void prom_soc_init(struct ralink_soc_info *soc_info);
 
 __iomem void *plat_of_remap_node(const char *node);
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index f25ea5b..ce38d11 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -110,6 +110,9 @@ static int __init plat_of_setup(void)
 	if (of_platform_populate(NULL, of_ids, NULL, NULL))
 		panic("failed to populate DT\n");
 
+	/* make sure ithat the reset controller is setup early */
+	ralink_rst_init();
+
 	return 0;
 }
 
diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index 22120e5..55c7ec5 100644
--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -10,6 +10,8 @@
 
 #include <linux/pm.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/reset-controller.h>
 
 #include <asm/reboot.h>
 
@@ -19,6 +21,66 @@
 #define SYSC_REG_RESET_CTRL     0x034
 #define RSTCTL_RESET_SYSTEM     BIT(0)
 
+static int ralink_assert_device(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	u32 val;
+
+	if (id < 8)
+		return -1;
+
+	val = rt_sysc_r32(SYSC_REG_RESET_CTRL);
+	val |= BIT(id);
+	rt_sysc_w32(val, SYSC_REG_RESET_CTRL);
+
+	return 0;
+}
+
+static int ralink_deassert_device(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	u32 val;
+
+	if (id < 8)
+		return -1;
+
+	val = rt_sysc_r32(SYSC_REG_RESET_CTRL);
+	val &= ~BIT(id);
+	rt_sysc_w32(val, SYSC_REG_RESET_CTRL);
+
+	return 0;
+}
+
+static int ralink_reset_device(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	ralink_assert_device(rcdev, id);
+	return ralink_deassert_device(rcdev, id);
+}
+
+static struct reset_control_ops reset_ops = {
+	.reset = ralink_reset_device,
+	.assert = ralink_assert_device,
+	.deassert = ralink_deassert_device,
+};
+
+static struct reset_controller_dev reset_dev = {
+	.ops			= &reset_ops,
+	.owner			= THIS_MODULE,
+	.nr_resets		= 32,
+	.of_reset_n_cells	= 1,
+};
+
+void ralink_rst_init(void)
+{
+	reset_dev.of_node = of_find_compatible_node(NULL, NULL,
+						"ralink,rt2880-reset");
+	if (!reset_dev.of_node)
+		pr_err("Failed to find reset controller node");
+	else
+		reset_controller_register(&reset_dev);
+}
+
 static void ralink_restart(char *command)
 {
 	local_irq_disable();
-- 
1.7.10.4
