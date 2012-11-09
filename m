Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 19:38:43 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42441 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826539Ab2KIShayi5Wu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2012 19:37:30 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 5/6] MIPS: lantiq: adds code for booting GPHY
Date:   Fri,  9 Nov 2012 19:36:22 +0100
Message-Id: <1352486183-22576-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
References: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34926
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

The XRX200 family of SoCs has embedded gigabit PHYs. This patch adds code to
boot them up.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    3 ++
 arch/mips/lantiq/xway/reset.c                      |   36 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 6a2df70..133336b 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -82,6 +82,9 @@ extern __iomem void *ltq_cgu_membase;
 #define LTQ_MPS_BASE_ADDR	(KSEG1 + 0x1F107000)
 #define LTQ_MPS_CHIPID		((u32 *)(LTQ_MPS_BASE_ADDR + 0x0344))
 
+/* allow booting xrx200 phys */
+int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr);
+
 /* request a non-gpio and set the PIO config */
 #define PMU_PPE			 BIT(13)
 extern void ltq_pmu_enable(unsigned int module);
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 2799212..544dbb7 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -28,9 +28,15 @@
 #define RCU_RST_REQ		0x0010
 /* reset status register */
 #define RCU_RST_STAT		0x0014
+/* vr9 gphy registers */
+#define RCU_GFS_ADD0_XRX200	0x0020
+#define RCU_GFS_ADD1_XRX200	0x0068
 
 /* reboot bit */
+#define RCU_RD_GPHY0_XRX200	BIT(31)
 #define RCU_RD_SRST		BIT(30)
+#define RCU_RD_GPHY1_XRX200	BIT(29)
+
 /* reset cause */
 #define RCU_STAT_SHIFT		26
 /* boot selection */
@@ -60,6 +66,36 @@ unsigned char ltq_boot_select(void)
 	return RCU_BOOT_SEL(val);
 }
 
+/* reset / boot a gphy */
+static struct ltq_xrx200_gphy_reset {
+	u32 rd;
+	u32 addr;
+} xrx200_gphy[] = {
+	{RCU_RD_GPHY0_XRX200, RCU_GFS_ADD0_XRX200},
+	{RCU_RD_GPHY1_XRX200, RCU_GFS_ADD1_XRX200},
+};
+
+/* reset and boot a gphy. these phys only exist on xrx200 SoC */
+int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
+{
+	if (!of_device_is_compatible(ltq_rcu_np, "lantiq,rcu-xrx200")) {
+		dev_err(dev, "this SoC has no GPHY\n");
+		return -EINVAL;
+	}
+	if (id > 1) {
+		dev_err(dev, "%u is an invalid gphy id\n", id);
+		return -EINVAL;
+	}
+	dev_info(dev, "booting GPHY%u firmware at %X\n", id, dev_addr);
+
+	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | xrx200_gphy[id].rd,
+			RCU_RST_REQ);
+	ltq_rcu_w32(dev_addr, xrx200_gphy[id].addr);
+	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) & ~xrx200_gphy[id].rd,
+			RCU_RST_REQ);
+	return 0;
+}
+
 /* reset a io domain for u micro seconds */
 void ltq_reset_once(unsigned int module, ulong u)
 {
-- 
1.7.10.4
