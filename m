Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:25:44 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55315 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865311Ab3HHLY7c5xTG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 13:24:59 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/5] MIPS: ralink: mt7620: add wdt clock definition
Date:   Thu,  8 Aug 2013 13:17:50 +0200
Message-Id: <1375960672-32619-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375960672-32619-1-git-send-email-blogic@openwrt.org>
References: <1375960672-32619-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37465
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

The definition of the wdt clock is missing.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/mt7620.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 769296f..7b360a8 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -166,6 +166,7 @@ void __init ralink_clk_init(void)
 
 	ralink_clk_add("cpu", cpu_rate);
 	ralink_clk_add("10000100.timer", 40000000);
+	ralink_clk_add("10000120.watchdog", 40000000);
 	ralink_clk_add("10000500.uart", 40000000);
 	ralink_clk_add("10000b00.spi", 40000000);
 	ralink_clk_add("10000c00.uartlite", 40000000);
-- 
1.7.10.4
