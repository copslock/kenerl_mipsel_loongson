Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 09:34:18 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55485 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825888Ab3DLHcC4KsZQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 09:32:02 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 02/16] MIPS: ralink: fix RT305x clock setup
Date:   Fri, 12 Apr 2013 09:27:29 +0200
Message-Id: <1365751663-5725-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36089
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

Add a few missing clocks.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/rt305x.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 0a4bbdc..64a0336 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -123,7 +123,8 @@ struct ralink_pinmux gpio_pinmux = {
 
 void __init ralink_clk_init(void)
 {
-	unsigned long cpu_rate, sys_rate, wdt_rate, uart_rate;
+	unsigned long cpu_rate, sys_rate, wdt_rate,
+			uart_rate, wmac_rate = 40000000;
 	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
 
 	if (soc_is_rt305x() || soc_is_rt3350()) {
@@ -176,11 +177,21 @@ void __init ralink_clk_init(void)
 		BUG();
 	}
 
+	if (soc_is_rt3352() || soc_is_rt5350()) {
+		u32 val = rt_sysc_r32(RT3352_SYSC_REG_SYSCFG0);
+
+		if (!(val & RT3352_CLKCFG0_XTAL_SEL))
+			wmac_rate = 20000000;
+	}
+
 	ralink_clk_add("cpu", cpu_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000100.timer", wdt_rate);
+	ralink_clk_add("10000120.watchdog", wdt_rate);
 	ralink_clk_add("10000500.uart", uart_rate);
 	ralink_clk_add("10000c00.uartlite", uart_rate);
+	ralink_clk_add("10100000.ethernet", sys_rate);
+	ralink_clk_add("wmac@10180000", wmac_rate);
 }
 
 void __init ralink_of_remap(void)
-- 
1.7.10.4
