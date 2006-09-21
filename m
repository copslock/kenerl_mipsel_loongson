Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2006 17:16:17 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:57637 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038505AbWIUQP1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2006 17:15:27 +0100
Received: by mo.po.2iij.net (mo31) id k8LGFOft089390; Fri, 22 Sep 2006 01:15:24 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k8LGFJfx089668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Sep 2006 01:15:19 +0900 (JST)
Date:	Fri, 22 Sep 2006 01:10:48 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/3] fixed typo in hazard.h
Message-Id: <20060922011048.676d8de0.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

This patch has fixed typo in hazard.h .

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hazards.h mips/include/asm-mips/hazards.h
--- mips-orig/include/asm-mips/hazards.h	2006-09-22 00:00:36.145536750 +0900
+++ mips/include/asm-mips/hazards.h	2006-09-22 00:01:17.699349000 +0900
@@ -11,7 +11,7 @@
 #define _ASM_HAZARDS_H
 
 
-#ifdef __ASSEMBLER__
+#ifdef __ASSEMBLY__
 #define ASMMACRO(name, code...) .macro name; code; .endm
 #else
 
