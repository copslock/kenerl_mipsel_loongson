Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2012 11:32:45 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:45014 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903269Ab2IRJcj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2012 11:32:39 +0200
Received: by bkcji2 with SMTP id ji2so3084709bkc.36
        for <multiple recipients>; Tue, 18 Sep 2012 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xOJ01fU+gbK14LkFXPDF1yr2ooHTvaimcs86LIDLOCU=;
        b=Ft997d4YXubzpMl6mPyLv5Er0idbAqxWuDjVrgRfXP3x3AD/qUDx+Huub0ACug5RwX
         sjYNOnxBzhqHQhdzg+JzzwT+phnqSZDCbIXTQy+Y8+WTxYQNbfPL7SAPgaFGp5u8SQ58
         4Dy1sXPz4r6QXcHD+SbTD+yRO2vYZhl1WmV0u1BmTO9vY2S1tE3qHm8mNGAQ34ReSHC9
         mjJ28IMcuQbo7tHnSuGKsmNznhdIAA6c2LSdv9EZkc3RE1cMCjaSCMelEYEO6UOAm5AZ
         A7XxhVQRPwQJOlprKN7eJWNFYF0WsZeHA7Te93wnl0XX/rnh5HY6edKCFlDWl2j8ZN9L
         KUNg==
Received: by 10.204.152.146 with SMTP id g18mr1617386bkw.73.1347960754297;
        Tue, 18 Sep 2012 02:32:34 -0700 (PDT)
Received: from ixxyvirt.lan (dslb-088-073-033-117.pools.arcor-ip.net. [88.73.33.117])
        by mx.google.com with ESMTPS id a17sm4084298bkw.5.2012.09.18.02.32.32
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Sep 2012 02:32:33 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: BCM63XX: properly handle mac address octet overflow
Date:   Tue, 18 Sep 2012 11:32:08 +0200
Message-Id: <1347960728-5884-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

While calculating the mac address the pointer for the current octet was
never reset back to the least significant one after being decremented
because of an octet overflow. This resulted in the code continuing to
increment at the current octet, potentially generating duplicate or
invalid mac addresses.

As a second issue the pointer was allowed to advance up to the most
significant octet, modifying the OUI, and potentially changing the type
of mac address.

Rewrite the code so it resets the pointer to the least significant
in each outer loop step, and bails out when the least significant octet
of the OUI is reached.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index ea4ea77..f0fcec6 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -720,7 +720,7 @@ const char *board_get_name(void)
  */
 static int board_get_mac_address(u8 *mac)
 {
-	u8 *p;
+	u8 *oui;
 	int count;
 
 	if (mac_addr_used >= nvram.mac_addr_count) {
@@ -729,21 +729,23 @@ static int board_get_mac_address(u8 *mac)
 	}
 
 	memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
-	p = mac + ETH_ALEN - 1;
+	oui = mac + ETH_ALEN/2 - 1;
 	count = mac_addr_used;
 
 	while (count--) {
+		p = mac + ETH_ALEN - 1;
+
 		do {
 			(*p)++;
 			if (*p != 0)
 				break;
 			p--;
-		} while (p != mac);
-	}
+		} while (p != oui);
 
-	if (p == mac) {
-		printk(KERN_ERR PFX "unable to fetch mac address\n");
-		return -ENODEV;
+		if (p == oui) {
+			printk(KERN_ERR PFX "unable to fetch mac address\n");
+			return -ENODEV;
+		}
 	}
 
 	mac_addr_used++;
-- 
1.7.10.4
