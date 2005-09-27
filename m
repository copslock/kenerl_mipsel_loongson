Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 20:47:17 +0100 (BST)
Received: from mail.glaze.se ([212.209.188.162]:31504 "HELO rocket.glaze.se")
	by ftp.linux-mips.org with SMTP id S8134392AbVI0Tqz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2005 20:46:55 +0100
Received: from IBMJP (unknown [10.42.1.6])
	by rocket.glaze.se (Postfix) with ESMTP id BB914376451
	for <linux-mips@linux-mips.org>; Tue, 27 Sep 2005 21:46:45 +0200 (CEST)
From:	"Jan Pedersen" <jan.pedersen@glaze.dk>
To:	<linux-mips@linux-mips.org>
Subject: [patch] cfi: removed warning message on expected behaivor
Date:	Tue, 27 Sep 2005 21:45:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 5 (Lowest)
X-MSMail-Priority: Low
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcXDnBGyK+lQCz6NQgKmvZ2YSgbPWg==
Importance: Low
Message-Id: <20050927194645.BB914376451@rocket.glaze.se>
Return-Path: <jan.pedersen@glaze.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.pedersen@glaze.dk
Precedence: bulk
X-list: linux-mips

When an erase operation is in progress, the DQ5 (data bit 5 / exceeded
timing limit) pin on the flash chips may raise just before operation
complete is detected. This is expected behaivor because when the erase is
complete, DQ5 switches from 'exceeded timing limit' to 'data bit 5' which
therefore might be read as '1' just before operation complete is detected.
This fix is well tested.

Signed-off-by: Jan Pedersen <jp@jp-embedded.com>
---
diff -Naur linux-2.4.31.org/drivers/mtd/chips/cfi_cmdset_0002.c
linux-2.4.31/drivers/mtd/chips/cfi_cmdset_0002.c
--- linux-2.4.31.org/drivers/mtd/chips/cfi_cmdset_0002.c	2004-11-17
06:54:21.000000000 -0500
+++ linux-2.4.31/drivers/mtd/chips/cfi_cmdset_0002.c	2005-08-22
12:14:17.000000000 -0400
@@ -950,12 +950,8 @@
 		    oldstatus   = cfi_read( map, adr );
 		    status      = cfi_read( map, adr );
 		    
-		    if( ( oldstatus & 0x00FF ) == ( status & 0x00FF ) )
+		    if( ( oldstatus & 0x00FF ) != ( status & 0x00FF ) )
 		    {
-                printk( "Warning: DQ5 raised while erase operation was in
progress, but erase completed OK\n" ); 		    
-		    } 			
-			else
-            {
 			    /* DQ5 is active so we can do a reset and stop
the erase */
 				cfi_write(map, CMD(0xF0), chip->start);
                 printk( KERN_WARNING "Internal flash device timeout occured
or write operation was performed while flash was erasing\n" );
