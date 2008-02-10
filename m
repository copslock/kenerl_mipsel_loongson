Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Feb 2008 19:32:04 +0000 (GMT)
Received: from bes.recconet.de ([212.227.59.164]:43923 "EHLO bes.recconet.de")
	by ftp.linux-mips.org with ESMTP id S20029073AbYBJTb4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 10 Feb 2008 19:31:56 +0000
Received: from trinity.recco.de (trinity.intern.recconet.de [192.168.11.241])
	by bes.recconet.de (8.13.1/8.13.1/Recconet-2005031001) with ESMTP id m1AJVbDQ007339;
	Sun, 10 Feb 2008 20:31:55 +0100
Received: from [172.16.135.104] (galileo.recco.de [172.16.135.104])
	(authenticated bits=0)
	by trinity.recco.de (8.13.1/8.13.1/Reccoware-2005061101) with ESMTP id m1AJVXEp032277;
	Sun, 10 Feb 2008 20:31:34 +0100
Subject: [PATCH] [MIPS] Fix ids in Alchemy db dma device table (Repost in
	hopefully correct format)
From:	Wolfgang Ocker <weo@reccoware.de>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: Reccoware Systems
Date:	Sun, 10 Feb 2008 20:31:33 +0100
Message-Id: <1202671893.3384.20.camel@galileo.recco.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
Content-Transfer-Encoding: 7bit
Return-Path: <weo@reccoware.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weo@reccoware.de
Precedence: bulk
X-list: linux-mips

From: Wolfgang Ocker <weo@reccoware.de>

0 is a valid device id (DSCR_CMD0_UART0_TX), so we can't use it to mark
an empty entry in the device table. Use ~0 instead and search for id ~0
when looking for a free entry.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---

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
