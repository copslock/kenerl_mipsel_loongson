Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2007 12:03:01 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:21221 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023460AbXLBMBD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Dec 2007 12:01:03 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IynVI-0001dY-03; Sun, 02 Dec 2007 13:00:56 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 9A8C8C2EB6; Sun,  2 Dec 2007 12:55:33 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
cc:	akpm@linux-foundation.org
Subject: [PATCH] SERIAL: Use SGI_HAS_ZILOG for IP22_ZILOG depends
Message-Id: <20071202115533.9A8C8C2EB6@solo.franken.de>
Date:	Sun,  2 Dec 2007 12:55:33 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

- Use SGI_HAS_ZILOG for IP22_ZILOG depends
- remove IP22 from description, because the driver works on more than
  IP22 SGI machines

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.25.

 drivers/serial/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7e1996..90eb9ce 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -877,15 +877,15 @@ config SERIAL_SUNHV
 	  systems.  Say Y if you want to be able to use this device.
 
 config SERIAL_IP22_ZILOG
-	tristate "IP22 Zilog8530 serial support"
-	depends on SGI_IP22
+	tristate "SGI Zilog8530 serial support"
+	depends on SGI_HAS_ZILOG
 	select SERIAL_CORE
 	help
-	  This driver supports the Zilog8530 serial ports found on SGI IP22
+	  This driver supports the Zilog8530 serial ports found on SGI 
 	  systems.  Say Y or M if you want to be able to these serial ports.
 
 config SERIAL_IP22_ZILOG_CONSOLE
-	bool "Console on IP22 Zilog8530 serial port"
+	bool "Console on SGI Zilog8530 serial port"
 	depends on SERIAL_IP22_ZILOG=y
 	select SERIAL_CORE_CONSOLE
 
