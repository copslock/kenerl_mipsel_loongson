Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2006 17:15:51 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:41783 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038490AbWIUQP1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2006 17:15:27 +0100
Received: by mo.po.2iij.net (mo32) id k8LGFOSG039757; Fri, 22 Sep 2006 01:15:24 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k8LGFKE9089671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Sep 2006 01:15:20 +0900 (JST)
Date:	Fri, 22 Sep 2006 01:13:12 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 3/3] remove some redefinitions in hazard.h
Message-Id: <20060922011312.45e4c3e3.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060922011048.676d8de0.yoichi_yuasa@tripeaks.co.jp>
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>
	<20060922011048.676d8de0.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

This patch has removed some redefinitions in hazard.h .

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hazards.h mips/include/asm-mips/hazards.h
--- mips-orig/include/asm-mips/hazards.h	2006-09-22 00:17:58.189227000 +0900
+++ mips/include/asm-mips/hazards.h	2006-09-22 00:13:46.893522000 +0900
@@ -191,22 +191,4 @@ ASMMACRO(back_to_back_c0_hazard,
 
 #endif
 
-#ifndef __ASSEMBLY__
-
-/* C access to assembler macros */
-#define mtc0_tlbw_hazard() \
-	__asm__ __volatile__("mtc0_tlbw_hazard")
-#define tlbw_use_hazard() \
-	__asm__ __volatile__("tlbw_use_hazard")
-#define tlb_probe_hazard() \
-	__asm__ __volatile__("tlb_probe_hazard")
-#define irq_enable_hazard() \
-	__asm__ __volatile__("irq_enable_hazard")
-#define irq_disable_hazard() \
-	__asm__ __volatile__("irq_disable_hazard")
-#define back_to_back_c0_hazard() \
-	__asm__ __volatile__("back_to_back_c0_hazard")
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* _ASM_HAZARDS_H */
