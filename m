Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 14:19:24 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:27600 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28580794AbYGPNTB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 14:19:01 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KJ6uL-0004aA-00; Wed, 16 Jul 2008 15:19:01 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id F0FA5C2DA0; Wed, 16 Jul 2008 15:18:54 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP22: Use common SGI button driver
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080716131854.F0FA5C2DA0@solo.franken.de>
Date:	Wed, 16 Jul 2008 15:18:54 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

use the Indy/O2 button driver

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip22/ip22-platform.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index fc6df96..6014123 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -188,8 +188,7 @@ static int __init sgi_button_devinit(void)
 	if (ip22_is_fullhouse())
 		return 0; /* full house has no volume buttons */
 
-	return IS_ERR(platform_device_register_simple("sgiindybtns",
-						      -1, NULL, 0));
+	return IS_ERR(platform_device_register_simple("sgibtns", -1, NULL, 0));
 }
 
 device_initcall(sgi_button_devinit);
