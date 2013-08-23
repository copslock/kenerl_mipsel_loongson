Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 08:32:47 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41449 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822304Ab3HWGbtZcvRV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Aug 2013 08:31:49 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id DDC2728061F;
        Fri, 23 Aug 2013 08:31:19 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 23 Aug 2013 08:31:19 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 2/3] MIPS: ralink: mt7620: add wdt clock definition
Date:   Fri, 23 Aug 2013 08:31:31 +0200
Message-Id: <1377239492-10802-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1377239492-10802-1-git-send-email-juhosg@openwrt.org>
References: <1377239492-10802-1-git-send-email-juhosg@openwrt.org>
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37654
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

From: John Crispin <blogic@openwrt.org>

The watchdog driver of the SoC uses the clk API to
get the clock associated with the watchdog device.
However the MT7620 specific setup code does not
register a clock for the watchdog device yet which
leads to the following error:

  rt2880_wdt: probe of 10000120.watchdog failed with error -2

Register a clock device for the watchdog in order to
avoid the error and make the watchdog usable.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since v1:
  - rebase against the mips-for-linux-next branch of the
    upstream-sfr.git tree

This makes the following patch obsolete:
  https://patchwork.linux-mips.org/patch/5673/
---
 arch/mips/ralink/mt7620.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 8dd3b0d..6c37c9d 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -316,6 +316,7 @@ void __init ralink_clk_init(void)
 
 	ralink_clk_add("cpu", cpu_rate);
 	ralink_clk_add("10000100.timer", periph_rate);
+	ralink_clk_add("10000120.watchdog", periph_rate);
 	ralink_clk_add("10000500.uart", periph_rate);
 	ralink_clk_add("10000c00.uartlite", periph_rate);
 }
-- 
1.7.10
