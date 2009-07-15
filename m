Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2009 12:09:48 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.150]:26744 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492857AbZGOKJk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2009 12:09:40 +0200
Received: by ey-out-1920.google.com with SMTP id 13so712016eye.54
        for <multiple recipients>; Wed, 15 Jul 2009 03:09:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1JTQ7VZ4Zf19SH/A/VR5mf8T7vMGfhJ8AxcOMZ36cek=;
        b=iI2YUueP79yDibpphbY55qrdUBn/Lxqzdu8AEJOgMtAJRcjnp6FGaPpwk69qRzg/2x
         Wl8ORhsMtlvtmaWtTMLy9t1OgVSzlzkoqoKQzSaJDITyqPjkGKgRW9pCYZepd5UFpigB
         /k7DPRo+Uc0EJthCp2k0QRAnlmQ2oDg8ZiOJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=An47pX1ynXC0zWc2VzobwYfauCxQFb1IfByUqRIAuoAUJf0KlPEvRTTMX3wYOJbKFi
         SMygdGy9oFw2nQ9G1HrGQ6gmq3sE7fd4OqEj9mnkjrHu8/Q0aSGRZd2eW4pT6YcVEqaX
         gH7XhzKvj0ktlQVYdtyEkHQxckWbsaee/TsOU=
Received: by 10.210.61.8 with SMTP id j8mr9064963eba.16.1247652580166;
        Wed, 15 Jul 2009 03:09:40 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm1916624eyh.40.2009.07.15.03.09.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 03:09:38 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Wed, 15 Jul 2009 12:09:34 +0200
Subject: [PATCH 1/2] ar7: make board code register ar7_wdt as a platform device
MIME-Version: 1.0
X-UID:	626
X-Length: 2489
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907151209.35566.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes the board code register the ar7_wdt
driver as a platform device. We move the dynamic
resource calculation here since the driver should not be
aware of the AR7 SoC version it is running on.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 5422449..06e3147 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -410,6 +410,20 @@ static struct platform_device ar7_udc = {
 	.num_resources = ARRAY_SIZE(usb_res),
 };
 
+static struct resource ar7_wdt_res = {
+	.name = "regs",
+	.start = -1, /* Filled at runtime */
+	.end = -1, /* Filled at runtime */
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device ar7_wdt = {
+	.id = -1,
+	.name  = "ar7_wdt",
+	.resource = &ar7_wdt_res,
+	.num_resources = 1,
+};
+
 static inline unsigned char char2hex(char h)
 {
 	switch (h) {
@@ -482,6 +496,7 @@ static int __init ar7_register_devices(void)
 {
 	int res;
 	static struct uart_port uart_port[2];
+	u16 chip_id;
 
 	memset(uart_port, 0, sizeof(struct uart_port) * 2);
 
@@ -550,6 +565,23 @@ static int __init ar7_register_devices(void)
 
 	res = platform_device_register(&ar7_udc);
 
+	chip_id = ar7_chip_id();
+	switch (chip_id) {
+	case AR7_CHIP_7100:
+	case AR7_CHIP_7200:
+		ar7_wdt_res.start = AR7_REGS_WDT;
+		break;
+	case AR7_CHIP_7300:
+		ar7_wdt_res.start = UR8_REGS_WDT;
+		break;
+	default:
+		break;
+	}
+
+	ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
+
+	res = platform_device_register(&ar7_wdt);
+
 	return res;
 }
 arch_initcall(ar7_register_devices);
