Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 19:35:05 +0200 (CEST)
Received: from xavier.telenet-ops.be ([195.130.132.52]:39067 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992882AbcHRRefE-wF- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 19:34:35 +0200
Received: from ayla.of.borg ([84.193.137.253])
        by xavier.telenet-ops.be with bizsmtp
        id Yhaa1t0045UCtCs01haauv; Thu, 18 Aug 2016 19:34:34 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1baRD8-0002hU-4a; Thu, 18 Aug 2016 19:34:34 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1baRDA-0007zq-6L; Thu, 18 Aug 2016 19:34:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] watchdog: txx9wdt: Add missing clock (un)prepare calls for CCF
Date:   Thu, 18 Aug 2016 19:34:26 +0200
Message-Id: <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

While the custom minimal TXx9 clock implementation doesn't need or use
clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
they are mandatory when using the Common Clock Framework.

Hence add them, to prepare for the advent of CCF.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Tested on RBTX4927.
---
 drivers/watchdog/txx9wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index c2da880292bc2f32..6f7a9deb27d05d25 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -112,7 +112,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 		txx9_imclk = NULL;
 		goto exit;
 	}
-	ret = clk_enable(txx9_imclk);
+	ret = clk_prepare_enable(txx9_imclk);
 	if (ret) {
 		clk_put(txx9_imclk);
 		txx9_imclk = NULL;
@@ -144,7 +144,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 	return 0;
 exit:
 	if (txx9_imclk) {
-		clk_disable(txx9_imclk);
+		clk_disable_unprepare(txx9_imclk);
 		clk_put(txx9_imclk);
 	}
 	return ret;
@@ -153,7 +153,7 @@ exit:
 static int __exit txx9wdt_remove(struct platform_device *dev)
 {
 	watchdog_unregister_device(&txx9wdt);
-	clk_disable(txx9_imclk);
+	clk_disable_unprepare(txx9_imclk);
 	clk_put(txx9_imclk);
 	return 0;
 }
-- 
1.9.1
