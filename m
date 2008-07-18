Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 15:03:29 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:11821 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027098AbYGROD1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 15:03:27 +0100
Received: by mo.po.2iij.net (mo32) id m6IE3M9Y076254; Fri, 18 Jul 2008 23:03:22 +0900 (JST)
Received: from delta (16.26.30.125.dy.iij4u.or.jp [125.30.26.16])
	by mbox.po.2iij.net (po-mbox302) id m6IE3FmU009358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 18 Jul 2008 23:03:15 +0900
Date:	Fri, 18 Jul 2008 23:03:15 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix Cobalt I/O port resource range
Message-Id: <20080718230315.7a08ffed.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

LCD and buttons don't use I/O port space.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/cobalt/setup.c linux/arch/mips/cobalt/setup.c
--- linux-orig/arch/mips/cobalt/setup.c	2008-07-15 20:05:40.933592594 +0900
+++ linux/arch/mips/cobalt/setup.c	2008-07-15 20:04:49.034635042 +0900
@@ -81,8 +81,8 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
-	/* I/O port resource must include LCD/buttons */
-	ioport_resource.end = 0x0fffffff;
+	/* I/O port resource */
+	ioport_resource.end = 0x01ffffff;
 
 	/* These resources have been reserved by VIA SuperI/O chip. */
 	for (i = 0; i < ARRAY_SIZE(cobalt_reserved_resources); i++)
