Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2006 15:04:48 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:8460 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133491AbWGDOEk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2006 15:04:40 +0100
Received: by mo.po.2iij.net (mo30) id k64E4chY074389; Tue, 4 Jul 2006 23:04:38 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k64E4WdD072675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jul 2006 23:04:32 +0900 (JST)
Date:	Tue, 4 Jul 2006 23:04:31 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: VR41_CONF_BP is necessary only for processor ID
 0xc80
Message-Id: <20060704230431.74fbe12b.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

VR41_CONF_BP is necessary only for processor ID 0xc80. 
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/mm/c-r4k.c mips/arch/mips/mm/c-r4k.c
--- mips-orig/arch/mips/mm/c-r4k.c	2006-07-04 11:54:18.405308250 +0900
+++ mips/arch/mips/mm/c-r4k.c	2006-07-04 22:45:11.862517750 +0900
@@ -848,7 +848,9 @@ static void __init probe_pcache(void)
 		if (c->processor_id == 0x0c80U || c->processor_id == 0x0c81U ||
 		    c->processor_id == 0x0c82U) {
 			config &= ~0x00000030U;
-			config |= 0x00410000U;
+			config |= 0x00400000U;
+			if (c->processor_id == 0x0c80U)
+				config |= VR41_CONF_BP;
 			write_c0_config(config);
 		}
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
