Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 22:53:20 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33516 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493230AbZHDUww (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 22:52:52 +0200
Received: by mail-ew0-f216.google.com with SMTP id 12so5358211ewy.0
        for <multiple recipients>; Tue, 04 Aug 2009 13:52:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=C0hZ8zo8gjhNmWS9qMO1Y0b7wIZ2hDvJ+HrFtvajZhw=;
        b=pBvPvexeg/PJVts3CKnBaMY+ucTDYDP4LyZlq53Yirrn06nGCO9rhgEk6UfJOw9sTX
         YdU+GXIMgKpM+i1OZ9IWD9hgmhOIRiYEY24j/TItp6mkBG236Ekz1BhTwurfkbUB3+X2
         DSsXnn17w2iYQj2BsTZaZmY64yYs3c8iZ3riA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=PpO2mVHCsqUCvzEFFUb+yyHfOJhYM4CVaY/A5r8PTl42pqAIBV8xC88BGoychYZM3B
         6eSlCL7EAL2bB0Hn6/wKSQwpqM/YD5TJqY8u3/H2guY0qa65xdIC+r/HrsEZFCthRDCl
         EMZgynZXH+rBlzeUvDLyccZXFAYPX3Y857LMk=
Received: by 10.210.86.1 with SMTP id j1mr9424416ebb.27.1249419170102;
        Tue, 04 Aug 2009 13:52:50 -0700 (PDT)
Received: from florian (135.87.196-77.rev.gaoland.net [77.196.87.135])
        by mx.google.com with ESMTPS id 5sm1445742eyf.48.2009.08.04.13.52.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 13:52:49 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 4 Aug 2009 22:52:47 +0200
Subject: [PATCH 2/5] ar7: add fixed PHY support for the two on-board cpmac
MIME-Version: 1.0
X-UID:	1137
X-Length: 2327
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908042252.47549.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds fixed PHY support for the two on-chip
cpmac Ethernet adapters.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 5422449..c4737ce 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -33,6 +33,8 @@
 #include <linux/leds.h>
 #include <linux/string.h>
 #include <linux/etherdevice.h>
+#include <linux/phy.h>
+#include <linux/phy_fixed.h>
 
 #include <asm/addrspace.h>
 #include <asm/mach-ar7/ar7.h>
@@ -209,6 +211,12 @@ static struct physmap_flash_data physmap_flash_data = {
 	.width = 2,
 };
 
+static struct fixed_phy_status fixed_phy_status __initdata = {
+	.link = 1,
+	.speed = 100,
+	.duplex = 1,
+};
+
 static struct plat_cpmac_data cpmac_low_data = {
 	.reset_bit = 17,
 	.power_bit = 20,
@@ -530,6 +538,9 @@ static int __init ar7_register_devices(void)
 	}
 
 	if (ar7_has_high_cpmac()) {
+		res = fixed_phy_add(PHY_POLL, cpmac_high.id, &fixed_phy_status);
+		if (res && res != -ENODEV)
+			return res;
 		cpmac_get_mac(1, cpmac_high_data.dev_addr);
 		res = platform_device_register(&cpmac_high);
 		if (res)
@@ -538,6 +549,10 @@ static int __init ar7_register_devices(void)
 		cpmac_low_data.phy_mask = 0xffffffff;
 	}
 
+	res = fixed_phy_add(PHY_POLL, cpmac_low.id, &fixed_phy_status);
+	if (res && res != -ENODEV)
+		return res;
+
 	cpmac_get_mac(0, cpmac_low_data.dev_addr);
 	res = platform_device_register(&cpmac_low);
 	if (res)
