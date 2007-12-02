Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2007 12:03:24 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:21477 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023451AbXLBMBD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Dec 2007 12:01:03 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IynVJ-0001dY-00; Sun, 02 Dec 2007 13:00:57 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 56627C2EB6; Sun,  2 Dec 2007 12:55:36 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
cc:	akpm@linux-foundation.org
Subject: [PATCH] CHAR: Use SGI_HAS_DS1286 for SGI_DS1286 depends
Message-Id: <20071202115536.56627C2EB6@solo.franken.de>
Date:	Sun,  2 Dec 2007 12:55:36 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Use SGI_HAS_DS1286 for SGI_DS1286 depends

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.25.

 drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a509b8d..06271e8 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -777,7 +777,7 @@ config JS_RTC
 
 config SGI_DS1286
 	tristate "SGI DS1286 RTC support"
-	depends on SGI_IP22
+	depends on SGI_HAS_DS1286
 	help
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
