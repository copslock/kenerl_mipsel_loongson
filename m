Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2007 14:55:36 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:15160 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021971AbXHPNz2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2007 14:55:28 +0100
Received: by mo.po.2iij.net (mo30) id l7GDsAZF023563; Thu, 16 Aug 2007 22:54:10 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox302) id l7GDs31c013057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Aug 2007 22:54:04 +0900
Date:	Thu, 16 Aug 2007 22:54:02 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unneeded extern dump_tlb_all()
Message-Id: <20070816225402.3e862d42.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unneeded extern dump_tlb_all().
It already include tlbdebug.h .

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/sgi-ip27/ip27-berr.c mips/arch/mips/sgi-ip27/ip27-berr.c
--- mips-orig/arch/mips/sgi-ip27/ip27-berr.c	2007-08-16 14:14:01.953246500 +0900
+++ mips/arch/mips/sgi-ip27/ip27-berr.c	2007-08-16 14:43:27.167565500 +0900
@@ -21,8 +21,6 @@
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 
-extern void dump_tlb_all(void);
-
 static void dump_hub_information(unsigned long errst0, unsigned long errst1)
 {
 	static char *err_type[2][8] = {
