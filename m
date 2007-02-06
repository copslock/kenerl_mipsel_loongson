Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 02:00:50 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:60487 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038814AbXBFCAp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Feb 2007 02:00:45 +0000
Received: by mo.po.2iij.net (mo31) id l161xMUd081328; Tue, 6 Feb 2007 10:59:22 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l161xM59075711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Feb 2007 10:59:22 +0900 (JST)
Message-Id: <200702060159.l161xM59075711@mbox33.po.2iij.net>
Date:	Tue, 6 Feb 2007 10:59:22 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix run_uncached warning about 32bit kernel
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed warning about 32 bit kernel.

arch/mips/lib/uncached.c: In function 'run_uncached':
arch/mips/lib/uncached.c:47: warning: comparison is always true due to limited range of data type
arch/mips/lib/uncached.c:48: warning: comparison is always false due to limited range of data type
arch/mips/lib/uncached.c:57: warning: comparison is always true due to limited range of data type
arch/mips/lib/uncached.c:58: warning: comparison is always false due to limited range of data type

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/lib/uncached.c mips/arch/mips/lib/uncached.c
--- mips-orig/arch/mips/lib/uncached.c	2006-11-13 19:32:04.002117500 +0900
+++ mips/arch/mips/lib/uncached.c	2006-11-13 19:29:07.087061000 +0900
@@ -44,20 +44,24 @@ unsigned long __init run_uncached(void *
 
 	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
 		usp = CKSEG1ADDR(sp);
+#ifdef CONFIG_64BIT
 	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
 		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
 		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
 				     XKPHYS_TO_PHYS((long long)sp));
+#endif
 	else {
 		BUG();
 		usp = sp;
 	}
 	if (lfunc >= (long)CKSEG0 && lfunc < (long)CKSEG2)
 		ufunc = CKSEG1ADDR(lfunc);
+#ifdef CONFIG_64BIT
 	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
 		 (long long)lfunc < (long long)PHYS_TO_XKPHYS(8LL, 0))
 		ufunc = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
 				       XKPHYS_TO_PHYS((long long)lfunc));
+#endif
 	else {
 		BUG();
 		ufunc = lfunc;
