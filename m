Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 17:31:18 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:50036 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990510AbdL1Q34t2GAB (ORCPT
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
Subject: [PATCH 3/7] watchdog: JZ4740: Register a restart handler
Date:   Thu, 28 Dec 2017 17:29:35 +0100
Message-Id: <20171228162939.3928-4-paul@crapouillou.net>
In-Reply-To: <20171228162939.3928-1-paul@crapouillou.net>
References: <20171228162939.3928-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514478596; bh=p3a1wZGjHeErCUv5gAiL2C/mR1JjpbQD3QN+jbDvnls=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FHJxEJ7Cm5l3yDYWn/9/2VfU2bmmjbtVOfCHiKWbMc0QOyY+CuhvW5Yg1qY20rUXGEpeAHv04Pei5qcGkbZusgieXB9kUvNYnl4r4mpzfVgosehvE9ktds5njOfvpljyMSXKaR6y/Ia5EOuRnl/eyJdTxfk7hC9fsqFk1XW9xj4=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61669
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

The watchdog driver can restart the system by simply configuring the
hardware for a timeout of 0 seconds.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/jz4740_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 92d6ca8ceb49..fa7f49a3212c 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
+			      unsigned long action, void *data)
+{
+	wdt_dev->timeout = 0;
+	jz4740_wdt_start(wdt_dev);
+	return 0;
+}
+
 static const struct watchdog_info jz4740_wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 	.identity = "jz4740 Watchdog",
@@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
 	.stop = jz4740_wdt_stop,
 	.ping = jz4740_wdt_ping,
 	.set_timeout = jz4740_wdt_set_timeout,
+	.restart = jz4740_wdt_restart,
 };
 
 #ifdef CONFIG_OF
-- 
2.11.0
