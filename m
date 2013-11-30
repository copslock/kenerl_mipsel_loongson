Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Nov 2013 12:46:27 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35094 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831312Ab3K3LppNxUGF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Nov 2013 12:45:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 88081280847;
        Sat, 30 Nov 2013 12:43:42 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 98038280153;
        Sat, 30 Nov 2013 12:43:41 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org, linux-spi@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 1/5] MIPS: BCM63XX: expose the HSSPI clock
Date:   Sat, 30 Nov 2013 12:42:02 +0100
Message-Id: <1385811726-6746-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/clk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 43da4ae..37a621a 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -226,6 +226,28 @@ static struct clk clk_spi = {
 };
 
 /*
+ * HSSPI clock
+ */
+static void hsspi_set(struct clk *clk, int enable)
+{
+	u32 mask;
+
+	if (BCMCPU_IS_6328())
+		mask = CKCTL_6328_HSSPI_EN;
+	else if (BCMCPU_IS_6362())
+		mask = CKCTL_6362_HSSPI_EN;
+	else
+		return;
+
+	bcm_hwclock_set(mask, enable);
+}
+
+static struct clk clk_hsspi = {
+	.set	= hsspi_set,
+};
+
+
+/*
  * XTM clock
  */
 static void xtm_set(struct clk *clk, int enable)
@@ -346,6 +368,8 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_usbd;
 	if (!strcmp(id, "spi"))
 		return &clk_spi;
+	if (!strcmp(id, "hsspi"))
+		return &clk_hsspi;
 	if (!strcmp(id, "xtm"))
 		return &clk_xtm;
 	if (!strcmp(id, "periph"))
-- 
1.8.4.rc3
