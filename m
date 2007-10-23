Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 10:24:05 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:42052 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027665AbXJWJX0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 10:23:26 +0100
Received: by mo.po.2iij.net (mo31) id l9N9M8U5067964; Tue, 23 Oct 2007 18:22:08 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l9N9M6qs011258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Oct 2007 18:22:06 +0900
Message-Id: <200710230922.l9N9M6qs011258@po-mbox302.po.2iij.net>
Date:	Tue, 23 Oct 2007 18:22:50 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2/2][MIPS] move clockevent_set_clock() before
 clockevent_delta2ns()
In-Reply-To: <20071023181913.252daa3e.yoichi_yuasa@tripeaks.co.jp>
References: <20071023181913.252daa3e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


clockevent_delta2ns() use shift and mult value.
It should call clockevent_set_clock() first.
Pointed out by Atsushi Nemoto.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/cevt-gt641xx.c mips/arch/mips/kernel/cevt-gt641xx.c
--- mips-orig/arch/mips/kernel/cevt-gt641xx.c	2007-10-23 16:29:19.831141250 +0900
+++ mips/arch/mips/kernel/cevt-gt641xx.c	2007-10-23 16:29:09.702508250 +0900
@@ -131,9 +131,9 @@ static int __init gt641xx_timer0_clockev
 
 	cd = &gt641xx_timer0_clockevent;
 	cd->rating = 200 + gt641xx_base_clock / 10000000;
+	clockevent_set_clock(cd, gt641xx_base_clock);
 	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
 	cd->min_delta_ns = clockevent_delta2ns(0x300, cd);
-	clockevent_set_clock(cd, gt641xx_base_clock);
 
 	clockevents_register_device(&gt641xx_timer0_clockevent);
 
