Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 16:51:29 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:56842 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133498AbWGGPvU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 16:51:20 +0100
Received: by mo.po.2iij.net (mo32) id k67FpHfY065727; Sat, 8 Jul 2006 00:51:17 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k67FpCrB032453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 8 Jul 2006 00:51:13 +0900 (JST)
Date:	Sat, 8 Jul 2006 00:51:11 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] removed vmlinux.rm200
Message-Id: <20060708005111.12a066a4.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed vmlinux.rm200 from Makefile.
We can use vmlinux.ecoff instead.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Makefile mips/arch/mips/Makefile
--- mips-orig/arch/mips/Makefile	2006-07-07 12:28:54.055411000 +0900
+++ mips/arch/mips/Makefile	2006-07-07 16:08:50.208627750 +0900
@@ -712,16 +712,14 @@ endif
 vmlinux.bin: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
-vmlinux.ecoff vmlinux.rm200: $(vmlinux-32)
+vmlinux.ecoff: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
 vmlinux.srec: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
 CLEAN_FILES += vmlinux.ecoff \
-	       vmlinux.srec \
-	       vmlinux.rm200.tmp \
-	       vmlinux.rm200
+	       vmlinux.srec
 
 archclean:
 	@$(MAKE) $(clean)=arch/mips/boot
