Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2005 16:10:18 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:29695 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224912AbVAWQKM>;
	Sun, 23 Jan 2005 16:10:12 +0000
Received: MO(mo01)id j0NGA9fw022747; Mon, 24 Jan 2005 01:10:09 +0900 (JST)
Received: MDO(mdo00) id j0NGA8PJ005802; Mon, 24 Jan 2005 01:10:09 +0900 (JST)
Received: 4UMRO00 id j0NGA7hq017035; Mon, 24 Jan 2005 01:10:08 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date:	Mon, 24 Jan 2005 01:10:05 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp
Subject: [resend]]PATCH 2.6] vr41xx: fixed gettimeoffset
Message-Id: <20050124011005.10bb9d14.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

VR41xx gettimeoffset is wrong.
This patch changes vr41xx gettimeoffset to fixed rate gettimeoffset.

Please apply this patch to v2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/rtc.c a/arch/mips/vr41xx/common/rtc.c
--- a-orig/arch/mips/vr41xx/common/rtc.c	Thu May 27 02:11:11 2004
+++ a/arch/mips/vr41xx/common/rtc.c	Sat Jan 22 22:24:33 2005
@@ -1,7 +1,7 @@
 /*
  *  rtc.c, RTC(has only timer function) routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -188,7 +188,7 @@
 
 	if (cycles_per_sec >= CLOCK_TICK_RATE) {
 		cycles_per_sec = 0;
-		remainder_per_sec = REMAINDER_PER_SEC;
+		remainder_per_sec += REMAINDER_PER_SEC;
 	}
 
 	cycles_per_jiffy = 0;
@@ -219,18 +219,6 @@
 	return (unsigned int)cur;
 }
 
-static unsigned long vr41xx_gettimeoffset(void)
-{
-	uint64_t cur;
-	unsigned long gap;
-
-	cur = read_elapsedtime_counter();
-	gap = (unsigned long)(cur - previous_elapsedtime);
-	gap = gap / CYCLES_PER_100USEC * 100;	/* usec */
-
-	return gap;
-}
-
 static unsigned long vr41xx_get_time(void)
 {
 	uint64_t counts;
@@ -293,8 +281,6 @@
 
 static void __init vr41xx_timer_setup(struct irqaction *irq)
 {
-	do_gettimeoffset = vr41xx_gettimeoffset;
-
 	remainder_per_sec = REMAINDER_PER_SEC;
 	cycles_per_jiffy = CYCLES_PER_JIFFY;
 
