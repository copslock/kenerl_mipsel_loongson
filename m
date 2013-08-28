From: Felix Fietkau <nbd@openwrt.org>
Date: Wed, 28 Aug 2013 10:41:42 +0200
Subject: MIPS: ath79: Fix ar933x watchdog clock
Message-ID: <20130828084142.gkmPo2XDod6oA_mpWd_eg4nxupZ4xpnf42eN0M4Dalc@z>

commit a1191927ace7e6f827132aa9e062779eb3f11fa5 upstream.

The watchdog device on the AR933x is connected to
the AHB clock, however the current code uses the
reference clock. Due to the wrong rate, the watchdog
driver can't calculate correct register values for
a given timeout value and the watchdog unexpectedly
restarts the system.

The code uses the wrong value since the initial
commit 04225e1d227c8e68d685936ecf42ac175fec0e54
(MIPS: ath79: add AR933X specific clock init)

The patch fixes the code to use the correct clock
rate to avoid the problem.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/5777/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/ath79/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 579f452..300d7d3 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -164,7 +164,7 @@ static void __init ar933x_clocks_init(void)
 		ath79_ahb_clk.rate = freq / t;
 	}

-	ath79_wdt_clk.rate = ath79_ref_clk.rate;
+	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
 	ath79_uart_clk.rate = ath79_ref_clk.rate;
 }

--
1.8.1.2
