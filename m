Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 16:18:55 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:41221 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038880AbWJCPS3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 16:18:29 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 87F6CF62EB;
	Tue,  3 Oct 2006 17:18:25 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XXWpFC5-Ohe3; Tue,  3 Oct 2006 17:18:25 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 2AF6FF62DA;
	Tue,  3 Oct 2006 17:18:25 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k93FIWv6005071;
	Tue, 3 Oct 2006 17:18:32 +0200
Date:	Tue, 3 Oct 2006 16:18:28 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: [patch 2/6] 2.6.18: sb1250-mac: Missing inclusions from <linux/phy.h>
Message-ID: <Pine.LNX.4.64N.0610031504580.4642@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1984/Tue Oct  3 12:01:28 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 The <linux/phy.h> uses some types and macros defined in 
<linux/ethtool.h>, <linux/mii.h>, <linux/timer.h> and <linux/workqueue.h>, 
but fails to include these headers.

 Please consider.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-mips-2.6.18-20060920-include-phy-16
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/linux/phy.h linux-mips-2.6.18-20060920/include/linux/phy.h
--- linux-mips-2.6.18-20060920.macro/include/linux/phy.h	2006-08-29 04:58:59.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/linux/phy.h	2006-10-03 14:18:05.000000000 +0000
@@ -20,6 +20,10 @@
 
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
 
 #define PHY_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
 				 SUPPORTED_10baseT_Full | \
