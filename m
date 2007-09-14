Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 12:05:27 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:50617 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023662AbXINLFJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 12:05:09 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 01D4B400EB;
	Fri, 14 Sep 2007 13:05:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id qddYxeEu+vNX; Fri, 14 Sep 2007 13:05:01 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 72CFE40090;
	Fri, 14 Sep 2007 13:05:01 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8EB54w5026565;
	Fri, 14 Sep 2007 13:05:04 +0200
Date:	Fri, 14 Sep 2007 12:05:00 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] NET_SB1250_MAC: Rename to SB1250_MAC
Message-ID: <Pine.LNX.4.64N.0709141158010.1926@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4272/Fri Sep 14 10:36:36 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Rename NET_SB1250_MAC to SB1250_MAC to follow the convention.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 The NET prefix seems to be used mainly for device groups (NET_ISA, 
NET_VENDOR_*, etc.) rather than single drivers and adds no information.  I 
suggest it to be removed.

 Depends on "patch-netdev-2.6.23-rc6-20070913-sb1250-mac-kconfig-0".

 Please consider,

  Maciej

patch-netdev-2.6.23-rc6-20070913-sb1250-mac-config-0
diff -up --recursive --new-file linux-netdev-2.6.23-rc6-20070913.macro/arch/mips/configs/bigsur_defconfig linux-netdev-2.6.23-rc6-20070913/arch/mips/configs/bigsur_defconfig
--- linux-netdev-2.6.23-rc6-20070913.macro/arch/mips/configs/bigsur_defconfig	2007-09-04 04:55:19.000000000 +0000
+++ linux-netdev-2.6.23-rc6-20070913/arch/mips/configs/bigsur_defconfig	2007-09-14 00:22:18.000000000 +0000
@@ -574,7 +574,7 @@ CONFIG_MII=y
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
-CONFIG_NET_SB1250_MAC=y
+CONFIG_SB1250_MAC=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
diff -up --recursive --new-file linux-netdev-2.6.23-rc6-20070913.macro/arch/mips/configs/sb1250-swarm_defconfig linux-netdev-2.6.23-rc6-20070913/arch/mips/configs/sb1250-swarm_defconfig
--- linux-netdev-2.6.23-rc6-20070913.macro/arch/mips/configs/sb1250-swarm_defconfig	2007-09-04 04:55:19.000000000 +0000
+++ linux-netdev-2.6.23-rc6-20070913/arch/mips/configs/sb1250-swarm_defconfig	2007-09-14 00:22:29.000000000 +0000
@@ -566,7 +566,7 @@ CONFIG_MII=y
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
-CONFIG_NET_SB1250_MAC=y
+CONFIG_SB1250_MAC=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
diff -up --recursive --new-file linux-netdev-2.6.23-rc6-20070913.macro/drivers/net/Kconfig linux-netdev-2.6.23-rc6-20070913/drivers/net/Kconfig
--- linux-netdev-2.6.23-rc6-20070913.macro/drivers/net/Kconfig	2007-09-14 00:02:05.000000000 +0000
+++ linux-netdev-2.6.23-rc6-20070913/drivers/net/Kconfig	2007-09-14 00:21:06.000000000 +0000
@@ -2153,7 +2153,7 @@ config R8169_VLAN
 	  
 	  If in doubt, say Y.
 
-config NET_SB1250_MAC
+config SB1250_MAC
 	tristate "SB1250 Gigabit Ethernet support"
 	depends on SIBYTE_SB1xxx_SOC
 	---help---
diff -up --recursive --new-file linux-netdev-2.6.23-rc6-20070913.macro/drivers/net/Makefile linux-netdev-2.6.23-rc6-20070913/drivers/net/Makefile
--- linux-netdev-2.6.23-rc6-20070913.macro/drivers/net/Makefile	2007-09-13 17:27:52.000000000 +0000
+++ linux-netdev-2.6.23-rc6-20070913/drivers/net/Makefile	2007-09-14 00:21:20.000000000 +0000
@@ -107,7 +107,7 @@ obj-$(CONFIG_E2100) += e2100.o 8390.o
 obj-$(CONFIG_ES3210) += es3210.o 8390.o
 obj-$(CONFIG_LNE390) += lne390.o 8390.o
 obj-$(CONFIG_NE3210) += ne3210.o 8390.o
-obj-$(CONFIG_NET_SB1250_MAC) += sb1250-mac.o
+obj-$(CONFIG_SB1250_MAC) += sb1250-mac.o
 obj-$(CONFIG_B44) += b44.o
 obj-$(CONFIG_FORCEDETH) += forcedeth.o
 obj-$(CONFIG_NE_H8300) += ne-h8300.o
