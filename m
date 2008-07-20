Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jul 2008 14:03:55 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:50453 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28591775AbYGTNDw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 Jul 2008 14:03:52 +0100
Received: by mo.po.2iij.net (mo31) id m6KD3nAA042953; Sun, 20 Jul 2008 22:03:49 +0900 (JST)
Received: from delta (16.26.30.125.dy.iij4u.or.jp [125.30.26.16])
	by mbox.po.2iij.net (po-mbox304) id m6KD3jBH010429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 20 Jul 2008 22:03:46 +0900
Date:	Sun, 20 Jul 2008 22:03:32 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused maltasmp.h
Message-Id: <20080720220332.d597433e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused maltasmp.h.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/mips-boards/maltasmp.h linux/include/asm-mips/mips-boards/maltasmp.h
--- linux-orig/include/asm-mips/mips-boards/maltasmp.h	2008-07-18 10:53:59.448363041 +0900
+++ linux/include/asm-mips/mips-boards/maltasmp.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,36 +0,0 @@
-/*
- * There are several SMP models supported
- * SMTC is mutually exclusive to other options (atm)
- */
-#if defined(CONFIG_MIPS_MT_SMTC)
-#define malta_smtc	1
-#define malta_cmp	0
-#define malta_smvp	0
-#else
-#define malta_smtc	0
-#if defined(CONFIG_MIPS_CMP)
-extern int gcmp_present;
-#define malta_cmp	gcmp_present
-#else
-#define malta_cmp	0
-#endif
-/* FIXME: should become COMFIG_MIPS_MT_SMVP */
-#if defined(CONFIG_MIPS_MT_SMP)
-#define malta_smvp	1
-#else
-#define malta_smvp	0
-#endif
-#endif
-
-#include <asm/mipsregs.h>
-#include <asm/mipsmtregs.h>
-
-/* malta_smtc */
-#include <asm/smtc.h>
-#include <asm/smtc_ipi.h>
-
-/* malta_cmp */
-#include <asm/cmp.h>
-
-/* malta_smvp */
-#include <asm/smvp.h>
