Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 20:58:08 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:36825 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20045661AbXJST6A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 20:58:00 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id DA141400A4;
	Fri, 19 Oct 2007 21:58:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id WWZUAjXNz9ws; Fri, 19 Oct 2007 21:57:55 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0FFAF40091;
	Fri, 19 Oct 2007 21:57:55 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JJw0Jx017923;
	Fri, 19 Oct 2007 21:58:00 +0200
Date:	Fri, 19 Oct 2007 20:57:53 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz.h: Remove useless unused module junk
Message-ID: <Pine.LNX.4.64N.0710192055090.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Remove unused module function prototypes that would not even build if
enabled.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Please apply under the obviously-correct rule.

  Maciej

patch-mips-2.6.18-20060920-dz-junk-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/serial/dz.h linux-mips-2.6.18-20060920/drivers/serial/dz.h
--- linux-mips-2.6.18-20060920.macro/drivers/serial/dz.h	2003-06-11 23:26:46.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/serial/dz.h	2007-01-07 19:06:02.000000000 +0000
@@ -110,9 +110,4 @@
 #define DZ_XMIT_SIZE   4096                 /* buffer size */
 #define DZ_WAKEUP_CHARS   DZ_XMIT_SIZE/4
 
-#ifdef MODULE
-int init_module (void)
-void cleanup_module (void)
-#endif
-
 #endif /* DZ_SERIAL_H */
