Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 19:19:35 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:46968 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994710AbeHURRIhdCBD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 19:17:08 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 11/24] watchdog: jz4740: Drop dependency on MACH_JZ47xx, use COMPILE_TEST
Date:   Tue, 21 Aug 2018 19:16:22 +0200
Message-Id: <20180821171635.22740-12-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871827; bh=mkES4HvHNmq/RQeQEUAvdqQgOvdU/injB2ZI+MGVpdY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DOsnB50zQffCwaL2+ULRxbEGqaOc6i5eToxxVn11a4e3pnAAvvwPbu4n8cx6H48DG6/7vNDDWfF1kX6CHKfyQCNhcVah295N2ncjyKqP7+nJXIdAthhWwGD579R/MStoDXy21PGR8wQAmX7HZuIn0geXve+/n490Cx85GY0klPA=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65695
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

Depending on MACH_JZ47xx prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

On other architectures, this driver can still be built, thanks to
COMPILE_TEST. This is used by automated tools to find bugs, for
instance.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Notes:
     v5: New patch
    
     v6: No change
    
     v7: No change

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 834222abbbdb..13a46cfa69b0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1475,7 +1475,7 @@ config INDYDOG
 
 config JZ4740_WDT
 	tristate "Ingenic jz4740 SoC hardware watchdog"
-	depends on MACH_JZ4740 || MACH_JZ4780
+	depends on MIPS || COMPILE_TEST
 	depends on COMMON_CLK
 	select WATCHDOG_CORE
 	select INGENIC_TIMER
-- 
2.11.0
