Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 12:03:33 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1553 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28582464AbWLTMBz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Dec 2006 12:01:55 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E2405FE2BD;
	Wed, 20 Dec 2006 13:01:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ds8YdQ3dCWpa; Wed, 20 Dec 2006 13:01:44 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3BBC0FE2B5;
	Wed, 20 Dec 2006 13:01:44 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kBKC1qP0010560;
	Wed, 20 Dec 2006 13:01:52 +0100
Date:	Wed, 20 Dec 2006 12:01:49 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 04/10] EISA registration with !CONFIG_EISA
Message-ID: <Pine.LNX.4.64N.0612191816460.20895@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2360/Wed Dec 20 07:24:09 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is a change for the EISA bus support to permit drivers to call 
un/registration functions even if EISA support has not been enabled.  This 
is similar to what PCI (and now TC) does and reduces the need for #ifdef 
clutter.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 This is required by the updated defxx driver.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-eisa-register-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/linux/eisa.h linux-mips-2.6.18-20060920/include/linux/eisa.h
--- linux-mips-2.6.18-20060920.macro/include/linux/eisa.h	2003-10-10 04:00:31.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/linux/eisa.h	2006-12-14 22:43:31.000000000 +0000
@@ -67,10 +67,20 @@ struct eisa_driver {
 
 #define to_eisa_driver(drv) container_of(drv,struct eisa_driver, driver)
 
+/* These external functions are only available when EISA support is enabled. */
+#ifdef CONFIG_EISA
+
 extern struct bus_type eisa_bus_type;
 int eisa_driver_register (struct eisa_driver *edrv);
 void eisa_driver_unregister (struct eisa_driver *edrv);
 
+#else /* !CONFIG_EISA */
+
+static inline int eisa_driver_register (struct eisa_driver *edrv) { return 0; }
+static inline void eisa_driver_unregister (struct eisa_driver *edrv) { }
+
+#endif /* !CONFIG_EISA */
+
 /* Mimics pci.h... */
 static inline void *eisa_get_drvdata (struct eisa_device *edev)
 {
