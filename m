Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 16:56:34 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:13760 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226475AbVGKP4S>;
	Mon, 11 Jul 2005 16:56:18 +0100
Received: MO(mo01)id j6BFvBVj008924; Tue, 12 Jul 2005 00:57:11 +0900 (JST)
Received: MDO(mdo01) id j6BFvBVl023265; Tue, 12 Jul 2005 00:57:11 +0900 (JST)
Received: from stratos (h086.p498.iij4u.or.jp [210.149.242.86])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j6BFvAUW019331
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 12 Jul 2005 00:57:10 +0900 (JST)
Date:	Tue, 12 Jul 2005 00:57:08 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCh 2.6] vr41xx: cleaning include in icu.c
Message-Id: <20050712005708.0f6a0eb3.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has cleaned includes in icu.c.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/icu.c a/arch/mips/vr41xx/common/icu.c
--- a-orig/arch/mips/vr41xx/common/icu.c	2005-06-02 23:33:02.000000000 +0900
+++ a/arch/mips/vr41xx/common/icu.c	2005-07-12 00:49:23.597771624 +0900
@@ -30,7 +30,6 @@
  */
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -39,8 +38,6 @@
 
 #include <asm/cpu.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/irq_cpu.h>
 #include <asm/vr41xx/vr41xx.h>
 
 static void __iomem *icu1_base;
