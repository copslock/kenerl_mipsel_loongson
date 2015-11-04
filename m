Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 13:14:42 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:40380 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011411AbbKDMOZxOrSc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 13:14:25 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A3E2728BC8D;
        Wed,  4 Nov 2015 13:12:34 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 13:12:34 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/4] arch: mips: lantiq: initialize the USB core on boot
Date:   Wed,  4 Nov 2015 13:14:14 +0100
Message-Id: <1446639256-22526-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446639256-22526-1-git-send-email-blogic@openwrt.org>
References: <1446639256-22526-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49838
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

There is a DWC2 USB core in these SoCs. To make USB work we need to first
reset and power the state machine. These are SoC specific registers and
not part of the actual USB core.

Signed-off-by: Antti Seppälä <a.seppala@gmail.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/reset.c |   74 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index fe68f9a..7b3e48b 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -44,6 +44,37 @@
 #define RCU_BOOT_SEL(x)		((x >> 18) & 0x7)
 #define RCU_BOOT_SEL_XRX200(x)	(((x >> 17) & 0xf) | ((x >> 8) & 0x10))
 
+/* dwc2 USB configuration registers */
+#define RCU_USB1CFG		0x0018
+#define RCU_USB2CFG		0x0034
+
+/* USB DMA endianness bits */
+#define RCU_USBCFG_HDSEL_BIT	BIT(11)
+#define RCU_USBCFG_HOST_END_BIT	BIT(10)
+#define RCU_USBCFG_SLV_END_BIT	BIT(9)
+
+/* USB reset bits */
+#define RCU_USBRESET		0x0010
+
+#define USBRESET_BIT		BIT(4)
+
+#define RCU_USBRESET2		0x0048
+
+#define USB1RESET_BIT		BIT(4)
+#define USB2RESET_BIT		BIT(5)
+
+#define RCU_CFG1A		0x0038
+#define RCU_CFG1B		0x003C
+
+/* USB PMU devices */
+#define PMU_AHBM		BIT(15)
+#define PMU_USB0		BIT(6)
+#define PMU_USB1		BIT(27)
+
+/* USB PHY PMU devices */
+#define PMU_USB0_P		BIT(0)
+#define PMU_USB1_P		BIT(26)
+
 /* remapped base addr of the reset control unit */
 static void __iomem *ltq_rcu_membase;
 static struct device_node *ltq_rcu_np;
@@ -200,6 +231,45 @@ static void ltq_machine_power_off(void)
 	unreachable();
 }
 
+static void ltq_usb_init(void)
+{
+	/* Power for USB cores 1 & 2 */
+	ltq_pmu_enable(PMU_AHBM);
+	ltq_pmu_enable(PMU_USB0);
+	ltq_pmu_enable(PMU_USB1);
+
+	ltq_rcu_w32(ltq_rcu_r32(RCU_CFG1A) | BIT(0), RCU_CFG1A);
+	ltq_rcu_w32(ltq_rcu_r32(RCU_CFG1B) | BIT(0), RCU_CFG1B);
+
+	/* Enable USB PHY power for cores 1 & 2 */
+	ltq_pmu_enable(PMU_USB0_P);
+	ltq_pmu_enable(PMU_USB1_P);
+
+	/* Configure cores to host mode */
+	ltq_rcu_w32(ltq_rcu_r32(RCU_USB1CFG) & ~RCU_USBCFG_HDSEL_BIT,
+		RCU_USB1CFG);
+	ltq_rcu_w32(ltq_rcu_r32(RCU_USB2CFG) & ~RCU_USBCFG_HDSEL_BIT,
+		RCU_USB2CFG);
+
+	/* Select DMA endianness (Host-endian: big-endian) */
+	ltq_rcu_w32((ltq_rcu_r32(RCU_USB1CFG) & ~RCU_USBCFG_SLV_END_BIT)
+		| RCU_USBCFG_HOST_END_BIT, RCU_USB1CFG);
+	ltq_rcu_w32(ltq_rcu_r32((RCU_USB2CFG) & ~RCU_USBCFG_SLV_END_BIT)
+		| RCU_USBCFG_HOST_END_BIT, RCU_USB2CFG);
+
+	/* Hard reset USB state machines */
+	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET) | USBRESET_BIT, RCU_USBRESET);
+	udelay(50 * 1000);
+	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET) & ~USBRESET_BIT, RCU_USBRESET);
+
+	/* Soft reset USB state machines */
+	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET2)
+		| USB1RESET_BIT | USB2RESET_BIT, RCU_USBRESET2);
+	udelay(50 * 1000);
+	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET2)
+		& ~(USB1RESET_BIT | USB2RESET_BIT), RCU_USBRESET2);
+}
+
 static int __init mips_reboot_setup(void)
 {
 	struct resource res;
@@ -223,6 +293,10 @@ static int __init mips_reboot_setup(void)
 	if (!ltq_rcu_membase)
 		panic("Failed to remap core memory");
 
+	if (of_machine_is_compatible("lantiq,ar9") ||
+	    of_machine_is_compatible("lantiq,vr9"))
+		ltq_usb_init();
+
 	_machine_restart = ltq_machine_restart;
 	_machine_halt = ltq_machine_halt;
 	pm_power_off = ltq_machine_power_off;
-- 
1.7.10.4
