Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:38:43 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36946 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903700Ab2BQKdj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:39 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 6/9] MIPS: lantiq: convert gpio_stp driver to clkdev api
Date:   Fri, 17 Feb 2012 11:33:17 +0100
Message-Id: <1329474800-20979-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Update from old pmu_{dis,en}able() to ckldev api.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/gpio_stp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index e6b4809..c9bf38b 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/clk.h>
 
 #include <lantiq_soc.h>
 
@@ -80,6 +81,8 @@ static struct gpio_chip ltq_stp_chip = {
 
 static int ltq_stp_hw_init(void)
 {
+	struct clk *clk;
+
 	/* sane defaults */
 	ltq_stp_w32(0, LTQ_STP_AR);
 	ltq_stp_w32(0, LTQ_STP_CPU0);
@@ -105,7 +108,8 @@ static int ltq_stp_hw_init(void)
 	 */
 	ltq_stp_w32_mask(0, LTQ_STP_ADSL_SRC, LTQ_STP_CON0);
 
-	ltq_pmu_enable(PMU_LED);
+	clk = clk_get_sys("fpi", "stp");
+	clk_enable(clk);
 	return 0;
 }
 
-- 
1.7.7.1
