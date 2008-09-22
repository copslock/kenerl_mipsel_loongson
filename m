Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2008 23:53:28 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:55709 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20171992AbYIVWxW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2008 23:53:22 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KhuHR-0003Az-00; Tue, 23 Sep 2008 00:53:21 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id A66EDC2E71; Tue, 23 Sep 2008 00:53:20 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP32: add platform device for cmos rtc; remove dead code
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080922225320.A66EDC2E71@solo.franken.de>
Date:	Tue, 23 Sep 2008 00:53:20 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip32/ip32-platform.c |   16 ++++++++++++++++
 arch/mips/sgi-ip32/ip32-setup.c    |    5 -----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 3d63721..511e9ff 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -90,6 +90,22 @@ static __init int sgio2btns_devinit(void)
 
 device_initcall(sgio2btns_devinit);
 
+static struct resource sgio2_cmos_rsrc[] = {
+	{
+		.start = 0x70,
+		.end   = 0x71,
+		.flags = IORESOURCE_IO
+	}
+};
+
+static __init int sgio2_cmos_devinit(void)
+{
+	return IS_ERR(platform_device_register_simple("rtc_cmos", -1,
+						      sgio2_cmos_rsrc, 1));
+}
+
+device_initcall(sgio2_cmos_devinit);
+
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("8250 UART probe driver for SGI IP32 aka O2");
diff --git a/arch/mips/sgi-ip32/ip32-setup.c b/arch/mips/sgi-ip32/ip32-setup.c
index 1024bf4..c5a5d4a 100644
--- a/arch/mips/sgi-ip32/ip32-setup.c
+++ b/arch/mips/sgi-ip32/ip32-setup.c
@@ -62,11 +62,6 @@ static inline void str2eaddr(unsigned char *ea, unsigned char *str)
 }
 #endif
 
-unsigned long read_persistent_clock(void)
-{
-	return mc146818_get_cmos_time();
-}
-
 /* An arbitrary time; this can be decreased if reliability looks good */
 #define WAIT_MS 10
 
