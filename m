Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 14:52:02 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:36546 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990421AbdL3Nvc0fJX0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 14:51:32 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/8] watchdog: JZ4740: Disable clock after stopping counter
Date:   Sat, 30 Dec 2017 14:51:01 +0100
Message-Id: <20171230135108.6834-1-paul@crapouillou.net>
In-Reply-To: <20171228162939.3928-2-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514641890; bh=DfNLGtgkVAdoBDPJaV/O/b71c+4GokNl7f9avjKmWLw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UazRKEfPsr1nlFJTTBC9LEVaMOue+gsltBRG+PQrlDFEJkg6QB2MOL+3Tl5ePpsSEIlHYu8hDUR3OhIKGKPTW1mpDnONN7QZ0GQlpDLPYK0NzMIBc87CZaGgNKiK6JSQFnLkDJ6vcAcSPqgmkIg7lWBzqyr4GWQWaYFwL8+fnc4=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Previously, the clock was disabled first, which makes the watchdog
component insensitive to register writes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 v2: No change

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 20627f22baf6..6955deb100ef 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -124,8 +124,8 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	jz4740_timer_disable_watchdog();
 	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	jz4740_timer_disable_watchdog();
 
 	return 0;
 }
-- 
2.11.0
