Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 01:53:54 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:14378 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8134002AbWFGAxo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 01:53:44 +0100
Received: by mo.po.2iij.net (mo30) id k570rdI4067334; Wed, 7 Jun 2006 09:53:39 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k570rYGY062869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 7 Jun 2006 09:53:34 +0900 (JST)
Date:	Wed, 7 Jun 2006 09:53:34 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] cobalt: fixed undefined reference to `disable_early_printk'
Message-Id: <20060607095334.156f19a0.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch has fixed build error about cobalt.

drivers/built-in.o: In function `console_init':
: undefined reference to `disable_early_printk'
make: *** [.tmp_vmlinux1] Error 1

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X dontdiff rc5-orig/arch/mips/cobalt/console.c rc5/arch/mips/cobalt/console.c
--- rc5-orig/arch/mips/cobalt/console.c	2006-06-06 10:29:30.278755250 +0900
+++ rc5/arch/mips/cobalt/console.c	2006-06-05 23:32:59.877242000 +0900
@@ -41,3 +41,8 @@ void __init cobalt_early_console(void)
 
 	printk("Cobalt: early console registered\n");
 }
+
+void __init disable_early_printk(void)
+{
+	unregister_console(&cons_info);
+}
