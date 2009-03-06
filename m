Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2009 16:22:06 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:35445 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21366486AbZCFQUU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2009 16:20:20 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 08:20:09 -0800
Received: from localhost.localdomain (unknown [10.8.0.23])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 15921EE76AD;
	Fri,  6 Mar 2009 09:42:11 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH 08/10] Alchemy: DB1300 blink leds on timer tick
Date:	Fri,  6 Mar 2009 10:20:07 -0600
Message-Id: <be27dee4c591cdb1ea1b9517bee2b825657024f5.1236354153.git.khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
References: <>
 <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
 <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
 <7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
 <0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
 <394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
 <7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
 <df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
In-Reply-To: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
References: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
X-OriginalArrivalTime: 06 Mar 2009 16:20:10.0043 (UTC) FILETIME=[6B9BA8B0:01C99E77]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22021
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
 arch/mips/alchemy/common/time.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index f58d4ff..2b2f6bf 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -39,6 +39,10 @@
 #include <asm/time.h>
 #include <asm/mach-au1x00/au1000.h>
 
+#ifdef CONFIG_MIPS_DB1300
+#include <dev_boards.h>
+#endif
+
 /* 32kHz clock enabled and detected */
 #define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
 
@@ -60,6 +64,11 @@ static struct clocksource au1x_counter1_clocksource = {
 static int au1x_rtcmatch2_set_next_event(unsigned long delta,
 					 struct clock_event_device *cd)
 {
+#ifdef CONFIG_MIPS_DB1300
+	static u8 dots = 1;
+	static u32 delayer = 0;
+#endif
+
 	delta += au_readl(SYS_RTCREAD);
 	/* wait for register access */
 	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M21)
@@ -67,6 +76,13 @@ static int au1x_rtcmatch2_set_next_event(unsigned long delta,
 	au_writel(delta, SYS_RTCMATCH2);
 	au_sync();
 
+#ifdef CONFIG_MIPS_DB1300
+	if (++delayer % 1000 == 0) {
+		db_set_hex_dots(dots++);
+		dots %= 4;
+	}
+#endif
+
 	return 0;
 }
 
-- 
1.5.4.3
