Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 11:57:36 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:20519 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023375AbXDZK5M (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2007 11:57:12 +0100
Received: by mo.po.2iij.net (mo32) id l3QAttNZ051584; Thu, 26 Apr 2007 19:55:55 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id l3QAtpJ8003441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Apr 2007 19:55:51 +0900 (JST)
Message-Id: <200704261055.l3QAtpJ8003441@mbox32.po.2iij.net>
Date:	Thu, 26 Apr 2007 19:51:31 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove 2 select entries for VR41xx
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed 2 select entries for VR41xx.
These entries are selected in arch/mips/vr41xx/Kconfig.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X vr41xx/Documentation/dontdiff vr41xx-orig/arch/mips/Kconfig vr41xx/arch/mips/Kconfig
--- vr41xx-orig/arch/mips/Kconfig	2007-04-26 19:14:20.753714750 +0900
+++ vr41xx/arch/mips/Kconfig	2007-04-26 19:15:59.763902500 +0900
@@ -503,8 +503,6 @@ config DDB5477
 config MACH_VR41XX
 	bool "NEC VR4100 series based machines"
 	select SYS_HAS_CPU_VR41XX
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config PMC_YOSEMITE
