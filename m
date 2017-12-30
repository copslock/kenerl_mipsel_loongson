Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 14:52:28 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:36994 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990424AbdL3NvdI5-r0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 14:51:33 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/8] watchdog: JZ4740: Register a restart handler
Date:   Sat, 30 Dec 2017 14:51:03 +0100
Message-Id: <20171230135108.6834-3-paul@crapouillou.net>
In-Reply-To: <20171230135108.6834-1-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514641892; bh=xFTl+PPT1J+nrI4EFdJDd2nP8as5Ln5J2DmIiC9ICd4=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZArGdL0MQtrtrwQIfkTJosyZ0LL+JP5Lqslxg3g0GdBwhLb0e6HEPWNXSgjMi+qRRl4QpxS7Xxm7FnwIZ6fxP3XyMlWm+F5QDlHLD3W3MNyXM08KGfXjkFX+HHgOko+rt/RTB3+cDU/lEjxpA7IYqKdkZTX2U5dMCPI9d7zdp+c=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61780
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change

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
