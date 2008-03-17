Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 14:50:14 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:9741 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28600547AbYCQOuM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2008 14:50:12 +0000
Received: by mo.po.2iij.net (mo31) id m2HEo86q009421; Mon, 17 Mar 2008 23:50:08 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox300) id m2HEo2eM019042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Mar 2008 23:50:03 +0900
Date:	Mon, 17 Mar 2008 23:49:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2][MIPS] add irq_disable_hazard() before
 c0_compare_int_pending()
Message-Id: <20080317234942.37ebfcee.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080317234740.705a8a34.yoichi_yuasa@tripeaks.co.jp>
References: <20080317234740.705a8a34.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add irq_disable_hazard() before c0_compare_int_pending().

VR41xx sometime fails at this point.
It can be fix this patch.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/kernel/cevt-r4k.c linux/arch/mips/kernel/cevt-r4k.c
--- linux-orig/arch/mips/kernel/cevt-r4k.c	2008-03-12 16:37:31.317624763 +0900
+++ linux/arch/mips/kernel/cevt-r4k.c	2008-03-12 16:37:39.894113510 +0900
@@ -205,6 +205,7 @@ static int c0_compare_int_usable(void)
 	while ((int)(read_c0_count() - cnt) <= 0)
 		;	/* Wait for expiry  */
 
+	irq_disable_hazard();
 	if (!c0_compare_int_pending())
 		return 0;
 
