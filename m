Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 04:45:47 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:11569 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037523AbWJaEpV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2006 04:45:21 +0000
Received: by mo.po.2iij.net (mo31) id k9V4jHAf043329; Tue, 31 Oct 2006 13:45:17 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k9V4jF44016171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Oct 2006 13:45:16 +0900 (JST)
Message-Id: <200610310445.k9V4jF44016171@mbox32.po.2iij.net>
Date:	Tue, 31 Oct 2006 13:44:38 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix warning of printk format in mips_srs_init()
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed the warning of printk format in mips_srs_init().

arch/mips/kernel/traps.c:1115: warning: int format, long unsigned int arg (arg 2)

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/traps.c mips/arch/mips/kernel/traps.c
--- mips-orig/arch/mips/kernel/traps.c	2006-10-29 13:07:07.791518500 +0900
+++ mips/arch/mips/kernel/traps.c	2006-10-29 17:10:15.363553250 +0900
@@ -1111,7 +1111,7 @@ static struct shadow_registers {
 static void mips_srs_init(void)
 {
 	shadow_registers.sr_supported = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
-	printk(KERN_INFO "%d MIPSR2 register sets available\n",
+	printk(KERN_INFO "%ld MIPSR2 register sets available\n",
 	       shadow_registers.sr_supported);
 	shadow_registers.sr_allocated = 1;	/* Set 0 used by kernel */
 }
