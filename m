Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 10:15:29 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:51152 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903699Ab1KUJOy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 10:14:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 1D2613B1D95;
        Mon, 21 Nov 2011 10:14:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UgEp76poNJhk; Mon, 21 Nov 2011 10:14:53 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id BC7AD3B1C5A;
        Mon, 21 Nov 2011 10:14:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/9] MIPS: BCM63XX: add BCM6368 SPI clock mask
Date:   Mon, 21 Nov 2011 10:14:15 +0100
Message-Id: <1321866861-14340-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1321866861-14340-1-git-send-email-florian@openwrt.org>
References: <1321866861-14340-1-git-send-email-florian@openwrt.org>
X-archive-position: 31841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17031

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/clk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 9d57c71..9b548f8 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -181,9 +181,11 @@ static void spi_set(struct clk *clk, int enable)
 		mask = CKCTL_6338_SPI_EN;
 	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_SPI_EN;
-	else
-		/* BCMCPU_IS_6358 */
+	else if (BCMCPU_IS_6358())
 		mask = CKCTL_6358_SPI_EN;
+	else
+		/* BCMCPU_IS_6368 */
+		mask = CKCTL_6368_SPI_CLK_EN;
 	bcm_hwclock_set(mask, enable);
 }
 
-- 
1.7.5.4
