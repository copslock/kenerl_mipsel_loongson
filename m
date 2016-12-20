Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2016 19:13:29 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44282 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993304AbcLTSMhuNL02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Dec 2016 19:12:37 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 2/7] arch: mips: ralink: add missing I2C and I2S clocks
Date:   Tue, 20 Dec 2016 19:12:41 +0100
Message-Id: <1482257566-61035-3-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1482257566-61035-1-git-send-email-john@phrozen.org>
References: <1482257566-61035-1-git-send-email-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

This patch adds two additional clocks required by the audio interface of
the SoCs.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ralink/mt7620.c |    5 +++++
 arch/mips/ralink/rt288x.c |    1 +
 arch/mips/ralink/rt305x.c |    2 ++
 arch/mips/ralink/rt3883.c |    2 ++
 4 files changed, 10 insertions(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 3c7c9bf..6f0fdfd 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -509,6 +509,7 @@ void __init ralink_clk_init(void)
 	unsigned long sys_rate;
 	unsigned long dram_rate;
 	unsigned long periph_rate;
+	unsigned long pcmi2s_rate;
 
 	xtal_rate = mt7620_get_xtal_rate();
 
@@ -523,6 +524,7 @@ void __init ralink_clk_init(void)
 			cpu_rate = MHZ(575);
 		dram_rate = sys_rate = cpu_rate / 3;
 		periph_rate = MHZ(40);
+		pcmi2s_rate = MHZ(480);
 
 		ralink_clk_add("10000d00.uartlite", periph_rate);
 		ralink_clk_add("10000e00.uartlite", periph_rate);
@@ -534,6 +536,7 @@ void __init ralink_clk_init(void)
 		dram_rate = mt7620_get_dram_rate(pll_rate);
 		sys_rate = mt7620_get_sys_rate(cpu_rate);
 		periph_rate = mt7620_get_periph_rate(xtal_rate);
+		pcmi2s_rate = periph_rate;
 
 		pr_debug(RFMT("XTAL") RFMT("CPU_PLL") RFMT("PLL"),
 			 RINT(xtal_rate), RFRAC(xtal_rate),
@@ -555,6 +558,8 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("cpu", cpu_rate);
 	ralink_clk_add("10000100.timer", periph_rate);
 	ralink_clk_add("10000120.watchdog", periph_rate);
+	ralink_clk_add("10000900.i2c", periph_rate);
+	ralink_clk_add("10000a00.i2s", pcmi2s_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000b40.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", periph_rate);
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 285796e..eeabd51 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -75,6 +75,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("300100.timer", cpu_rate / 2);
 	ralink_clk_add("300120.watchdog", cpu_rate / 2);
 	ralink_clk_add("300500.uart", cpu_rate / 2);
+	ralink_clk_add("300900.i2c", cpu_rate / 2);
 	ralink_clk_add("300c00.uartlite", cpu_rate / 2);
 	ralink_clk_add("400000.ethernet", cpu_rate / 2);
 	ralink_clk_add("480000.wmac", wmac_rate);
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index c8a28c4b..f0b5ac4 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -200,6 +200,8 @@ void __init ralink_clk_init(void)
 
 	ralink_clk_add("cpu", cpu_rate);
 	ralink_clk_add("sys", sys_rate);
+	ralink_clk_add("10000900.i2c", uart_rate);
+	ralink_clk_add("10000a00.i2s", uart_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000b40.spi", sys_rate);
 	ralink_clk_add("10000100.timer", wdt_rate);
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index 4cef916..141c597 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -108,6 +108,8 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000100.timer", sys_rate);
 	ralink_clk_add("10000120.watchdog", sys_rate);
 	ralink_clk_add("10000500.uart", 40000000);
+	ralink_clk_add("10000900.i2c", 40000000);
+	ralink_clk_add("10000a00.i2s", 40000000);
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000b40.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", 40000000);
-- 
1.7.10.4
