Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2005 22:58:18 +0000 (GMT)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:28179
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3466982AbVKNW6B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Nov 2005 22:58:01 +0000
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id jAEMxpBx006748
	for <linux-mips@linux-mips.org>; Mon, 14 Nov 2005 14:59:51 -0800
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id jAEMxnub006745;
	Mon, 14 Nov 2005 14:59:49 -0800
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.5861.51238.726136@dl2.hq2.avtrex.com>
Date:	Mon, 14 Nov 2005 14:59:49 -0800
To:	linux-mips@linux-mips.org
Subject: [PATCH] Fix build in ide-dma.c
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


When in_drive_list was renamed to ide_in_drive_list, several
occurrences were missed.  This patch allows me to build.

David Daney


diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -665,7 +665,7 @@ int __ide_dma_bad_drive (ide_drive_t *dr
 {
 	struct hd_driveid *id = drive->id;
 
-	int blacklist = in_drive_list(id, drive_blacklist);
+	int blacklist = ide_in_drive_list(id, drive_blacklist);
 	if (blacklist) {
 		printk(KERN_WARNING "%s: Disabling (U)DMA for %s (blacklisted)\n",
 				    drive->name, id->model);
@@ -679,7 +679,7 @@ EXPORT_SYMBOL(__ide_dma_bad_drive);
 int __ide_dma_good_drive (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
-	return in_drive_list(id, drive_whitelist);
+	return ide_in_drive_list(id, drive_whitelist);
 }
 
 EXPORT_SYMBOL(__ide_dma_good_drive);
