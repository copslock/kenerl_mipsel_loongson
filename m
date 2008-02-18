Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 14:05:07 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:16430 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28573943AbYBROFE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 14:05:04 +0000
Received: by mo.po.2iij.net (mo32) id m1IE51rE009848; Mon, 18 Feb 2008 23:05:01 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox304) id m1IE4xuS005073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 18 Feb 2008 23:05:00 +0900
Date:	Mon, 18 Feb 2008 23:04:59 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix the installation condition of MIPS clocksource
Message-Id: <20080218230459.35c2204b.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

MIPS clocksource has been installed on DEC 5000/200(R3000).
The installation condition of MIPS clocksource is wrong.

Yoichi

Fixed the installation condition of MIPS clocksource.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/kernel/time.c linux/arch/mips/kernel/time.c
--- linux-orig/arch/mips/kernel/time.c	2008-02-14 12:00:11.592089539 +0900
+++ linux/arch/mips/kernel/time.c	2008-02-14 17:14:42.619488102 +0900
@@ -157,6 +157,6 @@ void __init time_init(void)
 {
 	plat_time_init();
 
-	if (mips_clockevent_init() || !cpu_has_mfc0_count_bug())
+	if (!cpu_has_mfc0_count_bug() && !mips_clockevent_init())
 		init_mips_clocksource();
 }
