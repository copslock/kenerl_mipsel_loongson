Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 20:26:19 +0100 (BST)
Received: from mail.glaze.se ([212.209.188.162]:30480 "HELO rocket.glaze.se")
	by ftp.linux-mips.org with SMTP id S8133807AbVI0TZ4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2005 20:25:56 +0100
Received: from IBMJP (unknown [10.42.1.6])
	by rocket.glaze.se (Postfix) with ESMTP id CAD8F376451
	for <linux-mips@linux-mips.org>; Tue, 27 Sep 2005 21:25:43 +0200 (CEST)
From:	"Jan Pedersen" <jan.pedersen@glaze.dk>
To:	<linux-mips@linux-mips.org>
Subject: [patch] cfi: prevent kernel panic with cfi flash
Date:	Tue, 27 Sep 2005 21:25:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcXDmT38L9K3z4xqSdqdZy3CMt6npQ==
Message-Id: <20050927192543.CAD8F376451@rocket.glaze.se>
Return-Path: <jan.pedersen@glaze.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.pedersen@glaze.dk
Precedence: bulk
X-list: linux-mips

When using the cfi (common flash interface) driver, every word written to
the flash chips is followed by a operation complete poll. This poll is
intended to have a timeout of 1 ms. However this timeout is calculated by
HZ/1000, which happends to be 0 because HZ < 1000. The result of this is
that there will be just one poll for operation complete. If this single poll
fails, the kernel panics. This patch increases this timeout to HZ (1
second). This is far more than needed, but is preferred over a panic. This
fix is well tested and completely avoids the panic.

Signed-off-by: Jan Pedersen <jp@jp-embedded.com>
---
diff -Naur linux-2.4.31.org/drivers/mtd/chips/cfi_cmdset_0002.c
linux-2.4.31/drivers/mtd/chips/cfi_cmdset_0002.c
--- linux-2.4.31.org/drivers/mtd/chips/cfi_cmdset_0002.c	2004-11-17
06:54:21.000000000 -0500
+++ linux-2.4.31/drivers/mtd/chips/cfi_cmdset_0002.c	2005-08-22
12:14:17.000000000 -0400
@@ -510,7 +510,7 @@
 	   or tells us why it failed. */        
 	dq6 = CMD(1<<6);
 	dq5 = CMD(1<<5);
-	timeo = jiffies + (HZ/1000); /* setting timeout to 1ms for now */
+	timeo = jiffies + (HZ); /* setting timeout to 1s for now */
 		
 	oldstatus = cfi_read(map, adr);
 	status = cfi_read(map, adr);
