Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2006 04:33:54 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:44450 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8126578AbWFUDdn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Jun 2006 04:33:43 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k5L3XRUa013024;
	Tue, 20 Jun 2006 20:33:27 -0700 (PDT)
Received: from ism-mail01.corp.ad.wrs.com ([147.11.96.20]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 20 Jun 2006 20:33:27 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] remove set_c0_status(ST0_IM) form wrppmc's irq.c
Date:	Wed, 21 Jun 2006 05:33:24 +0200
Message-ID: <6A3254532ACD7A42805B4E1BFD18080E01039084@ism-mail01.corp.ad.wrs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] remove set_c0_status(ST0_IM) form wrppmc's irq.c
Thread-Index: AcaUdbEr7xyLSp30RouA4twIDn3CfgAbU+rQ
From:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>
To:	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 21 Jun 2006 03:33:27.0814 (UTC) FILETIME=[7599D260:01C694E3]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

Hi Yiochi,

Yes. You are right.

To Ralf: Please consider the codes for wrppmc board go into the current merge window. Thanks.

Best Regards,
Mark. Zhan
-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Yoichi Yuasa
Sent: Tuesday, June 20, 2006 10:27 PM
To: Ralf Baechle
Cc: linux-mips@linux-mips.org
Subject: [PATCH] remove set_c0_status(ST0_IM) form wrppmc's irq.c

Hi,

mips_cpu_irq_init() does clear_c0_status(ST0_IM) first.
I think that set_c0_status(ST0_IM) isn't necessary.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/irq.c mips/arch/mips/gt64120/wrppmc/irq.c
--- mips-orig/arch/mips/gt64120/wrppmc/irq.c	2006-06-20 21:17:36.853537000 +0900
+++ mips/arch/mips/gt64120/wrppmc/irq.c	2006-06-20 21:36:41.949101000 +0900
@@ -62,9 +62,6 @@ void gt64120_init_pic(void)
 
 void __init arch_init_irq(void)
 {
-	/* enable all CPU interrupt bits. */
-	set_c0_status(ST0_IM);	/* IE bit is still 0 */
-
 	/* IRQ 0 - 7 are for MIPS common irq_cpu controller */
 	mips_cpu_irq_init(0);
 
