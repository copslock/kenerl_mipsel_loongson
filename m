Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2008 19:30:03 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:62689 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022781AbYGJSaB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2008 19:30:01 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KH0tz-0003lZ-00; Thu, 10 Jul 2008 20:29:59 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 15B4BC2AE2; Thu, 10 Jul 2008 20:29:55 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP22/28: Add platform devices for hal2
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080710182955.15B4BC2AE2@solo.franken.de>
Date:	Thu, 10 Jul 2008 20:29:55 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Create platform devices for hal2 and add option for selecting HAL2 alsa
driver.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/Kconfig                  |    5 +++++
 arch/mips/sgi-ip22/ip22-platform.c |    7 +++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 24c5dee..a3a2dd2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -382,6 +382,7 @@ config SGI_IP22
 	select SGI_HAS_DS1286
 	select SGI_HAS_I8042
 	select SGI_HAS_INDYDOG
+	select SGI_HAS_HAL2
 	select SGI_HAS_SEEQ
 	select SGI_HAS_WD93
 	select SGI_HAS_ZILOG
@@ -437,6 +438,7 @@ config SGI_IP28
 	select SGI_HAS_DS1286
 	select SGI_HAS_I8042
 	select SGI_HAS_INDYDOG
+	select SGI_HAS_HAL2
 	select SGI_HAS_SEEQ
 	select SGI_HAS_WD93
 	select SGI_HAS_ZILOG
@@ -979,6 +981,9 @@ config SGI_HAS_DS1286
 config SGI_HAS_INDYDOG
 	bool
 
+config SGI_HAS_HAL2
+	bool
+
 config SGI_HAS_SEEQ
 	bool
 
diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index 28ffec8..d93d07a 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -175,3 +175,10 @@ static int __init sgiseeq_devinit(void)
 }
 
 device_initcall(sgiseeq_devinit);
+
+static int __init sgi_hal2_devinit(void)
+{
+	return IS_ERR(platform_device_register_simple("sgihal2", 0, NULL, 0));
+}
+
+device_initcall(sgi_hal2_devinit);
