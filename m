Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2007 14:28:37 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:12085 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027270AbXJZN23 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2007 14:28:29 +0100
Received: by mo.po.2iij.net (mo31) id l9QDR9Ti075933; Fri, 26 Oct 2007 22:27:09 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox304) id l9QDR6EJ011662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 26 Oct 2007 22:27:06 +0900
Date:	Fri, 26 Oct 2007 22:27:05 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add mips_hpt_frequency check to
 mips_clockevent_init()
Message-Id: <20071026222705.9ef9c808.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add mips_hpt_frequency check to mips_clockevent_init().

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/cevt-r4k.c mips/arch/mips/kernel/cevt-r4k.c
--- mips-orig/arch/mips/kernel/cevt-r4k.c	2007-10-21 12:44:50.113477500 +0900
+++ mips/arch/mips/kernel/cevt-r4k.c	2007-10-21 12:49:09.177668000 +0900
@@ -220,7 +220,7 @@ void __cpuinit mips_clockevent_init(void
 	struct clock_event_device *cd;
 	unsigned int irq = MIPS_CPU_IRQ_BASE + 7;
 
-	if (!cpu_has_counter)
+	if (!cpu_has_counter || !mips_hpt_frequency)
 		return;
 
 #ifdef CONFIG_MIPS_MT_SMTC
