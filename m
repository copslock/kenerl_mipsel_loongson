Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 13:09:18 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:23265 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22580646AbYJ1NJJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 13:09:09 +0000
Received: from localhost (p3097-ipad313funabasi.chiba.ocn.ne.jp [123.217.229.97])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1D268ADBE; Tue, 28 Oct 2008 22:09:03 +0900 (JST)
Date:	Tue, 28 Oct 2008 22:09:04 +0900 (JST)
Message-Id: <20081028.220904.128617360.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: [PATCH] tx4938ide: Avoid underflow on calculation of a wait cycle
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make 'wt' variable signed while it can be negative during calculation.

Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4938ide.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 796289c..9120063 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -26,12 +26,13 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
 	unsigned int sp = (cr >> 4) & 3;
 	unsigned int clock = gbus_clock / (4 - sp);
 	unsigned int cycle = 1000000000 / clock;
-	unsigned int wt, shwt;
+	unsigned int shwt;
+	int wt;
 
 	/* Minimum DIOx- active time */
 	wt = DIV_ROUND_UP(t->act8b, cycle) - 2;
 	/* IORDY setup time: 35ns */
-	wt = max(wt, DIV_ROUND_UP(35, cycle));
+	wt = max_t(int, wt, DIV_ROUND_UP(35, cycle));
 	/* actual wait-cycle is max(wt & ~1, 1) */
 	if (wt > 2 && (wt & 1))
 		wt++;
-- 
1.5.6.3
