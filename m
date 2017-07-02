Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 00:44:42 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:36406 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994274AbdGBWlXkfuJa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 00:41:23 +0200
Received: from hauke-desktop.lan (p20030086285C0200C8691593FAB84A84.dip0.t-ipconnect.de [IPv6:2003:86:285c:200:c869:1593:fab8:4a84])
        by mail.hauke-m.de (Postfix) with ESMTPSA id DADE31001EB;
        Mon,  3 Jul 2017 00:41:22 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v7 11/16] MIPS: lantiq: remove old reset controller implementation
Date:   Mon,  3 Jul 2017 00:40:46 +0200
Message-Id: <20170702224051.15109-12-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170702224051.15109-1-hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This code is now replaced by a reset controller in drivers/reset/reset-
lantiq-rcu.c. The old code was never used anyway.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/reset.c | 68 -------------------------------------------
 1 file changed, 68 deletions(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 2dedcf939901..5cb9309b0047 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -194,74 +194,6 @@ int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
 	return 0;
 }
 
-/* reset a io domain for u micro seconds */
-void ltq_reset_once(unsigned int module, ulong u)
-{
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | module, RCU_RST_REQ);
-	udelay(u);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) & ~module, RCU_RST_REQ);
-}
-
-static int ltq_assert_device(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	u32 val;
-
-	if (id < 8)
-		return -1;
-
-	val = ltq_rcu_r32(RCU_RST_REQ);
-	val |= BIT(id);
-	ltq_rcu_w32(val, RCU_RST_REQ);
-
-	return 0;
-}
-
-static int ltq_deassert_device(struct reset_controller_dev *rcdev,
-				  unsigned long id)
-{
-	u32 val;
-
-	if (id < 8)
-		return -1;
-
-	val = ltq_rcu_r32(RCU_RST_REQ);
-	val &= ~BIT(id);
-	ltq_rcu_w32(val, RCU_RST_REQ);
-
-	return 0;
-}
-
-static int ltq_reset_device(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	ltq_assert_device(rcdev, id);
-	return ltq_deassert_device(rcdev, id);
-}
-
-static const struct reset_control_ops reset_ops = {
-	.reset = ltq_reset_device,
-	.assert = ltq_assert_device,
-	.deassert = ltq_deassert_device,
-};
-
-static struct reset_controller_dev reset_dev = {
-	.ops			= &reset_ops,
-	.owner			= THIS_MODULE,
-	.nr_resets		= 32,
-	.of_reset_n_cells	= 1,
-};
-
-void ltq_rst_init(void)
-{
-	reset_dev.of_node = of_find_compatible_node(NULL, NULL,
-						"lantiq,xway-reset");
-	if (!reset_dev.of_node)
-		pr_err("Failed to find reset controller node");
-	else
-		reset_controller_register(&reset_dev);
-}
-
 static void ltq_machine_restart(char *command)
 {
 	u32 val = ltq_rcu_r32(RCU_RST_REQ);
-- 
2.11.0
