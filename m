Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 11:58:19 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:23238 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023658AbXINK6L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 11:58:11 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D3E21400EB;
	Fri, 14 Sep 2007 12:57:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id YFErxOeR1Nec; Fri, 14 Sep 2007 12:57:33 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B712C40090;
	Fri, 14 Sep 2007 12:57:33 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8EAvauT025973;
	Fri, 14 Sep 2007 12:57:36 +0200
Date:	Fri, 14 Sep 2007 11:57:33 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] NET_SB1250_MAC: Update Kconfig entry
Message-ID: <Pine.LNX.4.64N.0709141148540.1926@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4272/Fri Sep 14 10:36:36 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The SB1250 network interfaces are Gigabit Ethernet ones.  Move the 
Kconfig entry to the appropriate section and add some help text.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 It should be obvious; I hope the help text will be useful to somebody and 
will prevent from misclassifying the interface again in the future.

 Please apply,

  Maciej

patch-netdev-2.6.23-rc6-20070913-sb1250-mac-kconfig-0
diff -up --recursive --new-file linux-netdev-2.6.23-rc6-20070913.macro/drivers/net/Kconfig linux-netdev-2.6.23-rc6-20070913/drivers/net/Kconfig
--- linux-netdev-2.6.23-rc6-20070913.macro/drivers/net/Kconfig	2007-09-13 17:27:52.000000000 +0000
+++ linux-netdev-2.6.23-rc6-20070913/drivers/net/Kconfig	2007-09-14 00:02:05.000000000 +0000
@@ -466,10 +466,6 @@ config MIPS_AU1X00_ENET
 	  If you have an Alchemy Semi AU1X00 based system
 	  say Y.  Otherwise, say N.
 
-config NET_SB1250_MAC
-	tristate "SB1250 Ethernet support"
-	depends on SIBYTE_SB1xxx_SOC
-
 config SGI_IOC3_ETH
 	bool "SGI IOC3 Ethernet"
 	depends on PCI && SGI_IP27
@@ -2157,6 +2153,18 @@ config R8169_VLAN
 	  
 	  If in doubt, say Y.
 
+config NET_SB1250_MAC
+	tristate "SB1250 Gigabit Ethernet support"
+	depends on SIBYTE_SB1xxx_SOC
+	---help---
+	  This driver supports Gigabit Ethernet interfaces based on the
+	  Broadcom SiByte family of System-On-a-Chip parts.  They include
+	  the BCM1120, BCM1125, BCM1125H, BCM1250, BCM1255, BCM1280, BCM1455
+	  and BCM1480 chips.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called sb1250-mac.
+
 config SIS190
 	tristate "SiS190/SiS191 gigabit ethernet support"
 	depends on PCI
