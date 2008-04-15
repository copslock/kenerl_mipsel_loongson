Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 19:26:59 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:50438 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28575188AbYDOS05 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Apr 2008 19:26:57 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id D58108810; Tue, 15 Apr 2008 23:26:55 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 2/2] Pb1200: do register SMC 91C111
Date:	Tue, 15 Apr 2008 22:26:18 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804152226.18762.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Pb1200 does have SMC 91C111 Ethernet chip on board but the platform code did
not register it, so one couldn't mount NFS...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This is definitely a bad place for the board #ifdef's, so I'm going to submit
a patch moving IDE and 91C111 registration into arch/mips/au1000/pb1200/...

 arch/mips/au1000/common/platform.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/platform.c
+++ linux-2.6/arch/mips/au1000/common/platform.c
@@ -245,8 +245,7 @@ static struct platform_device au1x00_pcm
 	.id 		= 0,
 };
 
-#ifdef CONFIG_MIPS_DB1200
-
+#if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
 static struct resource smc91x_resources[] = {
 	[0] = {
 		.name	= "smc91x-regs",
@@ -267,8 +266,7 @@ static struct platform_device smc91x_dev
 	.num_resources	= ARRAY_SIZE(smc91x_resources),
 	.resource	= smc91x_resources,
 };
-
-#endif
+#endif /* defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200) */
 
 /* All Alchemy demoboards with I2C have this #define in their headers */
 #ifdef SMBUS_PSC_BASE
@@ -302,7 +300,7 @@ static struct platform_device *au1xxx_pl
 	&au1200_ide0_device,
 	&au1xxx_mmc_device,
 #endif
-#ifdef CONFIG_MIPS_DB1200
+#if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
 	&smc91x_device,
 #endif
 #ifdef SMBUS_PSC_BASE
