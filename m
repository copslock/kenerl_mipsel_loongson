Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2007 15:27:08 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:60996 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022507AbXE1O1G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2007 15:27:06 +0100
Received: by mo.po.2iij.net (mo30) id l4SER4pb059841; Mon, 28 May 2007 23:27:04 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox32) id l4SEQxxv011683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 28 May 2007 23:26:59 +0900 (JST)
Date:	Mon, 28 May 2007 23:26:56 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix pb1500 reg B access
Message-Id: <20070528232656.5f0a568c.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I think that au_readl() is correct here.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/au1000/pb1500/board_setup.c generic/arch/mips/au1000/pb1500/board_setup.c
--- generic-orig/arch/mips/au1000/pb1500/board_setup.c	2007-03-23 11:00:22.474631250 +0900
+++ generic/arch/mips/au1000/pb1500/board_setup.c	2007-03-23 17:09:27.070322250 +0900
@@ -125,7 +125,7 @@ void __init board_setup(void)
 		au_writel((au_readl(0xac000028) | 0x20), 0xac000028);
 	}
 	/* Put the clock in BCD mode */
-	if (readl(0xac00002C) & 0x4) { /* reg B */
+	if (au_readl(0xac00002C) & 0x4) { /* reg B */
 		au_writel(au_readl(0xac00002c) & ~0x4, 0xac00002c);
 		au_sync();
 	}
