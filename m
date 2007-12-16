Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Dec 2007 13:57:26 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:57098 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20025210AbXLPN5R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Dec 2007 13:57:17 +0000
Received: by mo.po.2iij.net (mo31) id lBGDtxWo047056; Sun, 16 Dec 2007 22:55:59 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox303) id lBGDtuv8018839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 16 Dec 2007 22:55:56 +0900
Date:	Sun, 16 Dec 2007 22:54:26 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2/2][MIPS] remove unused lasat definitions
Message-Id: <20071216225426.e2d1052c.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071216225300.6069fe55.yoichi_yuasa@tripeaks.co.jp>
References: <20071216225300.6069fe55.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Removed unused lasat definitions.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/lasat/lasat.h mips/include/asm-mips/lasat/lasat.h
--- mips-orig/include/asm-mips/lasat/lasat.h	2007-12-11 23:12:53.674363750 +0900
+++ mips/include/asm-mips/lasat/lasat.h	2007-12-12 00:14:56.073369250 +0900
@@ -245,9 +245,6 @@ static inline void lasat_ndelay(unsigned
 #define LASAT_SERVICEMODE_MAGIC_1     0xdeadbeef
 #define LASAT_SERVICEMODE_MAGIC_2     0xfedeabba
 
-/* Lasat 100 boards */
-#define LASAT_GT_BASE           (KSEG1ADDR(0x14000000))
-
 /* Lasat 200 boards */
 #define Vrc5074_PHYS_BASE       0x1fa00000
 #define Vrc5074_BASE            (KSEG1ADDR(Vrc5074_PHYS_BASE))
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-lasat/mach-gt64120.h mips/include/asm-mips/mach-lasat/mach-gt64120.h
--- mips-orig/include/asm-mips/mach-lasat/mach-gt64120.h	2007-12-11 23:12:54.162394250 +0900
+++ mips/include/asm-mips/mach-lasat/mach-gt64120.h	2007-12-12 00:13:39.216566000 +0900
@@ -11,17 +11,6 @@
 /*
  *   GT64120 config space base address on Lasat 100
  */
-#define GT64120_BASE	(KSEG1ADDR(0x14000000))
-
-/*
- *   PCI Bus allocation
- *
- *   (Guessing ...)
- */
-#define GT_PCI_MEM_BASE	0x12000000UL
-#define GT_PCI_MEM_SIZE	0x02000000UL
-#define GT_PCI_IO_BASE	0x10000000UL
-#define GT_PCI_IO_SIZE	0x02000000UL
-#define GT_ISA_IO_BASE	PCI_IO_BASE
+#define GT64120_BASE	KSEG1ADDR(GT_DEF_BASE)
 
 #endif /* _ASM_GT64120_LASAT_GT64120_DEP_H */
