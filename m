Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 15:17:35 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:46151 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133761AbWFTORZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 15:17:25 +0100
Received: by mo.po.2iij.net (mo31) id k5KEHNNG010243; Tue, 20 Jun 2006 23:17:23 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox30) id k5KEHJCe043975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Jun 2006 23:17:19 +0900 (JST)
Date:	Tue, 20 Jun 2006 23:17:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] remove unused system type name(DDB5074 and DDB5476)
Message-Id: <20060620231718.75dac51a.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch removes unused system type name.
DDB5074 and DDB5476 were already removed.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/ddb5xxx/common/prom.c mips/arch/mips/ddb5xxx/common/prom.c
--- mips-orig/arch/mips/ddb5xxx/common/prom.c	2006-06-20 14:14:56.891585250 +0900
+++ mips/arch/mips/ddb5xxx/common/prom.c	2006-06-19 10:12:28.198331000 +0900
@@ -21,8 +21,6 @@
 const char *get_system_type(void)
 {
 	switch (mips_machtype) {
-	case MACH_NEC_DDB5074:		return "NEC DDB Vrc-5074";
-	case MACH_NEC_DDB5476:		return "NEC DDB Vrc-5476";
 	case MACH_NEC_DDB5477:		return "NEC DDB Vrc-5477";
 	case MACH_NEC_ROCKHOPPER:	return "NEC Rockhopper";
 	case MACH_NEC_ROCKHOPPERII:     return "NEC RockhopperII";
