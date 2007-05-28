Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2007 15:15:13 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:3138 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022439AbXE1OPM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2007 15:15:12 +0100
Received: by mo.po.2iij.net (mo31) id l4SEDsje079899; Mon, 28 May 2007 23:13:54 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox32) id l4SEDplY005459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 28 May 2007 23:13:52 +0900 (JST)
Date:	Mon, 28 May 2007 23:13:50 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix wrong cast
Message-Id: <20070528231350.1f256044.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed wrong cast.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/au1000/pb1100/init.c generic/arch/mips/au1000/pb1100/init.c
--- generic-orig/arch/mips/au1000/pb1100/init.c	2007-03-23 11:00:22.462630500 +0900
+++ generic/arch/mips/au1000/pb1100/init.c	2007-03-23 17:07:27.210831500 +0900
@@ -53,7 +53,7 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	prom_argv = (char **) fw_arg1;
-	prom_envp = (int *) fw_arg3;
+	prom_envp = (char **) fw_arg3;
 
 	mips_machgroup = MACH_GROUP_ALCHEMY;
 	mips_machtype = MACH_PB1100;
