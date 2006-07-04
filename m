Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2006 14:59:57 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:55330 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133491AbWGDN7s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2006 14:59:48 +0100
Received: by mo.po.2iij.net (mo30) id k64DxjHw073687; Tue, 4 Jul 2006 22:59:46 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k64DxgZH070618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jul 2006 22:59:43 +0900 (JST)
Date:	Tue, 4 Jul 2006 22:59:41 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: added CONF_BP for VR41xx
Message-Id: <20060704225941.14db0533.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added CONF_BP for VR41xx.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mipsregs.h mips/include/asm-mips/mipsregs.h
--- mips-orig/include/asm-mips/mipsregs.h	2006-07-03 00:51:00.895809500 +0900
+++ mips/include/asm-mips/mipsregs.h	2006-07-03 00:50:23.001441250 +0900
@@ -470,6 +470,7 @@
 
 /* Bits specific to the VR41xx.  */
 #define VR41_CONF_CS		(_ULCAST_(1) << 12)
+#define VR41_CONF_BP		(_ULCAST_(1) << 16)
 #define VR41_CONF_M16		(_ULCAST_(1) << 20)
 #define VR41_CONF_AD		(_ULCAST_(1) << 23)
 
