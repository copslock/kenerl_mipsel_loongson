Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 00:19:06 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:35026 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993919AbdAQXPczHKzA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 00:15:32 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 04/13] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
Date:   Wed, 18 Jan 2017 00:14:12 +0100
Message-Id: <20170117231421.16310-5-paul@crapouillou.net>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1484694901; bh=XWzli+8WeAfymS0gkY90a6Z699yhYOc65WkVPKgr7AY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sJAYx8vXl6D/iSGSqCjZbzxDKfRXO4H2t1Kc80SZSVZ3obLZx7n/iH+2f7mUNrl9JSmq83PK9IsFQNdk/ylSnoOzuqULD9YOrolhLjCizCGur3LKzajYTOoU0vi21P/z8/fcQt4PLzAj5fANJeGjBSMXW9AW2Ny3ROp9+Tt5ktI=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56379
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

There is a pinctrl driver for each of the Ingenic SoCs supported by the
upstream Linux kernel. In order to switch away from the old GPIO
platform code, we now enable the pinctrl drivers by default for the
Ingenic SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde43d34..fc720e37661e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -359,6 +359,7 @@ config MACH_INGENIC
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
+	select PINCTRL
 	select GPIOLIB
 	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
-- 
2.11.0
