Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 14:50:38 +0000 (GMT)
Received: from mo30.po.2iij.NET ([210.128.50.53]:63043 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28600548AbYCQOuM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2008 14:50:12 +0000
Received: by mo.po.2iij.net (mo30) id m2HEo8Mx051564; Mon, 17 Mar 2008 23:50:08 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox304) id m2HEo13C025665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Mar 2008 23:50:01 +0900
Date:	Mon, 17 Mar 2008 23:47:40 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2][MIPS] replace c0_compare acknowledge by c0_timer_ack()
Message-Id: <20080317234740.705a8a34.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

VR41xx, CP0 hazard is necessary between read_c0_count() and write_c0_compare().
However, the problem can be solved by replacing this by c0_timer_ack(). 

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/kernel/cevt-r4k.c linux/arch/mips/kernel/cevt-r4k.c
--- linux-orig/arch/mips/kernel/cevt-r4k.c	2008-03-11 10:10:09.453835304 +0900
+++ linux/arch/mips/kernel/cevt-r4k.c	2008-03-12 16:35:42.911447048 +0900
@@ -186,7 +186,7 @@ static int c0_compare_int_usable(void)
 	 * IP7 already pending?  Try to clear it by acking the timer.
 	 */
 	if (c0_compare_int_pending()) {
-		write_c0_compare(read_c0_count());
+		c0_timer_ack();
 		irq_disable_hazard();
 		if (c0_compare_int_pending())
 			return 0;
@@ -198,7 +198,7 @@ static int c0_compare_int_usable(void)
 		write_c0_compare(cnt);
 		irq_disable_hazard();
 		if ((int)(read_c0_count() - cnt) < 0)
-		    break;
+			break;
 		/* increase delta if the timer was already expired */
 	}
 
@@ -208,7 +208,7 @@ static int c0_compare_int_usable(void)
 	if (!c0_compare_int_pending())
 		return 0;
 
-	write_c0_compare(read_c0_count());
+	c0_timer_ack();
 	irq_disable_hazard();
 	if (c0_compare_int_pending())
 		return 0;
