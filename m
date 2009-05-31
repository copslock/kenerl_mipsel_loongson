Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:26:41 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:47245 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024207AbZEaS02 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:26:28 +0100
Received: by ewy19 with SMTP id 19so7632519ewy.0
        for <multiple recipients>; Sun, 31 May 2009 11:26:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BVpWUEDCz2LZ+pWCHhA5HODJK3NBQI1CU+Im0WvIvHU=;
        b=IQR+yrxbTxEP1n9WYFmvvI6p27QhDq5Y8dvCffu/EzTnFHJO8TfZvD6VIUIwvENua1
         Uu+eeJkwJ+K302Dm7DWZE+S9s9sWYw2o5Lgq3cI4U3HLYLCsHmkzV9qgpg0/s1TLyyIV
         C0dOTgwcRu72lFg26JJJ/rE+mxpamuusA0zqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=ObFhtHHymO758T2pDEHtRxfa7Xrwb347dFHQPS9VqGNHwu8qpT4yp3zRUgzAunF7Ah
         uQ1P/XGR89rTmcj7p6pPTXozlJgEsIy1RFd1apsN/BcVvjwyVa1ez0vjiIZqH/ryJlPV
         5IYq2XSq0o7t7f3SwAl+fEy6PloSaUTySuCLo=
Received: by 10.210.119.5 with SMTP id r5mr1911568ebc.1.1243794382426;
        Sun, 31 May 2009 11:26:22 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm5225660eyf.8.2009.05.31.11.26.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:26:22 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:26:19 +0200
Subject: [PATCH 02/10] bcm63xx: add new BCM6348-based board definitions
MIME-Version: 1.0
X-UID:	134
X-Length: 4472
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312026.19705.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds new board definitions on which the OpenWrt
users including myself have goten working. New boards are:
- 96348r
- 96348gw
- 96348gw-10
- 96348gw-11
- 96348gw-a
- Sagem F@2404
- Davolink DV201AMR

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 3e2b47a..486fd53 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -4,6 +4,7 @@
  * for more details.
  *
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
  */
 
 #include <linux/init.h>
@@ -50,17 +51,133 @@ static struct board_info __initdata board_96348r = {
 	},
 };
 
+static struct board_info __initdata board_96348gw_10 = { 
+	.name				= "96348GW-10",
+	.expected_cpu_id		= 0x6348,
+	
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1, 
+	
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+	
+	.has_ohci0			= 1,
+	.has_pccard			= 1,
+	.has_ehci0			= 1,
+}; 
+
+static struct board_info __initdata board_96348gw_11 = {
+	.name				= "96348GW-11",
+	.expected_cpu_id		= 0x6348,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+
+	.has_ohci0 = 1,
+	.has_pccard = 1,
+	.has_ehci0 = 1,
+};
+
 static struct board_info __initdata board_96348gw = {
 	.name				= "96348GW",
 	.expected_cpu_id		= 0x6348,
 
 	.has_enet0			= 1,
+	.has_enet1			= 1,
 	.has_pci			= 1,
 
 	.enet0 = {
 		.has_phy		= 1,
 		.use_internal_phy	= 1,
 	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+	.has_ohci0 = 1,
+};
+
+static struct board_info __initdata board_FAST2404 = {
+        .name                           = "F@ST2404",
+        .expected_cpu_id                = 0x6348,
+
+        .has_enet0                      = 1,
+        .has_enet1                      = 1,
+        .has_pci                        = 1,
+
+        .enet0 = {
+                .has_phy                = 1,
+                .use_internal_phy       = 1,
+        },
+
+        .enet1 = {
+                .force_speed_100        = 1,
+                .force_duplex_full      = 1,
+        },
+
+
+        .has_ohci0 = 1,
+        .has_pccard = 1,
+        .has_ehci0 = 1,
+};
+
+static struct board_info __initdata board_DV201AMR = {
+	.name				= "DV201AMR",
+	.expected_cpu_id		= 0x6348,
+
+	.has_pci			= 1,
+	.has_ohci0			= 1,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+};
+
+static struct board_info __initdata board_96348gw_a = {
+	.name				= "96348GW-A",
+	.expected_cpu_id		= 0x6348,
+
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+	.has_ohci0 = 1,
 };
 #endif
 
@@ -100,6 +217,11 @@ static const struct board_info __initdata *bcm963xx_boards[] = {
 #ifdef CONFIG_BCM63XX_CPU_6348
 	&board_96348r,
 	&board_96348gw,
+	&board_96348gw_10,
+	&board_96348gw_11,
+	&board_FAST2404,
+	&board_DV201AMR,
+	&board_96348gw_a,
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6358
