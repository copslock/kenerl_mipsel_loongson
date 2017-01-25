Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 19:56:34 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:56412 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993954AbdAYSxEI09tw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 19:53:04 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 05/14] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
Date:   Wed, 25 Jan 2017 19:51:58 +0100
Message-Id: <20170125185207.23902-6-paul@crapouillou.net>
In-Reply-To: <20170125185207.23902-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485370353; bh=6DjtrX5oIUH7fNBz7JQYt2S++GKE4PBwSGzzr7abHzc=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MkI41Y7bAYD98jJykVCrKzBD7rziaSqGSFIZsUQ87OunQEpgUS1KdWgp8Dr/Y3hFONS4/F0HLGaY21X+gJxZTa9VFAOD/51y2PddCSO+NFszx815pJk79lu8/D43ZQ6zqRItYmgVgBB1ExCjF/BvHtRj3nSE92WUGHatV3RGOOU=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56502
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

v2: No changes
v3: No changes

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
