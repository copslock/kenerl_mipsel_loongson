Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 13:46:24 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:51518 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037407AbYBGNpW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2008 13:45:22 +0000
Received: by mo.po.2iij.net (mo31) id m17DjJAu000665; Thu, 7 Feb 2008 22:45:19 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox304) id m17DjISA004480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Feb 2008 22:45:18 +0900
Date:	Thu, 7 Feb 2008 22:41:40 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][4/5][MIPS] remove lasat unused functions
Message-Id: <20080207224140.30878819.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080207223945.32f20b2d.yoichi_yuasa@tripeaks.co.jp>
References: <20080207222601.def26d7d.yoichi_yuasa@tripeaks.co.jp>
	<20080207222717.7d58f50a.yoichi_yuasa@tripeaks.co.jp>
	<20080207223945.32f20b2d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Removed lasat unused functions.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/lasat/setup.c mips/arch/mips/lasat/setup.c
--- mips-orig/arch/mips/lasat/setup.c	2007-11-13 17:14:03.236286250 +0900
+++ mips/arch/mips/lasat/setup.c	2007-11-13 17:14:33.802196500 +0900
@@ -46,13 +46,7 @@
 
 #include "prom.h"
 
-int lasat_command_line;
-void lasatint_init(void);
-
 extern void lasat_reboot_setup(void);
-extern void pcisetup(void);
-extern void edhac_init(void *, void *, void *);
-extern void addrflt_init(void);
 
 struct lasat_misc lasat_misc_info[N_MACHTYPES] = {
 	{
