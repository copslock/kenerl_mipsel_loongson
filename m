Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2004 15:30:10 +0000 (GMT)
Received: from fed1rmmtao09.cox.net ([IPv6:::ffff:68.230.241.30]:3477 "EHLO
	fed1rmmtao09.cox.net") by linux-mips.org with ESMTP
	id <S8224893AbUKKPaF>; Thu, 11 Nov 2004 15:30:05 +0000
Received: from opus ([68.107.143.141]) by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-117-20041022) with ESMTP
          id <20041111152955.VGOH14545.fed1rmmtao09.cox.net@opus>
          for <linux-mips@linux-mips.org>; Thu, 11 Nov 2004 10:29:55 -0500
Date: Thu, 11 Nov 2004 08:29:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-mips@linux-mips.org
Subject: [PATCH] Remove duplicates from drivers/mtd/maps/Makefile
Message-ID: <20041111152955.GF3815@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

There are 2 duplicate entries in drivers/mtd/maps/Makefile only found in
CVS.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- drivers/mtd/maps/Makefile	25 Oct 2004 20:44:27 -0000	1.19
+++ drivers/mtd/maps/Makefile	11 Nov 2004 15:28:11 -0000
@@ -42,11 +42,9 @@ obj-$(CONFIG_MTD_VMAX)		+= vmax301.o
 obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
 obj-$(CONFIG_MTD_DBOX2)		+= dbox2-flash.o
 obj-$(CONFIG_MTD_OCELOT)	+= ocelot.o
-obj-$(CONFIG_MTD_LASAT)		+= lasat.o
 obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
 obj-$(CONFIG_MTD_PCI)		+= pci.o
 obj-$(CONFIG_MTD_LASAT)		+= lasat.o
-obj-$(CONFIG_MTD_DB1X00)	+= db1x00-flash.o
 obj-$(CONFIG_MTD_PB1550)	+= pb1550-flash.o
 obj-$(CONFIG_MTD_DB1550)	+= db1550-flash.o
 obj-$(CONFIG_MTD_AUTCPU12)	+= autcpu12-nvram.o

-- 
Tom Rini
http://gate.crashing.org/~trini/
