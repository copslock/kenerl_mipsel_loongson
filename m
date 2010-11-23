Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 17:39:16 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:47846 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492072Ab0KWQjJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 17:39:09 +0100
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id E4A4F18059D5;
        Tue, 23 Nov 2010 17:39:08 +0100 (CET)
X-Auth-Info: 8BqNJvG9/TNXeSDMbWwqVFAhPoMGWnOhvUT+Hbb5w9k=
Received: from lancy.mylan.de (p4FF05130.dip.t-dialin.net [79.240.81.48])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 50F761C001E3;
        Tue, 23 Nov 2010 17:39:08 +0100 (CET)
Message-ID: <4CEBEE79.8040507@grandegger.com>
Date:   Tue, 23 Nov 2010 17:40:25 +0100
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Netdev@vger.kernel.org
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] au1000_eth: fix invalid address accessing the MAC enable
 register
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

"aup->enable" holds already the address pointing to the MAC enable
register. The bug was introduced by commit d0e7cb:

"au1000-eth: remove volatiles, switch to I/O accessors".

CC: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Wolfgang Grandegger <wg@denx.de>
Acked-by: Florian Fainelli <florian@openwrt.org>

---
 drivers/net/au1000_eth.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 43489f8..53eff9b 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -155,10 +155,10 @@ static void au1000_enable_mac(struct net_device *dev, int force_reset)
 	spin_lock_irqsave(&aup->lock, flags);
 
 	if (force_reset || (!aup->mac_enabled)) {
-		writel(MAC_EN_CLOCK_ENABLE, &aup->enable);
+		writel(MAC_EN_CLOCK_ENABLE, aup->enable);
 		au_sync_delay(2);
 		writel((MAC_EN_RESET0 | MAC_EN_RESET1 | MAC_EN_RESET2
-				| MAC_EN_CLOCK_ENABLE), &aup->enable);
+				| MAC_EN_CLOCK_ENABLE), aup->enable);
 		au_sync_delay(2);
 
 		aup->mac_enabled = 1;
@@ -503,9 +503,9 @@ static void au1000_reset_mac_unlocked(struct net_device *dev)
 
 	au1000_hard_stop(dev);
 
-	writel(MAC_EN_CLOCK_ENABLE, &aup->enable);
+	writel(MAC_EN_CLOCK_ENABLE, aup->enable);
 	au_sync_delay(2);
-	writel(0, &aup->enable);
+	writel(0, aup->enable);
 	au_sync_delay(2);
 
 	aup->tx_full = 0;
@@ -1119,7 +1119,7 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 	/* set a random MAC now in case platform_data doesn't provide one */
 	random_ether_addr(dev->dev_addr);
 
-	writel(0, &aup->enable);
+	writel(0, aup->enable);
 	aup->mac_enabled = 0;
 
 	pd = pdev->dev.platform_data;
-- 
1.7.2.3
