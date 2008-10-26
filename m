Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Oct 2008 10:13:01 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.153]:9618 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S22406283AbYJZKMx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Oct 2008 10:12:53 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1511400fga.32
        for <linux-mips@linux-mips.org>; Sun, 26 Oct 2008 03:12:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=UlFRKpi4GJAGzEaLdSQAb813iIRcDlsZ9MZC3zyuhr8=;
        b=tken4FXRQ9WQcsL+iDJG+CcXg8XigJye08YMPB7pHL//9SP6T/3Tt2z+mct6aO72VY
         wfa6dyRTMDfjObcliokHaO/U4beyzE1bJaP8m9kpeVNHATfGmOJeq3bkxpxt4JS3pm+p
         z9ZfQOOoH2+9ukDeAQhbGNzzU9tzzhzEn0prY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:date:subject:mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        b=eTlltmJNzWjKBoXNQhBRcc/mPcQkQ81c/OMXlSfphjB3zsqv1YBYuLqIplaO8vd+bj
         Nz2EKPJXcDZw7lxYGoI3RpKkF8hmh0fbOBT/MnUqXuBWEqdJP52PACod0UwQKDDxI+JA
         VvGMQY0ZAVh9CltH0f74nuBMkskUk+Ei3xgl4=
Received: by 10.86.28.2 with SMTP id b2mr2059298fgb.54.1225015969896;
        Sun, 26 Oct 2008 03:12:49 -0700 (PDT)
Received: from ?192.168.1.24? (90.130.195-77.rev.gaoland.net [77.195.130.90])
        by mx.google.com with ESMTPS id e20sm4060548fga.1.2008.10.26.03.12.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Oct 2008 03:12:49 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 26 Oct 2008 11:12:36 +0100
Subject: [PATCH] rb532: gpio register offsets are relatives to GPIOBASE
MIME-Version: 1.0
X-UID:	12
X-Length: 2368
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips" <linux-mips@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810261112.37008.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes the wrong use of GPIO register offsets
in devices.c. To avoid further problems, use gpio_get_value
to return the NAND status instead of our own expanded code.

Signef-off-by: Phil Sutter <n0-1@freewrt.org>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/include/asm/mach-rc32434/rb.h b/arch/mips/include/asm/mach-rc32434/rb.h
index 79e8ef6..0cb9466 100644
--- a/arch/mips/include/asm/mach-rc32434/rb.h
+++ b/arch/mips/include/asm/mach-rc32434/rb.h
@@ -40,12 +40,13 @@
 #define BTCS		0x010040
 #define BTCOMPARE	0x010044
 #define GPIOBASE	0x050000
-#define GPIOCFG		0x050004
-#define GPIOD		0x050008
-#define GPIOILEVEL	0x05000C
-#define GPIOISTAT	0x050010
-#define GPIONMIEN	0x050014
-#define IMASK6		0x038038
+/* Offsets relative to GPIOBASE */
+#define GPIOCFG		0x04
+#define GPIOD		0x08
+#define GPIOILEVEL	0x0C
+#define GPIOISTAT	0x10
+#define GPIONMIEN	0x14
+#define IMASK6		0x38
 #define LO_WPX		(1 << 0)
 #define LO_ALE		(1 << 1)
 #define LO_CLE		(1 << 2)
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 31619c6..c40be04 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -118,7 +118,7 @@ static struct platform_device cf_slot0 = {
 /* Resources and device for NAND */
 static int rb532_dev_ready(struct mtd_info *mtd)
 {
-	return readl(IDT434_REG_BASE + GPIOD) & GPIO_RDY;
+	return gpio_get_value(GPIO_RDY);
 }
 
 static void rb532_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
