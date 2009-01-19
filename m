Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2009 14:10:28 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:48363 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21366094AbZASOKZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2009 14:10:25 +0000
Received: from localhost.localdomain (p1127-ipad204funabasi.chiba.ocn.ne.jp [222.146.88.127])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3ED37A47B; Mon, 19 Jan 2009 23:10:20 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-ide@vger.kernel.org
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org
Subject: [PATCH] tx4939ide: typo fix and minor cleanup
Date:	Mon, 19 Jan 2009 23:10:25 +0900
Message-Id: <1232374225-5325-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The bcount is greater than 0 and less than or equal to 0x10000.
Thus '(bcount & 0xffff) == 0x0000' can be simplified as 'bcount == 0x10000'.

Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4939ide.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index 882f6f0..40b0812 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -261,9 +261,9 @@ static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
 				bcount = cur_len;
 			/*
 			 * This workaround for zero count seems required.
-			 * (standard ide_build_dmatable do it too)
+			 * (standard ide_build_dmatable does it too)
 			 */
-			if ((bcount & 0xffff) == 0x0000)
+			if (bcount == 0x10000)
 				bcount = 0x8000;
 			*table++ = bcount & 0xffff;
 			*table++ = cur_addr;
-- 
1.5.6.3
