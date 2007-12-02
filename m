Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2007 12:02:01 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:19941 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023370AbXLBMBB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Dec 2007 12:01:01 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IynVI-0001dY-02; Sun, 02 Dec 2007 13:00:56 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 85F91C2EB6; Sun,  2 Dec 2007 12:55:19 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-input@vger.kernel.org, linux-mips@linux-mips.org
cc:	dmitry.torokhov@gmail.com
Subject: [PATCH] I8042: Use SGI_HAS_I8042 to select SGI i8042 handlinig
Message-Id: <20071202115519.85F91C2EB6@solo.franken.de>
Date:	Sun,  2 Dec 2007 12:55:19 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Use SGI_HAS_I8042 to select SGI i8042 handling

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.25.

 drivers/input/serio/i8042.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index dd22d91..c972e5d 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -16,7 +16,7 @@
 
 #if defined(CONFIG_MACH_JAZZ)
 #include "i8042-jazzio.h"
-#elif defined(CONFIG_SGI_IP22)
+#elif defined(CONFIG_SGI_HAS_I8042)
 #include "i8042-ip22io.h"
 #elif defined(CONFIG_PPC)
 #include "i8042-ppcio.h"
