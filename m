Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2007 12:01:07 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:18661 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023160AbXLBMA7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Dec 2007 12:00:59 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IynVI-0001dY-00; Sun, 02 Dec 2007 13:00:56 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id E7844C2EB5; Sun,  2 Dec 2007 12:54:42 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
cc:	wim@iguana.be
Subject: [PATCH] WATCHDOG: Use SGI_HAS_INDYDOG for INDYDOG depends
Message-Id: <20071202115442.E7844C2EB5@solo.franken.de>
Date:	Sun,  2 Dec 2007 12:54:42 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Use SGI_HAS_INDYDOG for INDYDOG depends.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.25.

 drivers/watchdog/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2792bc1..1ba30cb 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -586,7 +586,7 @@ config SBC_EPX_C3_WATCHDOG
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on SGI_IP22
+	depends on SGI_HAS_INDYDOG
 	help
 	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
