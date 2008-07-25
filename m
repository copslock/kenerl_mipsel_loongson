Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 18:52:49 +0100 (BST)
Received: from smtp.wellnetcz.com ([212.24.148.102]:53162 "EHLO
	smtp.wellnetcz.com") by ftp.linux-mips.org with ESMTP
	id S28580240AbYGYRwr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jul 2008 18:52:47 +0100
Received: from localhost.localdomain ([88.208.94.142])
	by smtp.wellnetcz.com (8.14.1/8.14.1) with ESMTP id m6PIAFq5009830;
	Fri, 25 Jul 2008 20:10:16 +0200
From:	Jiri Slaby <jirislaby@gmail.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/1] Char: ds1286, eliminate busy waiting
Date:	Fri, 25 Jul 2008 19:49:58 +0200
Message-Id: <1217008198-17143-1-git-send-email-jirislaby@gmail.com>
X-Mailer: git-send-email 1.5.6.2
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jirislaby@gmail.com
Precedence: bulk
X-list: linux-mips

ds1286_get_time(); is not called from atomic context, sleep for 20 ms is
better choice than a (home-made) busy waiting for such a situation.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/char/ds1286.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ds1286.c b/drivers/char/ds1286.c
index fb58493..5329d48 100644
--- a/drivers/char/ds1286.c
+++ b/drivers/char/ds1286.c
@@ -443,7 +443,6 @@ static void ds1286_get_time(struct rtc_time *rtc_tm)
 {
 	unsigned char save_control;
 	unsigned long flags;
-	unsigned long uip_watchdog = jiffies;
 
 	/*
 	 * read RTC once any update in progress is done. The update
@@ -456,8 +455,7 @@ static void ds1286_get_time(struct rtc_time *rtc_tm)
 	 */
 
 	if (ds1286_is_updating() != 0)
-		while (time_before(jiffies, uip_watchdog + 2*HZ/100))
-			barrier();
+		msleep(20);
 
 	/*
 	 * Only the values that we read from the RTC are set. We leave
-- 
1.5.6.2
