Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2006 16:42:40 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:15626 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037507AbWJ0Pmc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Oct 2006 16:42:32 +0100
Received: by mo.po.2iij.net (mo32) id k9RFgTrs099852; Sat, 28 Oct 2006 00:42:29 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox31) id k9RFgPZv015402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 28 Oct 2006 00:42:25 +0900 (JST)
Date:	Sat, 28 Oct 2006 00:42:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused definition from c-sb1.c
Message-Id: <20061028004224.49efdbac.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed unused definition from c-sb1.c .

arch/mips/mm/c-sb1.c: In function `sb1_cache_init':
arch/mips/mm/c-sb1.c:447: warning: unused variable `handle_vec2_sb1'

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/mm/c-sb1.c generic/arch/mips/mm/c-sb1.c
--- generic-orig/arch/mips/mm/c-sb1.c	2006-10-22 12:13:54.649176250 +0900
+++ generic/arch/mips/mm/c-sb1.c	2006-10-22 13:32:28.471771750 +0900
@@ -444,7 +444,6 @@ static __init void probe_cache_sizes(voi
 void sb1_cache_init(void)
 {
 	extern char except_vec2_sb1;
-	extern char handle_vec2_sb1;
 
 	/* Special cache error handler for SB1 */
 	set_uncached_handler (0x100, &except_vec2_sb1, 0x80);
