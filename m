Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:27:05 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.150]:15894 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024191AbZEaS0x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:26:53 +0100
Received: by ey-out-1920.google.com with SMTP id 4so303043eyg.54
        for <multiple recipients>; Sun, 31 May 2009 11:26:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aXO+DVH0rAmw2cvltHSfHOEIkfcBJ16h5MR6+/PQMgo=;
        b=o4GouU+5d2QuUTbpQu9fkRIBFagjugSLj0LnTE2D+r3kFZ8KDQUzZRFDK7pXt7o4ba
         va6j1s+WhRj3PXzMbX0J+/pmlrgyilzrB5uIQ43+di6bczqXHYN4npx2UD5swpy0VaPC
         ItFOpPNGHytjM/wXVa8KFRXy9FP8ELNSUbYJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=wuZ4F4AD8PnOkUc8x8G/WZYSAGzjaWRgznzxqRz6wqm7UlA/Us5UD2eqpULAMbzLqZ
         p7h7hEI8F/S/RZyyiOI6LpRcMfr+H1uknOgW4pAj27bhvAElwzB2rilsoy4GVmfR6KDV
         kkIpa10doYfLpHCbzi4D9k4ZY1AER6AcUHPXM=
Received: by 10.210.11.17 with SMTP id 17mr3017977ebk.59.1243794413068;
        Sun, 31 May 2009 11:26:53 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 7sm6220852eyg.17.2009.05.31.11.26.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:26:52 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:26:50 +0200
Subject: [PATCH 03/10] bcm63xx: add new BCM6358-based board definitions
MIME-Version: 1.0
X-UID:	135
X-Length: 2784
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312026.50533.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds new BCM6358-based board on which
OpenWrt users have goten this kernel codebase running.
New boards are:
- 96358vw
- 96358vw2
- Pirelli/Alice AGPFS0

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 486fd53..7b93fb8 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -185,6 +185,30 @@ static struct board_info __initdata board_96348gw_a = {
  * known 6358 boards
  */
 #ifdef CONFIG_BCM63XX_CPU_6358
+static struct board_info __initdata board_96358vw = {
+	.name				= "96358VW",
+	.expected_cpu_id		= 0x6358,
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
 static struct board_info __initdata board_96358vw2 = {
 	.name				= "96358VW2",
 	.expected_cpu_id		= 0x6358,
@@ -208,6 +232,28 @@ static struct board_info __initdata board_96358vw2 = {
 	.has_pccard = 1,
 	.has_ehci0 = 1,
 };
+
+static struct board_info __initdata board_AGPFS0 = {
+	.name                           = "AGPF-S0",
+	.expected_cpu_id                = 0x6358,
+
+	.has_enet0                      = 1,
+	.has_enet1                      = 1,
+	.has_pci                        = 1,
+
+	.enet0 = {
+		.has_phy                = 1,
+		.use_internal_phy       = 1,
+	},
+
+	.enet1 = {
+		.force_speed_100        = 1,
+		.force_duplex_full      = 1,
+	},
+
+	.has_ohci0 = 1,
+	.has_ehci0 = 1,
+};
 #endif
 
 /*
@@ -225,7 +271,9 @@ static const struct board_info __initdata *bcm963xx_boards[] = {
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6358
+	&board_96358vw,
 	&board_96358vw2,
+	&board_AGPFS0,
 #endif
 };
 
