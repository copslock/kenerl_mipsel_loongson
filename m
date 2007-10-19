Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 21:35:26 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:20200 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20045655AbXJSUfS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 21:35:18 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D4DA1400D5;
	Fri, 19 Oct 2007 22:34:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 3LhpYYoM4n2m; Fri, 19 Oct 2007 22:34:42 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9411C400A4;
	Fri, 19 Oct 2007 22:34:42 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JKYlpM024842;
	Fri, 19 Oct 2007 22:34:47 +0200
Date:	Fri, 19 Oct 2007 21:34:41 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz: Update Kconfig description
Message-ID: <Pine.LNX.4.64N.0710192130060.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Reformat the Kconfig entries and update descriptions for accuracy.  
Select the driver by default for configurations of interest.  For the 
curious: 32BIT means only 32-bit DECstations support the device, not that 
the driver is not 64-bit clean; I have not checked that either though.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Please apply,

  Maciej

patch-mips-2.6.18-20060920-dz-kconfig-2
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/serial/Kconfig linux-mips-2.6.18-20060920/drivers/serial/Kconfig
--- linux-mips-2.6.18-20060920.macro/drivers/serial/Kconfig	2006-06-29 05:03:07.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/serial/Kconfig	2007-02-04 20:18:36.000000000 +0000
@@ -385,20 +385,24 @@ config SERIAL_DZ
 	bool "DECstation DZ serial driver"
 	depends on MACH_DECSTATION && 32BIT
 	select SERIAL_CORE
-	help
-	  DZ11-family serial controllers for VAXstations, including the
-	  DC7085, M7814, and M7819.
+	default y
+	---help---
+	  DZ11-family serial controllers for DECstations and VAXstations,
+	  including the DC7085, M7814, and M7819.
 
 config SERIAL_DZ_CONSOLE
 	bool "Support console on DECstation DZ serial driver"
 	depends on SERIAL_DZ=y
 	select SERIAL_CORE_CONSOLE
-	help
+	default y
+	---help---
 	  If you say Y here, it will be possible to use a serial port as the
 	  system console (the system console is the device which receives all
 	  kernel messages and warnings and which allows logins in single user
-	  mode).  Note that the firmware uses ttyS0 as the serial console on
-	  the Maxine and ttyS2 on the others.
+	  mode).
+
+	  Note that the firmware uses ttyS3 as the serial console on
+	  DECstations that use this driver.
 
 	  If unsure, say Y.
 
