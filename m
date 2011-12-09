Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 20:01:58 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59802 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903739Ab1LITBy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 20:01:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 1C2AB35E2DB;
        Fri,  9 Dec 2011 20:01:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fQ3QzXfAI9Xi; Fri,  9 Dec 2011 20:01:53 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id AED03360DCA;
        Fri,  9 Dec 2011 20:01:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     Matt Mackall <mpm@selenic.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/5] MIPS: BCM63XX: fix BCM6368 IPSec clock bit
Date:   Fri,  9 Dec 2011 20:01:06 +0100
Message-Id: <1323457270-16330-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1323457270-16330-1-git-send-email-florian@openwrt.org>
References: <1323457270-16330-1-git-send-email-florian@openwrt.org>
X-archive-position: 32070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7985

The IPsec clock bit is 18 and not 17.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 94d4faa..fdcd78c 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -99,7 +99,7 @@
 #define CKCTL_6368_USBH_CLK_EN		(1 << 15)
 #define CKCTL_6368_DISABLE_GLESS_EN	(1 << 16)
 #define CKCTL_6368_NAND_CLK_EN		(1 << 17)
-#define CKCTL_6368_IPSEC_CLK_EN		(1 << 17)
+#define CKCTL_6368_IPSEC_CLK_EN		(1 << 18)
 
 #define CKCTL_6368_ALL_SAFE_EN		(CKCTL_6368_SWPKT_USB_EN |	\
 					CKCTL_6368_SWPKT_SAR_EN |	\
-- 
1.7.5.4
