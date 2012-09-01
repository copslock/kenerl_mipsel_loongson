Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2012 18:46:22 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46516 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903298Ab2IAQqQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2012 18:46:16 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5CFE323C0094;
        Sat,  1 Sep 2012 18:46:14 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        <stable@vger.kernel.org>, "[3.5+]"@arrakis.dune.hu
Subject: [PATCH] MIPS: ath79: use correct fractional dividers for {CPU,DDR}_PLL on AR934x
Date:   Sat,  1 Sep 2012 18:46:00 +0200
Message-Id: <1346517960-13537-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 34394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
X-Status: A

The current dividers in the code are wrong and this
leads to broken CPU frequency calculation on boards
where the fractional part is used.

For example, if the SoC is running from a 40MHz
reference clock, refdiv=1, nint=14, outdiv=0 and
nfrac=31 the real frequency is 579.375MHz but the
current code calculates 569.687MHz instead.

Because the system time is indirectly related to
the CPU frequency the broken computation causes
drift in the system time.

The correct divider is 2^6 for the CPU PLL and 2^10
for the DDR PLL. Use the correct values to fix the
issue.

Cc: <stable@vger.kernel.org>  [3.5+]
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index b91ad3e..d272857 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -189,7 +189,7 @@ static void __init ar934x_clocks_init(void)
 	       AR934X_PLL_CPU_CONFIG_NFRAC_MASK;
 
 	cpu_pll = nint * ath79_ref_clk.rate / ref_div;
-	cpu_pll += frac * ath79_ref_clk.rate / (ref_div * (2 << 6));
+	cpu_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 6));
 	cpu_pll /= (1 << out_div);
 
 	pll = ath79_pll_rr(AR934X_PLL_DDR_CONFIG_REG);
@@ -203,7 +203,7 @@ static void __init ar934x_clocks_init(void)
 	       AR934X_PLL_DDR_CONFIG_NFRAC_MASK;
 
 	ddr_pll = nint * ath79_ref_clk.rate / ref_div;
-	ddr_pll += frac * ath79_ref_clk.rate / (ref_div * (2 << 10));
+	ddr_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 10));
 	ddr_pll /= (1 << out_div);
 
 	clk_ctrl = ath79_pll_rr(AR934X_PLL_CPU_DDR_CLK_CTRL_REG);
-- 
1.7.10
