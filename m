Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 13:11:28 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:44322 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20032245AbXLLNLS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2007 13:11:18 +0000
Received: by mo.po.2iij.net (mo31) id lBCDBFri074494; Wed, 12 Dec 2007 22:11:15 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox304) id lBCDBAjD027592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Dec 2007 22:11:10 +0900
Date:	Wed, 12 Dec 2007 22:11:09 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] move vr41xx_calculate_clock_frequency() to
 plat_time_init()
Message-Id: <20071212221109.e0448c18.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Moved vr41xx_calculate_clock_frequency() to plat_time_init().
This function relates to the timer function.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/init.c mips/arch/mips/vr41xx/common/init.c
--- mips-orig/arch/mips/vr41xx/common/init.c	2007-10-25 07:34:48.001908250 +0900
+++ mips/arch/mips/vr41xx/common/init.c	2007-10-25 07:49:57.538750750 +0900
@@ -40,6 +40,8 @@ void __init plat_time_init(void)
 {
 	unsigned long tclock;
 
+	vr41xx_calculate_clock_frequency();
+
 	tclock = vr41xx_get_tclock_frequency();
 	if (current_cpu_data.processor_id == PRID_VR4131_REV2_0 ||
 	    current_cpu_data.processor_id == PRID_VR4131_REV2_1)
@@ -50,8 +52,6 @@ void __init plat_time_init(void)
 
 void __init plat_mem_setup(void)
 {
-	vr41xx_calculate_clock_frequency();
-
 	iomem_resource_init();
 }
 
