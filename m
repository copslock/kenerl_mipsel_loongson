Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Aug 2013 10:42:38 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55245 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815989Ab3H1Ilxbig7G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Aug 2013 10:41:53 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id ADD4728080B;
        Wed, 28 Aug 2013 10:41:18 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 28 Aug 2013 10:41:18 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 3/6] MIPS: ath79: use a helper function to get system clock rates
Date:   Wed, 28 Aug 2013 10:41:44 +0200
Message-Id: <1377679307-429-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
References: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37698
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

The ath79 platform uses similar code to get the
rate of various clocks during init. Separate the
similar code into a new helper function and use
that to avoid code duplication.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/clock.c      |   16 ++++++++++++++++
 arch/mips/ath79/common.h     |    2 ++
 arch/mips/ath79/dev-common.c |   10 ++++------
 arch/mips/ath79/setup.c      |    8 +++-----
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 4378d63..c8351b4 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -400,6 +400,22 @@ void __init ath79_clocks_init(void)
 		(ath79_ref_clk.rate / 1000) % 1000);
 }
 
+unsigned long __init
+ath79_get_sys_clk_rate(const char *id)
+{
+	struct clk *clk;
+	unsigned long rate;
+
+	clk = clk_get(NULL, id);
+	if (IS_ERR(clk))
+		panic("unable to get %s clock, err=%d", id, (int) PTR_ERR(clk));
+
+	rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	return rate;
+}
+
 /*
  * Linux clock API
  */
diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
index 561906c..648d2da 100644
--- a/arch/mips/ath79/common.h
+++ b/arch/mips/ath79/common.h
@@ -21,6 +21,8 @@
 #define ATH79_MEM_SIZE_MAX	(128 * 1024 * 1024)
 
 void ath79_clocks_init(void);
+unsigned long ath79_get_sys_clk_rate(const char *id);
+
 void ath79_ddr_wb_flush(unsigned int reg);
 
 void ath79_gpio_function_enable(u32 mask);
diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index a3a2741..c3b04c9 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -81,21 +81,19 @@ static struct platform_device ar933x_uart_device = {
 
 void __init ath79_register_uart(void)
 {
-	struct clk *clk;
+	unsigned long uart_clk_rate;
 
-	clk = clk_get(NULL, "uart");
-	if (IS_ERR(clk))
-		panic("unable to get UART clock, err=%ld", PTR_ERR(clk));
+	uart_clk_rate = ath79_get_sys_clk_rate("uart");
 
 	if (soc_is_ar71xx() ||
 	    soc_is_ar724x() ||
 	    soc_is_ar913x() ||
 	    soc_is_ar934x() ||
 	    soc_is_qca955x()) {
-		ath79_uart_data[0].uartclk = clk_get_rate(clk);
+		ath79_uart_data[0].uartclk = uart_clk_rate;
 		platform_device_register(&ath79_uart_device);
 	} else if (soc_is_ar933x()) {
-		ar933x_uart_data.uartclk = clk_get_rate(clk);
+		ar933x_uart_data.uartclk = uart_clk_rate;
 		platform_device_register(&ar933x_uart_device);
 	} else {
 		BUG();
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 80f4ecd..e3b8345 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -209,13 +209,11 @@ void __init plat_mem_setup(void)
 
 void __init plat_time_init(void)
 {
-	struct clk *clk;
+	unsigned long cpu_clk_rate;
 
-	clk = clk_get(NULL, "cpu");
-	if (IS_ERR(clk))
-		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
+	cpu_clk_rate = ath79_get_sys_clk_rate("cpu");
 
-	mips_hpt_frequency = clk_get_rate(clk) / 2;
+	mips_hpt_frequency = cpu_clk_rate / 2;
 }
 
 static int __init ath79_setup(void)
-- 
1.7.10
