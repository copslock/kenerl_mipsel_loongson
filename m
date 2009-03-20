Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2009 20:54:08 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:60824 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21369947AbZCTUwC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2009 20:52:02 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Mar 2009 13:51:49 -0700
Received: from localhost.localdomain (unknown [10.8.0.60])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 3FAA1EE76DC;
	Fri, 20 Mar 2009 14:11:47 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH v2 5/6] Alchemy: DB1300 blink leds on timer tick
Date:	Fri, 20 Mar 2009 15:51:45 -0500
Message-Id: <1237582306-10800-6-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1237582306-10800-5-git-send-email-khickey@rmicorp.com>
References: <>
 <1237582306-10800-1-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-2-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-3-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-4-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-5-git-send-email-khickey@rmicorp.com>
X-OriginalArrivalTime: 20 Mar 2009 20:51:49.0883 (UTC) FILETIME=[B0DA5CB0:01C9A99D]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Blinks the dots on the hex display on the DB1300 board every 1000 timer ticks.
This can help tell the difference between a soft and hard hung board.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 arch/mips/alchemy/common/time.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index f58d4ff..d2352c5 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -57,6 +57,8 @@ static struct clocksource au1x_counter1_clocksource = {
 	.rating		= 100,
 };
 
+void (*board_timer_ticked)(void) = NULL;
+
 static int au1x_rtcmatch2_set_next_event(unsigned long delta,
 					 struct clock_event_device *cd)
 {
@@ -67,6 +69,9 @@ static int au1x_rtcmatch2_set_next_event(unsigned long delta,
 	au_writel(delta, SYS_RTCMATCH2);
 	au_sync();
 
+	if (board_timer_ticked)
+		board_timer_ticked();
+
 	return 0;
 }
 
-- 
1.5.4.3
