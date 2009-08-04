Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 23:09:51 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61746 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493206AbZHDVJo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 23:09:44 +0200
Received: by ewy12 with SMTP id 12so5371125ewy.0
        for <multiple recipients>; Tue, 04 Aug 2009 14:09:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eS/OWK3+wDWq7Xy8FqzibW030xcVvpJlJIOzK0m8/Lg=;
        b=GhnNldHMs1vxA491dye1iFc6/hhWcUNtZMup52VhEAkSpbNp5VoAuDes+Vz8UjJhhE
         WvySmuh+/P/MGzky2OYDendIgmHCKc7TfPh/bBc3Mr26J3qPqjc4hJdbDBp7e2Z4yvln
         lwqpMcXDw86YuO7z4/La6f4RU6xpjwni9RMJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=LsYxBzu67yg5N+ZYBPsRFSeYUHI5M3KtqSRGNUvqF7RWFkn1K6mtCCop1Nv8UfttYH
         XbXkImMfbuPvVyeyj6uSF2si/+K1WKxgLo5n2MgYHHvQSqAGJr7qeDV9bndrxWSi9ZJ7
         iNSFAqIti3F/FeMc2lq4u4Rsp0LI0e9rJC8MQ=
Received: by 10.210.118.14 with SMTP id q14mr9399068ebc.74.1249420179198;
        Tue, 04 Aug 2009 14:09:39 -0700 (PDT)
Received: from florian (135.87.196-77.rev.gaoland.net [77.196.87.135])
        by mx.google.com with ESMTPS id 7sm730121eyg.55.2009.08.04.14.09.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 14:09:38 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 4 Aug 2009 23:09:36 +0200
Subject: [PATCH] ar7: register watchdog driver only if enabled in hardware configuration
MIME-Version: 1.0
X-UID:	1152
X-Length: 2294
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908042309.36721.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch checks if the watchdog enable bit is set in the DCL
register meaning that the hardware watchdog actually works and
if so, register the ar7_wdt platform_device.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index e2278c0..835f3f0 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -503,6 +503,7 @@ static int __init ar7_register_devices(void)
 {
 	u16 chip_id;
 	int res;
+	u32 *bootcr, val;
 #ifdef CONFIG_SERIAL_8250
 	static struct uart_port uart_port[2];
 
@@ -595,7 +596,13 @@ static int __init ar7_register_devices(void)
 
 	ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
 
-	res = platform_device_register(&ar7_wdt);
+	bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
+	val = *bootcr;
+	iounmap(bootcr);
+
+	/* Register watchdog only if enabled in hardware */
+	if (val & AR7_WDT_HW_ENA)
+		res = platform_device_register(&ar7_wdt);
 
 	return res;
 }
diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
index de71694..21cbbc7 100644
--- a/arch/mips/include/asm/mach-ar7/ar7.h
+++ b/arch/mips/include/asm/mach-ar7/ar7.h
@@ -78,6 +78,9 @@
 #define AR7_REF_CLOCK	25000000
 #define AR7_XTAL_CLOCK	24000000
 
+/* DCL */
+#define AR7_WDT_HW_ENA	0x10
+
 struct plat_cpmac_data {
 	int reset_bit;
 	int power_bit;
