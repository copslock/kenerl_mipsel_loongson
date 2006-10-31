Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 04:45:22 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:31256 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027663AbWJaEpV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2006 04:45:21 +0000
Received: by mo.po.2iij.net (mo30) id k9V4jGE3099691; Tue, 31 Oct 2006 13:45:16 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id k9V4jFXT012552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Oct 2006 13:45:15 +0900 (JST)
Message-Id: <200610310445.k9V4jFXT012552@mbox33.po.2iij.net>
Date:	Tue, 31 Oct 2006 13:40:07 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix wrong prom_getcmdline() definition
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed wrong prom_getcmdline() definition.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/common/setup.c mips/arch/mips/au1000/common/setup.c
--- mips-orig/arch/mips/au1000/common/setup.c	2006-10-24 11:07:06.417642500 +0900
+++ mips/arch/mips/au1000/common/setup.c	2006-10-24 13:10:40.602987750 +0900
@@ -43,7 +43,7 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/time.h>
 
-extern char * __init prom_getcmdline(void);
+extern char *prom_getcmdline(void);
 extern void __init board_setup(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
