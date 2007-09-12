Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 15:19:59 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:16666 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022546AbXILOTu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 15:19:50 +0100
Received: by mo.po.2iij.net (mo30) id l8CEJlPT004103; Wed, 12 Sep 2007 23:19:47 +0900 (JST)
Received: from localhost.localdomain (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox302) id l8CEJjdH004686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2007 23:19:46 +0900
Date:	Wed, 12 Sep 2007 23:19:45 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused GT64120 definitions
Message-Id: <20070912231945.68654f4c.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused GT64120 definitions.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-mips/mach-gt64120.h mips/include/asm-mips/mach-mips/mach-gt64120.h
--- mips-orig/include/asm-mips/mach-mips/mach-gt64120.h	2007-09-06 11:04:06.350945750 +0900
+++ mips/include/asm-mips/mach-mips/mach-gt64120.h	2007-09-06 11:04:37.920918750 +0900
@@ -16,13 +16,4 @@ extern unsigned long _pcictrl_gt64120;
  */
 #define GT64120_BASE	_pcictrl_gt64120
 
-/*
- *   PCI Bus allocation
- */
-#define GT_PCI_MEM_BASE	0x12000000UL
-#define GT_PCI_MEM_SIZE	0x02000000UL
-#define GT_PCI_IO_BASE	0x10000000UL
-#define GT_PCI_IO_SIZE	0x02000000UL
-#define GT_ISA_IO_BASE	PCI_IO_BASE
-
 #endif /* _ASM_MACH_MIPS_MACH_GT64120_DEP_H */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-wrppmc/mach-gt64120.h mips/include/asm-mips/mach-wrppmc/mach-gt64120.h
--- mips-orig/include/asm-mips/mach-wrppmc/mach-gt64120.h	2007-09-06 10:33:31.940440500 +0900
+++ mips/include/asm-mips/mach-wrppmc/mach-gt64120.h	2007-09-06 11:05:14.843226250 +0900
@@ -43,7 +43,6 @@
 #define GT_PCI_MEM_SIZE	0x02000000UL
 #define GT_PCI_IO_BASE	0x11000000UL
 #define GT_PCI_IO_SIZE	0x02000000UL
-#define GT_ISA_IO_BASE	PCI_IO_BASE
 
 /*
  * PCI interrupts will come in on either the INTA or INTD interrups lines,
