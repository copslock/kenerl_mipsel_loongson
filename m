Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 15:56:20 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:20007 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133785AbWFTOza (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 15:55:30 +0100
Received: by mo.po.2iij.net (mo32) id k5KEtSQG007476; Tue, 20 Jun 2006 23:55:28 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k5KEtPB6039661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Jun 2006 23:55:26 +0900 (JST)
Date:	Tue, 20 Jun 2006 23:55:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] remove CONFIG_VR4181
Message-Id: <20060620235524.4734ebb9.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch removes CONFIG_VR4181.
VR4181 support was already removed.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips-rc6/Documentation/dontdiff mips-rc6-orig/arch/mips/Kconfig mips-rc6/arch/mips/Kconfig
--- mips-rc6-orig/arch/mips/Kconfig	2006-06-09 00:32:57.197212500 +0900
+++ mips-rc6/arch/mips/Kconfig	2006-06-09 00:40:07.424100000 +0900
@@ -1040,9 +1040,6 @@ config MIPS_L1_CACHE_SHIFT
 config HAVE_STD_PC_SERIAL_PORT
 	bool
 
-config VR4181
-	bool
-
 config ARC_CONSOLE
 	bool "ARC console support"
 	depends on SGI_IP22 || SNI_RM200_PCI
diff -pruN -X mips-rc6/Documentation/dontdiff mips-rc6-orig/arch/mips/kernel/cpu-probe.c mips-rc6/arch/mips/kernel/cpu-probe.c
--- mips-rc6-orig/arch/mips/kernel/cpu-probe.c	2006-06-09 00:32:57.257216250 +0900
+++ mips-rc6/arch/mips/kernel/cpu-probe.c	2006-06-09 00:41:06.347782500 +0900
@@ -250,15 +250,9 @@ static inline void cpu_probe_legacy(stru
 		break;
 	case PRID_IMP_VR41XX:
 		switch (c->processor_id & 0xf0) {
-#ifndef CONFIG_VR4181
 		case PRID_REV_VR4111:
 			c->cputype = CPU_VR4111;
 			break;
-#else
-		case PRID_REV_VR4181:
-			c->cputype = CPU_VR4181;
-			break;
-#endif
 		case PRID_REV_VR4121:
 			c->cputype = CPU_VR4121;
 			break;
