Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2006 16:05:01 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:22835 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039183AbWJGPFA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Oct 2006 16:05:00 +0100
Received: by mo.po.2iij.net (mo32) id k97F4vYV054737; Sun, 8 Oct 2006 00:04:57 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k97F4qHK067300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 8 Oct 2006 00:04:52 +0900 (JST)
Date:	Sat, 7 Oct 2006 13:41:51 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	ralf@linux-mips.org
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH] fix DECserial build error by IRQ hander change
Message-Id: <20061007134151.27c09f49.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061007003516.5eec677e.yoichi_yuasa@tripeaks.co.jp>
References: <20061007003516.5eec677e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

One more fix for zs.c .

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>


diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/tc/zs.c mips/drivers/tc/zs.c
--- mips-orig/drivers/tc/zs.c	2006-10-07 23:51:44.882996750 +0900
+++ mips/drivers/tc/zs.c	2006-10-07 23:55:33.909310000 +0900
@@ -389,7 +389,7 @@ static void receive_chars(struct dec_ser
 			if (ch == 0)
 				continue;
 			if (time_before(jiffies, break_pressed + HZ * 5)) {
-				handle_sysrq(ch, regs, NULL);
+				handle_sysrq(ch, NULL);
 				break_pressed = 0;
 				continue;
 			}
