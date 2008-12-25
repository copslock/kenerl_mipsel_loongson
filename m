Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2008 14:32:48 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57327 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S24132650AbYLYOcp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2008 14:32:45 +0000
Received: from localhost.localdomain (p5019-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.19])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0585AA420; Thu, 25 Dec 2008 23:32:39 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-ide@vger.kernel.org
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	stable <stable@kernel.org>
Subject: [PATCH] tx4939ide: Do not use zero count PRD entry
Date:	Thu, 25 Dec 2008 23:32:37 +0900
Message-Id: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fixes data corruption on some heavy load.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: stable <stable@kernel.org>
---
 drivers/ide/tx4939ide.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index bafb7d1..30d0d25 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -259,6 +259,12 @@ static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
 			bcount = 0x10000 - (cur_addr & 0xffff);
 			if (bcount > cur_len)
 				bcount = cur_len;
+			/*
+			 * This workaround for zero count seems required.
+			 * (standard ide_build_dmatable do it too)
+			 */
+			if ((bcount & 0xffff) == 0x0000)
+				bcount = 0x8000;
 			*table++ = bcount & 0xffff;
 			*table++ = cur_addr;
 			cur_addr += bcount;
-- 
1.5.6.3
