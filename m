Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:48:51 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:52655 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492945AbZHGVrK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:47:10 +0200
Received: by mail-ew0-f216.google.com with SMTP id 12so2282279ewy.0
        for <multiple recipients>; Fri, 07 Aug 2009 14:47:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RjjUo1rC/zm9NLoUtt5P8Qr560gl1iAf7DlSLLkZ2aA=;
        b=tdK5BEcHWe1lh/CfwZMeij+3InPvzBVqlqBBhvmj28hfMioPd2vp3ZPUIS8uRPC+Bz
         b22lcn1TFteldgbJ4AvttsZs4jZveZE2hjhCZDvj/PJaPWJQouBk2cV1PeorgeQdjXAb
         Z57RVm1aGAcIKwtrjzix3KlW4g2HrXXNdfXJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=gbzqfTG07WDrkrtu4qz1ZqADWfmBhb1waaoi5GEBpwBsaOuCjSkk7eYxrR6itt0m7W
         9Fb/nIak1UsUioYsVaQnehyHoHeYDc8jkXf/tP7ShGTvjstnrEWjaSaXr8FXq952Mih2
         fM5B6VG5+rJmluNxGGlXi4heO8h9T9ngBppKw=
Received: by 10.211.179.6 with SMTP id g6mr1992971ebp.32.1249681629854;
        Fri, 07 Aug 2009 14:47:09 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm4262227eyg.52.2009.08.07.14.47.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:47:09 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 7 Aug 2009 23:46:52 +0200
Subject: [PATCH 5/8] bcm63xx: add bcm96338w and bcm96338gw board support
MIME-Version: 1.0
X-UID:	1182
X-Length: 3107
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072346.52578.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds support for the bcm96338w and bcm96338gw
reference designs. Tested on bcm96338w.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 8bc4966..e639438 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -37,6 +37,93 @@ static unsigned int mac_addr_used;
 static struct board_info board;
 
 /*
+ * known 6338 boards
+ */
+#ifdef CONFIG_BCM63XX_CPU_6338
+static struct board_info __initdata board_96338gw = {
+	.name				= "96338GW",
+	.expected_cpu_id		= 0x6338,
+	
+	.has_enet0			= 1,
+	.enet0 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+	.has_ohci0			= 1,
+
+	.leds = {
+		{
+			.name		= "adsl",
+			.gpio		= 3,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ses",
+			.gpio		= 5,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp-fail",
+			.gpio		= 4,
+			.active_low	= 1,
+		},
+		{
+			.name		= "power",
+			.gpio		= 0,
+			.active_low	= 1,
+			.default_trigger = "default-on",
+		},
+		{
+			.name		= "stop",
+			.gpio		= 1,
+			.active_low	= 1,
+		}
+	},
+};
+
+static struct board_info __initdata board_96338w = {
+	.name				= "96338W",
+	.expected_cpu_id		= 0x6338,
+	
+	.has_enet0			= 1,
+	.enet0 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
+
+	.leds = {
+		{
+			.name		= "adsl",
+			.gpio		= 3,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ses",
+			.gpio		= 5,
+			.active_low	= 1,
+		},
+		{
+			.name		= "ppp-fail",
+			.gpio		= 4,
+			.active_low	= 1,
+		},
+		{
+			.name		= "power",
+			.gpio		= 0,
+			.active_low	= 1,
+			.default_trigger = "default-on",
+		},
+		{
+			.name		= "stop",
+			.gpio		= 1,
+			.active_low	= 1,
+		},
+	},
+};
+#endif
+
+/*
  * known 6348 boards
  */
 #ifdef CONFIG_BCM63XX_CPU_6348
@@ -445,6 +532,10 @@ static struct board_info __initdata board_AGPFS0 = {
  * all boards
  */
 static const struct board_info __initdata *bcm963xx_boards[] = {
+#ifdef CONFIG_BCM63XX_CPU_6338
+	&board_96338gw,
+	&board_96338w,
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6348
 	&board_96348r,
 	&board_96348gw,
