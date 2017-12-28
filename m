Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 17:30:52 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:49518 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990508AbdL1Q34eLeAB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 17:29:56 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/7] watchdog: JZ4740: Disable clock after stopping counter
Date:   Thu, 28 Dec 2017 17:29:33 +0100
Message-Id: <20171228162939.3928-2-paul@crapouillou.net>
In-Reply-To: <20171228162939.3928-1-paul@crapouillou.net>
References: <20171228162939.3928-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514478594; bh=5C82rjmwRcK7FbIUcmalE5tpIxd1N9nQHu+3j3pMiUo=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t5lXetO7VBY0o71Mdx5YRoBbTowdbOLd0vkjGH9mlPurW+vIArs8FpYXWFNIPAYDBDtQKk6kWfNo5opv4+J0Zf69zeUudTcuGoK/lhVre25Cgel5Wr5eJiyEqW2Rc8Lcr1ZM6lWdTB2/bkZsDZqimogvc3J1uflaatohPN4IVYw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61668
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
---
 drivers/watchdog/jz4740_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
