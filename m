Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:26:00 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57827 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014492AbcADTYkMDXkG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:24:40 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id D2CC8280520;
        Mon,  4 Jan 2016 20:23:57 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:23:57 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 7/8] MIPS: ralink: add a few missing clocks
Date:   Mon,  4 Jan 2016 20:24:00 +0100
Message-Id: <1451935441-40803-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
References: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50873
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |    3 +++
 arch/mips/ralink/rt305x.c |    1 +
 arch/mips/ralink/rt3883.c |    1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index da01e1f..0d3d1a9 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -456,7 +456,10 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000100.timer", periph_rate);
 	ralink_clk_add("10000120.watchdog", periph_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
+	ralink_clk_add("10000b40.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", periph_rate);
+	ralink_clk_add("10000d00.uart1", periph_rate);
+	ralink_clk_add("10000e00.uart2", periph_rate);
 	ralink_clk_add("10180000.wmac", xtal_rate);
 
 	if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 9e45725..d7c4ba4 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -201,6 +201,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("cpu", cpu_rate);
 	ralink_clk_add("sys", sys_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
+	ralink_clk_add("10000b40.spi", sys_rate);
 	ralink_clk_add("10000100.timer", wdt_rate);
 	ralink_clk_add("10000120.watchdog", wdt_rate);
 	ralink_clk_add("10000500.uart", uart_rate);
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index 582995a..fafec94 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -109,6 +109,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000120.watchdog", sys_rate);
 	ralink_clk_add("10000500.uart", 40000000);
 	ralink_clk_add("10000b00.spi", sys_rate);
+	ralink_clk_add("10000b40.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", 40000000);
 	ralink_clk_add("10100000.ethernet", sys_rate);
 	ralink_clk_add("10180000.wmac", 40000000);
-- 
1.7.10.4
