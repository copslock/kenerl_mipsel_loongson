Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 08:37:06 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:57881 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022980AbXGMHhE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2007 08:37:04 +0100
Received: by mo.po.2iij.net (mo30) id l6D7axhn098957; Fri, 13 Jul 2007 16:36:59 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l6D7avTA028326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 13 Jul 2007 16:36:57 +0900
Date:	Fri, 13 Jul 2007 16:36:57 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix MIPSsim cflags
Message-Id: <20070713163657.4348a72a.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Fix MIPSsim cflags.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Makefile mips/arch/mips/Makefile
--- mips-orig/arch/mips/Makefile	2007-07-13 13:06:04.179097750 +0900
+++ mips/arch/mips/Makefile	2007-07-13 16:23:05.796996000 +0900
@@ -328,7 +328,7 @@ load-$(CONFIG_MIPS_SEAD)	+= 0xffffffff80
 # MIPS SIM
 #
 core-$(CONFIG_MIPS_SIM)		+= arch/mips/mipssim/
-cflags-$(CONFIG_MIPS_SIM)	+= -Iinclude/asm-mips/mach-sim
+cflags-$(CONFIG_MIPS_SIM)	+= -Iinclude/asm-mips/mach-mipssim
 load-$(CONFIG_MIPS_SIM)		+= 0x80100000
 
 #
