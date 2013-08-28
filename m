Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Aug 2013 10:44:00 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55249 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817986Ab3H1IlxbqNN2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Aug 2013 10:41:53 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 25B29280822;
        Wed, 28 Aug 2013 10:41:19 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 28 Aug 2013 10:41:19 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 4/6] MIPS: ath79: use ath79_get_sys_clk_rate to get basic clock rates
Date:   Wed, 28 Aug 2013 10:41:45 +0200
Message-Id: <1377679307-429-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
References: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37702
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

Instead of accessing the rate field of the static
clock devices directly, use the recently introduced
helper function to get the rate of the basic clocks.

The static ath79_{ahb,cpu,ddr,ref}_clk variables
will be removed by a subsequent patch. The actual
change is in preparation of that.

Also move the clock frequency printing code into
the plat_time_init function. We are getting the
cpu clock rate there already so we can save an
extra call of the helper.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/clock.c |   11 -----------
 arch/mips/ath79/setup.c |   12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index c8351b4..ebd4340 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -387,17 +387,6 @@ void __init ath79_clocks_init(void)
 		qca955x_clocks_init();
 	else
 		BUG();
-
-	pr_info("Clocks: CPU:%lu.%03luMHz, DDR:%lu.%03luMHz, AHB:%lu.%03luMHz, "
-		"Ref:%lu.%03luMHz",
-		ath79_cpu_clk.rate / 1000000,
-		(ath79_cpu_clk.rate / 1000) % 1000,
-		ath79_ddr_clk.rate / 1000000,
-		(ath79_ddr_clk.rate / 1000) % 1000,
-		ath79_ahb_clk.rate / 1000000,
-		(ath79_ahb_clk.rate / 1000) % 1000,
-		ath79_ref_clk.rate / 1000000,
-		(ath79_ref_clk.rate / 1000) % 1000);
 }
 
 unsigned long __init
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index e3b8345..c02d345 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -210,8 +210,20 @@ void __init plat_mem_setup(void)
 void __init plat_time_init(void)
 {
 	unsigned long cpu_clk_rate;
+	unsigned long ahb_clk_rate;
+	unsigned long ddr_clk_rate;
+	unsigned long ref_clk_rate;
 
 	cpu_clk_rate = ath79_get_sys_clk_rate("cpu");
+	ahb_clk_rate = ath79_get_sys_clk_rate("ahb");
+	ddr_clk_rate = ath79_get_sys_clk_rate("ddr");
+	ref_clk_rate = ath79_get_sys_clk_rate("ref");
+
+	pr_info("Clocks: CPU:%lu.%03luMHz, DDR:%lu.%03luMHz, AHB:%lu.%03luMHz, Ref:%lu.%03luMHz",
+		cpu_clk_rate / 1000000, (cpu_clk_rate / 1000) % 1000,
+		ddr_clk_rate / 1000000, (ddr_clk_rate / 1000) % 1000,
+		ahb_clk_rate / 1000000, (ahb_clk_rate / 1000) % 1000,
+		ref_clk_rate / 1000000, (ref_clk_rate / 1000) % 1000);
 
 	mips_hpt_frequency = cpu_clk_rate / 2;
 }
-- 
1.7.10
