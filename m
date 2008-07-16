Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 13:06:22 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:38349 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28580210AbYGPMGU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 13:06:20 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KJ5lz-0005YL-00; Wed, 16 Jul 2008 14:06:19 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id ECBF2C2B2E; Wed, 16 Jul 2008 14:06:15 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix merge bug
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080716120615.ECBF2C2B2E@solo.franken.de>
Date:	Wed, 16 Jul 2008 14:06:15 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Instead of one SGI_HAS_HAL2 for IP22 and one for IP28, IP28 got two of
them... Let's give IP22 some ALSA sound, too.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d21df5f..30edc39 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -330,6 +330,7 @@ config SGI_IP22
 	select SGI_HAS_DS1286
 	select SGI_HAS_I8042
 	select SGI_HAS_INDYDOG
+	select SGI_HAS_HAL2
 	select SGI_HAS_SEEQ
 	select SGI_HAS_WD93
 	select SGI_HAS_ZILOG
@@ -386,7 +387,6 @@ config SGI_IP28
 	select SGI_HAS_I8042
 	select SGI_HAS_INDYDOG
 	select SGI_HAS_HAL2
-	select SGI_HAS_HAL2
 	select SGI_HAS_SEEQ
 	select SGI_HAS_WD93
 	select SGI_HAS_ZILOG
