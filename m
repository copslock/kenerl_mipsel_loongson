Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:13:35 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59623 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904026Ab2AaOLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:11:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id E8191358744;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9r97P04Acu1c; Tue, 31 Jan 2012 15:11:10 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 1DC26345024;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/9 v3] MIPS: BCM63XX: add BCM6368 SPI clock mask
Date:   Tue, 31 Jan 2012 15:10:42 +0100
Message-Id: <1328019048-5892-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019048-5892-1-git-send-email-florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
X-archive-position: 32354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v1 and v2

 arch/mips/bcm63xx/clk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 8d2ea22..be49b9a 100644
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
+		mask = CKCTL_6368_SPI_EN;
 	bcm_hwclock_set(mask, enable);
 }
 
-- 
1.7.5.4
