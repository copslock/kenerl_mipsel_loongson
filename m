Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:55:54 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37286 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861343AbaGHOx5G8DCL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:53:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A97AB28B44E;
        Tue,  8 Jul 2014 16:51:52 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5BF7428B95A;
        Tue,  8 Jul 2014 16:51:30 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 4/8] MIPS: BCM63XX: remove !RUNTIME_DETECT code from gpio code
Date:   Tue,  8 Jul 2014 16:53:20 +0200
Message-Id: <1404831204-30659-5-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/gpio.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index a6c2135..468bc7b 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -18,19 +18,6 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 
-#ifndef BCMCPU_RUNTIME_DETECT
-#define gpio_out_low_reg	GPIO_DATA_LO_REG
-#ifdef CONFIG_BCM63XX_CPU_6345
-#ifdef gpio_out_low_reg
-#undef gpio_out_low_reg
-#define gpio_out_low_reg	GPIO_DATA_LO_REG_6345
-#endif /* gpio_out_low_reg */
-#endif /* CONFIG_BCM63XX_CPU_6345 */
-
-static inline void bcm63xx_gpio_out_low_reg_init(void)
-{
-}
-#else /* ! BCMCPU_RUNTIME_DETECT */
 static u32 gpio_out_low_reg;
 
 static void bcm63xx_gpio_out_low_reg_init(void)
@@ -44,7 +31,6 @@ static void bcm63xx_gpio_out_low_reg_init(void)
 		break;
 	}
 }
-#endif /* ! BCMCPU_RUNTIME_DETECT */
 
 static DEFINE_SPINLOCK(bcm63xx_gpio_lock);
 static u32 gpio_out_low, gpio_out_high;
-- 
2.0.0
