Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 19:37:47 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42432 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826536Ab2KISh2Holc1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2012 19:37:28 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/6] MIPS: lantiq: fix bootselect bits on XRX200 SoC
Date:   Fri,  9 Nov 2012 19:36:19 +0100
Message-Id: <1352486183-22576-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
References: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34923
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

The XRX200 SoC family has a different register layout for reading the boot
selection bits.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/reset.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 22c55f7..2799212 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -34,11 +34,12 @@
 /* reset cause */
 #define RCU_STAT_SHIFT		26
 /* boot selection */
-#define RCU_BOOT_SEL_SHIFT	26
-#define RCU_BOOT_SEL_MASK	0x7
+#define RCU_BOOT_SEL(x)		((x >> 18) & 0x7)
+#define RCU_BOOT_SEL_XRX200(x)	(((x >> 17) & 0xf) | ((x >> 8) & 0x10))
 
 /* remapped base addr of the reset control unit */
 static void __iomem *ltq_rcu_membase;
+static struct device_node *ltq_rcu_np;
 
 /* This function is used by the watchdog driver */
 int ltq_reset_cause(void)
@@ -52,7 +53,11 @@ EXPORT_SYMBOL_GPL(ltq_reset_cause);
 unsigned char ltq_boot_select(void)
 {
 	u32 val = ltq_rcu_r32(RCU_RST_STAT);
-	return (val >> RCU_BOOT_SEL_SHIFT) & RCU_BOOT_SEL_MASK;
+
+	if (of_device_is_compatible(ltq_rcu_np, "lantiq,rcu-xrx200"))
+		return RCU_BOOT_SEL_XRX200(val);
+
+	return RCU_BOOT_SEL(val);
 }
 
 /* reset a io domain for u micro seconds */
@@ -85,14 +90,17 @@ static void ltq_machine_power_off(void)
 static int __init mips_reboot_setup(void)
 {
 	struct resource res;
-	struct device_node *np =
-		of_find_compatible_node(NULL, NULL, "lantiq,rcu-xway");
+
+	ltq_rcu_np = of_find_compatible_node(NULL, NULL, "lantiq,rcu-xway");
+	if (!ltq_rcu_np)
+		ltq_rcu_np = of_find_compatible_node(NULL, NULL,
+							"lantiq,rcu-xrx200");
 
 	/* check if all the reset register range is available */
-	if (!np)
+	if (!ltq_rcu_np)
 		panic("Failed to load reset resources from devicetree");
 
-	if (of_address_to_resource(np, 0, &res))
+	if (of_address_to_resource(ltq_rcu_np, 0, &res))
 		panic("Failed to get rcu memory range");
 
 	if (request_mem_region(res.start, resource_size(&res), res.name) < 0)
-- 
1.7.10.4
