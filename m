Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:15:42 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59754 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904034Ab2AaOMs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:12:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 2E3CD35F3C7;
        Tue, 31 Jan 2012 15:12:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0xgFGtqluBeS; Tue, 31 Jan 2012 15:12:47 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id AB2B1326BFA;
        Tue, 31 Jan 2012 15:12:47 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/5 v2] MIPS: BCM63XX: fix BCM6368 IPSec clock bit
Date:   Tue, 31 Jan 2012 15:12:21 +0100
Message-Id: <1328019145-5946-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019145-5946-1-git-send-email-florian@openwrt.org>
References: <1328019145-5946-1-git-send-email-florian@openwrt.org>
X-archive-position: 32359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The IPsec clock bit is 18 and not 17.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- rebased against "MIPS: BCM63XX: misc cleanup"

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index c21aa34..be107e9 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -99,7 +99,7 @@
 #define CKCTL_6368_USBH_EN		(1 << 15)
 #define CKCTL_6368_DISABLE_GLESS_EN	(1 << 16)
 #define CKCTL_6368_NAND_EN		(1 << 17)
-#define CKCTL_6368_IPSEC_EN		(1 << 17)
+#define CKCTL_6368_IPSEC_EN		(1 << 18)
 
 #define CKCTL_6368_ALL_SAFE_EN		(CKCTL_6368_SWPKT_USB_EN |	\
 					CKCTL_6368_SWPKT_SAR_EN |	\
-- 
1.7.5.4
