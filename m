Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 14:25:24 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:44514 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225305AbVAJOZU>;
	Mon, 10 Jan 2005 14:25:20 +0000
Received: MO(mo01)id j0AEPGT7024551; Mon, 10 Jan 2005 23:25:16 +0900 (JST)
Received: MDO(mdo00) id j0AEPFeq025707; Mon, 10 Jan 2005 23:25:16 +0900 (JST)
Received: 4UMRO00 id j0AEPEjx029050; Mon, 10 Jan 2005 23:25:15 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Mon, 10 Jan 2005 23:25:13 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: fixed gettimeoffset
Message-Id: <20050110232513.3296883a.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

My vr41xx gettimeoffset is wrong.
This patch changes vr41xx gettimeoffset to fixed rate gettimeoffset.

Please apply this patch to v2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/rtc.c a/arch/mips/vr41xx/common/rtc.c
--- a-orig/arch/mips/vr41xx/common/rtc.c	Thu May 27 02:11:11 2004
+++ a/arch/mips/vr41xx/common/rtc.c	Mon Jan 10 22:30:21 2005
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
 
