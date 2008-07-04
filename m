Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2008 00:12:27 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:35289 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20212841AbYGDXMT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2008 00:12:19 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KEuRt-0004Kk-00; Sat, 05 Jul 2008 01:12:17 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 3C6121DA77A; Sat,  5 Jul 2008 01:12:13 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP32: Add platform devices for audio and volume button
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080704231213.3C6121DA77A@solo.franken.de>
Date:	Sat,  5 Jul 2008 01:12:13 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Create platform devices for audio and volume button driver.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip32/ip32-platform.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 89a71f4..2ee401b 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -65,6 +65,42 @@ static __init int meth_devinit(void)
 
 device_initcall(meth_devinit);
 
+static __init int sgio2audio_devinit(void)
+{
+	struct platform_device *pd;
+	int ret;
+
+	pd = platform_device_alloc("sgio2audio", -1);
+	if (!pd)
+		return -ENOMEM;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		platform_device_put(pd);
+
+	return ret;
+}
+
+device_initcall(sgio2audio_devinit);
+
+static __init int sgio2btns_devinit(void)
+{
+	struct platform_device *pd;
+	int ret;
+
+	pd = platform_device_alloc("sgio2btns", -1);
+	if (!pd)
+		return -ENOMEM;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		platform_device_put(pd);
+
+	return ret;
+}
+
+device_initcall(sgio2btns_devinit);
+
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("8250 UART probe driver for SGI IP32 aka O2");
