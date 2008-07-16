Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 14:19:04 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:27856 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28580772AbYGPNTB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 14:19:01 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KJ6uL-0004aA-01; Wed, 16 Jul 2008 15:19:01 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 59743C2DA7; Wed, 16 Jul 2008 15:18:58 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP32: Use common SGI button driver
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080716131858.59743C2DA7@solo.franken.de>
Date:	Wed, 16 Jul 2008 15:18:58 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

use the Indy/O2 button driver

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip32/ip32-platform.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 2ee401b..3d63721 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -85,18 +85,7 @@ device_initcall(sgio2audio_devinit);
 
 static __init int sgio2btns_devinit(void)
 {
-	struct platform_device *pd;
-	int ret;
-
-	pd = platform_device_alloc("sgio2btns", -1);
-	if (!pd)
-		return -ENOMEM;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		platform_device_put(pd);
-
-	return ret;
+	return IS_ERR(platform_device_register_simple("sgibtns", -1, NULL, 0));
 }
 
 device_initcall(sgio2btns_devinit);
