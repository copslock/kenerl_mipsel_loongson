Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 15:38:27 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:44104 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021411AbYEGOiY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2008 15:38:24 +0100
Received: by mo.po.2iij.net (mo31) id m47EcKZR007823; Wed, 7 May 2008 23:38:20 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox305) id m47EcGLo020945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 7 May 2008 23:38:16 +0900
Date:	Wed, 7 May 2008 23:38:15 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix divide by zero error in build_clear_page and
 build_copy_page
Message-Id: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Fix divide by zero error in build_clear_page() and build_copy_page()

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/mm/page.c linux/arch/mips/mm/page.c
--- linux-orig/arch/mips/mm/page.c	2008-05-07 10:28:03.732151097 +0900
+++ linux/arch/mips/mm/page.c	2008-05-07 23:27:00.212977534 +0900
@@ -310,8 +310,8 @@ void __cpuinit build_clear_page(void)
 	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
 		uasm_i_lui(&buf, AT, 0xa000);
 
-	off = min(8, pref_bias_clear_store / cache_line_size) *
-	      cache_line_size;
+	off = cache_line_size ? min(8, pref_bias_clear_store / cache_line_size)
+	                        * cache_line_size : 0;
 	while (off) {
 		build_clear_pref(&buf, -off);
 		off -= cache_line_size;
@@ -454,12 +454,14 @@ void __cpuinit build_copy_page(void)
 	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
 		uasm_i_lui(&buf, AT, 0xa000);
 
-	off = min(8, pref_bias_copy_load / cache_line_size) * cache_line_size;
+	off = cache_line_size ? min(8, pref_bias_copy_load / cache_line_size) *
+	                        cache_line_size : 0;
 	while (off) {
 		build_copy_load_pref(&buf, -off);
 		off -= cache_line_size;
 	}
-	off = min(8, pref_bias_copy_store / cache_line_size) * cache_line_size;
+	off = cache_line_size ? min(8, pref_bias_copy_load / cache_line_size) *
+	                        cache_line_size : 0;
 	while (off) {
 		build_copy_store_pref(&buf, -off);
 		off -= cache_line_size;
