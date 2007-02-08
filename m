Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 01:31:54 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:65075 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039579AbXBHBbt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 01:31:49 +0000
Received: by mo.po.2iij.net (mo31) id l181UVJt038414; Thu, 8 Feb 2007 10:30:31 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l181UTme065810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 8 Feb 2007 10:30:29 +0900 (JST)
Date:	Thu, 8 Feb 2007 10:30:29 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] removed needless #include <asm/i8259.h>  on emma2rh
Message-Id: <20070208103029.40481af6.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

These irq.c don't need #include <asm/i8259.h>.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/emma2rh/common/irq.c mips/arch/mips/emma2rh/common/irq.c
--- mips-orig/arch/mips/emma2rh/common/irq.c	2007-02-07 18:24:06.864096500 +0900
+++ mips/arch/mips/emma2rh/common/irq.c	2007-02-08 09:42:27.348211000 +0900
@@ -27,7 +27,6 @@
 #include <linux/irq.h>
 #include <linux/types.h>
 
-#include <asm/i8259.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
 #include <asm/debug.h>
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/emma2rh/markeins/irq.c mips/arch/mips/emma2rh/markeins/irq.c
--- mips-orig/arch/mips/emma2rh/markeins/irq.c	2007-02-07 18:24:06.876097250 +0900
+++ mips/arch/mips/emma2rh/markeins/irq.c	2007-02-08 09:42:46.117384000 +0900
@@ -29,7 +29,6 @@
 #include <linux/ptrace.h>
 #include <linux/delay.h>
 
-#include <asm/i8259.h>
 #include <asm/irq_cpu.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
