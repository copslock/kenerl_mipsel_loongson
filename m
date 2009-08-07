Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:47:37 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.149]:61977 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492944AbZHGVqh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:46:37 +0200
Received: by ey-out-1920.google.com with SMTP id 13so537881eye.54
        for <multiple recipients>; Fri, 07 Aug 2009 14:46:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nrzeIIAM5/t90Cxqfd+HUi4lRUiFzU6ZXabHeOmRQg8=;
        b=vICbOin1c/Kdbe0eX4UTFsKUtSeTdStrLy1h+poVjIhlqJS8wlhwT8jhXAAEiYqN+c
         9GiMFmREpiQkiCUozRmRfOGS5r5nqDLO4GpKv9Rbs9n/Ql8V8B/om+WO0jKn7/+l+XN1
         OQ56RRp31mVp/3pG3Ts25KQpu2jm5DYNNQqSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=n8LF5TfWk+2oqGSGc4JtLnqERlLN80EWi2ju7ZSI5QlGUQUrIKugiglr2V/CNW8nNd
         oYJglAxvp1LCKkUgvz+1OB2h1WolMH80lmW4MuDU7VeA2cnTFHW/zUzMho4pU/t2BSs9
         XOqsWTm6YkulIGToxhXKOWMTHG6ymPsgAgo50=
Received: by 10.210.131.6 with SMTP id e6mr53090ebd.29.1249681596437;
        Fri, 07 Aug 2009 14:46:36 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm1543779eye.24.2009.08.07.14.46.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:46:35 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 7 Aug 2009 23:46:34 +0200
Subject: [PATCH 2/8] bcm63xx: register VoIP DSP for bcm96348gw-10 and bcm96348gw designs
MIME-Version: 1.0
X-UID:	1179
X-Length: 2345
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072346.34473.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patchs makes bcm96348gw-10 and bcm96348gw designs register
the VoIP DSP platform device.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 683873d..668abdb 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -27,6 +27,7 @@
 #include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_usb_ohci.h>
 #include <bcm63xx_dev_usb_ehci.h>
+#include <bcm63xx_dev_dsp.h>
 #include <board_bcm963xx.h>
 
 #define PFX	"board_bcm963xx: "
@@ -72,6 +73,14 @@ static struct board_info __initdata board_96348gw_10 = {
 	.has_ohci0			= 1,
 	.has_pccard			= 1,
 	.has_ehci0			= 1,
+
+	.has_dsp			= 1,
+	.dsp = {
+		.gpio_rst		= 6,
+		.gpio_int		= 34,
+		.cs			= 2,
+		.ext_irq		= 2,
+	},
 };
 
 static struct board_info __initdata board_96348gw_11 = {
@@ -116,6 +125,14 @@ static struct board_info __initdata board_96348gw = {
 	},
 
 	.has_ohci0 = 1,
+
+	.has_dsp			= 1,
+	.dsp = {
+		.gpio_rst		= 6,
+		.gpio_int		= 34,
+		.ext_irq		= 2,
+		.cs			= 2,
+	},
 };
 
 static struct board_info __initdata board_FAST2404 = {
@@ -514,6 +531,9 @@ int __init board_register_devices(void)
 	if (board.has_ehci0)
 		bcm63xx_ehci_register();
 
+	if (board.has_dsp)
+		bcm63xx_dsp_register(&board.dsp);
+
 	/* Generate MAC address for WLAN and
 	 * register our SPROM */
 #ifdef CONFIG_SSB_PCIHOST
