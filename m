Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 21:12:24 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:10670 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20039605AbXCBVKh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Mar 2007 21:10:37 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 4C8B78D1691
	for <linux-mips@linux-mips.org>; Fri,  2 Mar 2007 22:09:44 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: [PATCH 5/7] MTX1 clear PCI errors
Date:	Fri, 2 Mar 2007 22:08:01 +0100
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xIJ6FubBCfdGaI9"
Message-Id: <200703022208.01454.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_xIJ6FubBCfdGaI9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch clears PCI errors after showing more debug informations.

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
-- 

--Boundary-00=_xIJ6FubBCfdGaI9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="009-pci_clear_errors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="009-pci_clear_errors.patch"

diff -urN linux-2.6.19/arch/mips/pci/ops-au1000.c linux-2.6.19.new/arch/mips/pci/ops-au1000.c
--- linux-2.6.19/arch/mips/pci/ops-au1000.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19.new/arch/mips/pci/ops-au1000.c	2006-12-28 03:02:42.000000000 +0100
@@ -172,7 +172,11 @@
 		error = -1;
 		DBG("Au1x Master Abort\n");
 	} else if ((status >> 28) & 0xf) {
-		DBG("PCI ERR detected: status %x\n", status);
+		DBG("PCI ERR detected: device %d, status %x\n", device, ((status >> 28) & 0xf));
+		
+		/* clear errors */
+		au_writel(status & 0xf000ffff, Au1500_PCI_STATCMD);		
+
 		*data = 0xffffffff;
 		error = -1;
 	}

--Boundary-00=_xIJ6FubBCfdGaI9--
