Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 11:29:27 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:36251 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S22493166AbYJ0L3P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 11:29:15 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 6F2EBC8103;
	Mon, 27 Oct 2008 13:29:09 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id czJRlxHuSGAW; Mon, 27 Oct 2008 13:29:09 +0200 (EET)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 53E03C80FD;
	Mon, 27 Oct 2008 13:29:09 +0200 (EET)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 09910108020; Mon, 27 Oct 2008 13:29:08 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Subject: [PATCH] [MIPS] DS1286: kill BKL
Date:	Mon, 27 Oct 2008 13:29:08 +0200
Message-Id: <1225106948-30550-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Using the Big Kernel Lock in the open() method of the DS1286
RTC driver is redundant, because the driver makes use of it's
own spinlock to guarantee serialized access. This patch kills
the redundant BKL calls.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 drivers/char/ds1286.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ds1286.c b/drivers/char/ds1286.c
index 0a826d7..3e4c801 100644
--- a/drivers/char/ds1286.c
+++ b/drivers/char/ds1286.c
@@ -253,7 +253,6 @@ static int ds1286_ioctl(struct inode *inode, struct file *file,
 
 static int ds1286_open(struct inode *inode, struct file *file)
 {
-	lock_kernel();
 	spin_lock_irq(&ds1286_lock);
 
 	if (ds1286_status & RTC_IS_OPEN)
@@ -262,12 +261,10 @@ static int ds1286_open(struct inode *inode, struct file *file)
 	ds1286_status |= RTC_IS_OPEN;
 
 	spin_unlock_irq(&ds1286_lock);
-	unlock_kernel();
 	return 0;
 
 out_busy:
 	spin_lock_irq(&ds1286_lock);
-	unlock_kernel();
 	return -EBUSY;
 }
 
-- 
1.5.6.5
