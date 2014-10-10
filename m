Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:29:54 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36769
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011013AbaJJW3PtiiJQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:15 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 02/10] MIPS: lantiq: add reset-controller api support
Date:   Sat, 11 Oct 2014 00:02:26 +0200
Message-Id: <1412978554-31344-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43227
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

Add a reset-controller binding for the reset registers found on the lantiq
SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig             |    2 ++
 arch/mips/lantiq/xway/reset.c |   61 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 380cce3..46bee77 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -268,6 +268,8 @@ config LANTIQ
 	select USE_OF
 	select PINCTRL
 	select PINCTRL_LANTIQ
+	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 
 config LASAT
 	bool "LASAT Networks platforms"
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 1fa0f17..a1e06b7 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/reset-controller.h>
 
 #include <asm/reboot.h>
 
@@ -113,6 +114,66 @@ void ltq_reset_once(unsigned int module, ulong u)
 	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) & ~module, RCU_RST_REQ);
 }
 
+static int ltq_assert_device(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	u32 val;
+
+	if (id < 8)
+		return -1;
+
+	val = ltq_rcu_r32(RCU_RST_REQ);
+	val |= BIT(id);
+	ltq_rcu_w32(val, RCU_RST_REQ);
+
+	return 0;
+}
+
+static int ltq_deassert_device(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	u32 val;
+
+	if (id < 8)
+		return -1;
+
+	val = ltq_rcu_r32(RCU_RST_REQ);
+	val &= ~BIT(id);
+	ltq_rcu_w32(val, RCU_RST_REQ);
+
+	return 0;
+}
+
+static int ltq_reset_device(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	ltq_assert_device(rcdev, id);
+	return ltq_deassert_device(rcdev, id);
+}
+
+static struct reset_control_ops reset_ops = {
+	.reset = ltq_reset_device,
+	.assert = ltq_assert_device,
+	.deassert = ltq_deassert_device,
+};
+
+static struct reset_controller_dev reset_dev = {
+	.ops			= &reset_ops,
+	.owner			= THIS_MODULE,
+	.nr_resets		= 32,
+	.of_reset_n_cells	= 1,
+};
+
+void ltq_rst_init(void)
+{
+	reset_dev.of_node = of_find_compatible_node(NULL, NULL,
+						"lantiq,xway-reset");
+	if (!reset_dev.of_node)
+		pr_err("Failed to find reset controller node");
+	else
+		reset_controller_register(&reset_dev);
+}
+
 static void ltq_machine_restart(char *command)
 {
 	local_irq_disable();
-- 
1.7.10.4
