Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 21:11:29 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:7054 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20039616AbXCBVKR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Mar 2007 21:10:17 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id AD75C8D1695
	for <linux-mips@linux-mips.org>; Fri,  2 Mar 2007 22:09:24 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: [PATCH 3/7] MTX1 setup : remove unneeded settings
Date:	Fri, 2 Mar 2007 22:07:41 +0100
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dIJ6FCkMyOVD+Uz"
Message-Id: <200703022207.41964.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_dIJ6FCkMyOVD+Uz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch removes unnecessary settings at setup time.

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
--

--Boundary-00=_dIJ6FCkMyOVD+Uz
Content-Type: text/plain;
  charset="iso-8859-1";
  name="007-mtx1_sio2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="007-mtx1_sio2.patch"

--- linux-2.6.16.7/arch/mips/au1000/mtx-1/board_setup.c	2006-04-17 23:53:25.000000000 +0200
+++ linux-2.6.16.7.new/arch/mips/au1000/mtx-1/board_setup.c	2006-04-23 14:35:42.000000000 +0200
@@ -71,9 +71,7 @@
 #endif
 
 	// initialize sys_pinfunc:
-	// disable second ethernet port (SYS_PF_NI2)
-	// set U3/GPIO23 to GPIO23 (SYS_PF_U3)
-	au_writel( SYS_PF_NI2 | SYS_PF_U3, SYS_PINFUNC );
+	au_writel( SYS_PF_NI2, SYS_PINFUNC );
 
 	// initialize GPIO
 	au_writel( 0xFFFFFFFF, SYS_TRIOUTCLR );

--Boundary-00=_dIJ6FCkMyOVD+Uz--
