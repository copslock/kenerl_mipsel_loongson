Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Nov 2013 12:46:00 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35102 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6838329Ab3K3LppOQBGN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Nov 2013 12:45:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 490F8281488;
        Sat, 30 Nov 2013 12:43:43 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 4C035280732;
        Sat, 30 Nov 2013 12:43:42 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org, linux-spi@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/5] MIPS: BCM63XX: setup the HSSPI clock rate
Date:   Sat, 30 Nov 2013 12:42:03 +0100
Message-Id: <1385811726-6746-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38615
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

Properly set up the HSSPI clock rate depending on the SoC's PLL rate.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/clk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 37a621a..6375652 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -390,3 +390,21 @@ void clk_put(struct clk *clk)
 }
 
 EXPORT_SYMBOL(clk_put);
+
+#define HSSPI_PLL_HZ_6328	133333333
+#define HSSPI_PLL_HZ_6362	400000000
+
+static int __init bcm63xx_clk_init(void)
+{
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6328_CPU_ID:
+		clk_hsspi.rate = HSSPI_PLL_HZ_6328;
+		break;
+	case BCM6362_CPU_ID:
+		clk_hsspi.rate = HSSPI_PLL_HZ_6362;
+		break;
+	}
+
+	return 0;
+}
+arch_initcall(bcm63xx_clk_init);
-- 
1.8.4.rc3
