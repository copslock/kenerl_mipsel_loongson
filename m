Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 10:45:10 +0200 (CEST)
Received: from newton.telenet-ops.be ([IPv6:2a02:1800:120:4::f00:d]:60326 "EHLO
        newton.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbeFKIohHGEHb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 10:44:37 +0200
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by newton.telenet-ops.be (Postfix) with ESMTPS id 41465C6Lt0zMqr7k
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2018 10:44:31 +0200 (CEST)
Received: from ayla.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id xLkS1x00Z3XaVaC01LkSy2; Mon, 11 Jun 2018 10:44:31 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0006xV-Gt; Mon, 11 Jun 2018 10:44:26 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0005OO-FV; Mon, 11 Jun 2018 10:44:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3 RFC] Revert "net: stmmac: fix build failure due to missing COMMON_CLK dependency"
Date:   Mon, 11 Jun 2018 10:44:23 +0200
Message-Id: <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.

All legacy clock implementations now implement clk_set_rate() (Some
implementations may be dummies, though).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Marked "RFC", as this depends on "m68k: coldfire: Normalize clk API" and
"MIPS: AR7: Normalize clk API".
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index cb5b0f58c395c2bd..e28c0d2c58e911ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -33,7 +33,7 @@ config DWMAC_DWC_QOS_ETH
 	select PHYLIB
 	select CRC32
 	select MII
-	depends on OF && COMMON_CLK && HAS_DMA
+	depends on OF && HAS_DMA
 	help
 	  Support for chips using the snps,dwc-qos-ethernet.txt DT binding.
 
@@ -57,7 +57,7 @@ config DWMAC_ANARION
 config DWMAC_IPQ806X
 	tristate "QCA IPQ806x DWMAC support"
 	default ARCH_QCOM
-	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for QCA IPQ806X DWMAC Ethernet.
@@ -100,7 +100,7 @@ config DWMAC_OXNAS
 config DWMAC_ROCKCHIP
 	tristate "Rockchip dwmac support"
 	default ARCH_ROCKCHIP
-	depends on OF && COMMON_CLK && (ARCH_ROCKCHIP || COMPILE_TEST)
+	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
 	select MFD_SYSCON
 	help
 	  Support for Ethernet controller on Rockchip RK3288 SoC.
@@ -123,7 +123,7 @@ config DWMAC_SOCFPGA
 config DWMAC_STI
 	tristate "STi GMAC support"
 	default ARCH_STI
-	depends on OF && COMMON_CLK && (ARCH_STI || COMPILE_TEST)
+	depends on OF && (ARCH_STI || COMPILE_TEST)
 	select MFD_SYSCON
 	---help---
 	  Support for ethernet controller on STi SOCs.
@@ -147,7 +147,7 @@ config DWMAC_STM32
 config DWMAC_SUNXI
 	tristate "Allwinner GMAC support"
 	default ARCH_SUNXI
-	depends on OF && COMMON_CLK && (ARCH_SUNXI || COMPILE_TEST)
+	depends on OF && (ARCH_SUNXI || COMPILE_TEST)
 	---help---
 	  Support for Allwinner A20/A31 GMAC ethernet controllers.
 
-- 
2.7.4
