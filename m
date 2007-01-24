Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 13:23:36 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:45319 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20048206AbXAXNXb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2007 13:23:31 +0000
Received: by mo.po.2iij.net (mo31) id l0ODMCTq021761; Wed, 24 Jan 2007 22:22:12 +0900 (JST)
Received: from localhost.localdomain (69.25.30.125.dy.iij4u.or.jp [125.30.25.69])
	by mbox.po.2iij.net (mbox32) id l0ODM6AJ089545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Jan 2007 22:22:07 +0900 (JST)
Date:	Wed, 24 Jan 2007 22:22:06 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] vr41xx: need one more nop with mtc0_tlbw_hazard()
Message-Id: <20070124222206.7dc832a0.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

NEC VR4111 and VR4121 need one more nop with mtc0_tlbw_hazard().
If I need to separate vr41xx hazard, please let me know.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hazards.h mips/include/asm-mips/hazards.h
--- mips-orig/include/asm-mips/hazards.h	2007-01-24 22:06:48.231247000 +0900
+++ mips/include/asm-mips/hazards.h	2007-01-24 22:13:23.172037500 +0900
@@ -157,7 +157,7 @@ ASMMACRO(back_to_back_c0_hazard,
  * processors.
  */
 ASMMACRO(mtc0_tlbw_hazard,
-	nop
+	nop; nop
 	)
 ASMMACRO(tlbw_use_hazard,
 	nop; nop; nop
