Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2008 11:15:59 +0000 (GMT)
Received: from bes.recconet.de ([212.227.59.164]:2505 "EHLO bes.recconet.de")
	by ftp.linux-mips.org with ESMTP id S20035316AbYBFLPu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Feb 2008 11:15:50 +0000
Received: from trinity.recco.de (trinity.intern.recconet.de [192.168.11.241])
	by bes.recconet.de (8.13.1/8.13.1/Recconet-2005031001) with ESMTP id m16BFo3p006790
	for <linux-mips@linux-mips.org>; Wed, 6 Feb 2008 12:15:50 +0100
Received: from trinity.recco.de (localhost.localdomain [127.0.0.1])
	by trinity.recco.de (8.13.1/8.13.1/Reccoware-2005061101) with ESMTP id m16BFkoO004327
	for <linux-mips@linux-mips.org>; Wed, 6 Feb 2008 12:15:46 +0100
Received: (from apache@localhost)
	by trinity.recco.de (8.13.1/8.13.1/Reccoware-Submit-2005061101) id m16BFkME004324;
	Wed, 6 Feb 2008 12:15:46 +0100
X-Authentication-Warning: trinity.recco.de: apache set sender to weo@reccoware.de using -f
Received: from 217.91.120.40
        (SquirrelMail authenticated user weo)
        by morpheus.dyn.recconet.de with HTTP;
        Wed, 6 Feb 2008 12:15:46 +0100 (CET)
Message-ID: <1846.217.91.120.40.1202296546.squirrel@morpheus.dyn.recconet.de>
Date:	Wed, 6 Feb 2008 12:15:46 +0100 (CET)
Subject: au1xxx dbdma.c minor fix proposal
From:	"Wolfgang Ocker" <weo@reccoware.de>
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.8-4.0.1.el4.centos
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20080206121546_79237"
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <weo@reccoware.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weo@reccoware.de
Precedence: bulk
X-list: linux-mips

------=_20080206121546_79237
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Attached a minor patch for dbdma.c:

"""0 is a valid device id (DSCR_CMD0_UART0_TX), so we can't use it to mark
an empty entry in the device table. Use ~0 instead and search for id ~0 when
looking for a free entry."""

Wolfgang
------=_20080206121546_79237
Content-Type: text/x-patch; name="dbdma_devtab_fix.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dbdma_devtab_fix.patch"

0 is a valid device id (DSCR_CMD0_UART0_TX), so we can't use it to mark
an empty entry in the device table. Use ~0 instead and search for id ~0 when
looking for a free entry.

diff -up linux-2.6.24/arch/mips/au1000/common/dbdma.c.devtab_fix linux-2.6.24/arch/mips/au1000/common/dbdma.c
--- linux-2.6.24/arch/mips/au1000/common/dbdma.c.devtab_fix	2008-01-24 23:58:37.000000000 +0100
+++ linux-2.6.24/arch/mips/au1000/common/dbdma.c	2008-02-06 11:51:16.000000000 +0100
@@ -161,22 +161,22 @@ static dbdev_tab_t dbdev_tab[] = {
 	{ DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
 
 	/* Provide 16 user definable device types */
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
+	{ ~0, 0, 0, 0, 0, 0, 0 },
 };
 
 #define DBDEV_TAB_SIZE (sizeof(dbdev_tab) / sizeof(dbdev_tab_t))
@@ -209,7 +209,7 @@ au1xxx_ddma_add_device(dbdev_tab_t *dev)
 	dbdev_tab_t *p=NULL;
 	static u16 new_id=0x1000;
 
-	p = find_dbdev_id(0);
+	p = find_dbdev_id(~0);
 	if ( NULL != p )
 	{
 		memcpy(p, dev, sizeof(dbdev_tab_t));
------=_20080206121546_79237--
