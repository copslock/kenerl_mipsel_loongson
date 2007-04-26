Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 11:56:00 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:8000 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023370AbXDZKz6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2007 11:55:58 +0100
Received: by mo.po.2iij.net (mo32) id l3QAttIh051570; Thu, 26 Apr 2007 19:55:55 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l3QAto68097382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Apr 2007 19:55:51 +0900 (JST)
Message-Id: <200704261055.l3QAto68097382@mbox33.po.2iij.net>
Date:	Thu, 26 Apr 2007 19:45:09 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] rename VR41XX to VR4100 series
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf

This patch has renamed VR41XX to VR4100 series.
That's better.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X vr41xx/Documentation/dontdiff vr41xx-orig/arch/mips/Kconfig vr41xx/arch/mips/Kconfig
--- vr41xx-orig/arch/mips/Kconfig	2007-04-26 19:00:53.983294750 +0900
+++ vr41xx/arch/mips/Kconfig	2007-04-26 19:07:27.463885750 +0900
@@ -501,7 +501,7 @@ config DDB5477
 	  ether port USB, AC97, PCI, etc.
 
 config MACH_VR41XX
-	bool "NEC VR41XX-based machines"
+	bool "NEC VR4100 series based machines"
 	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
