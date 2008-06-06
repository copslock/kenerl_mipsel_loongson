Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2008 15:42:03 +0100 (BST)
Received: from mail30g.wh2.ocn.ne.jp ([220.111.41.239]:37231 "HELO
	mail30g.wh2.ocn.ne.jp") by ftp.linux-mips.org with SMTP
	id S28642419AbYFFOmB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jun 2008 15:42:01 +0100
Received: from vs30a.wh2.ocn.ne.jp (220.111.41.231)
	by mail30g.wh2.ocn.ne.jp (RS ver 1.0.95vs) with SMTP id 1-096493303;
	Fri,  6 Jun 2008 23:41:56 +0900 (JST)
From:	bruno randolf <br1@einfach.org>
To:	ralf@linux-mips.org
Subject: [patch] add au1500 reserved interrupt
Date:	Fri, 6 Jun 2008 16:42:03 +0200
User-Agent: KMail/1.9.7
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806061642.03883.br1@einfach.org>
X-SF-Loop: 1
Return-Path: <br1@einfach.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@einfach.org
Precedence: bulk
X-list: linux-mips

au1000: add au1500 reserved interrupt

in the conversion done in the commits

  95c4eb3ef4484ca85da5c98780d358cffd546b90
  9d360ab4a7568a8d177280f651a8a772ae52b9b9

  [MIPS] Alchemy: Renumber interrupts so irq_cpu can work.

one reserved interrupt on au1500 was missed. this broke the au1000 ethernet 
driver.

this patch against 2.6.25.4 makes it work again.

Signed-off-by: Bruno Randolf <br1@einfach.org>

--- a/include/asm-mips/mach-au1x00/au1000.h	2008-05-15 17:00:12.000000000 
+0200
+++ b/include/asm-mips/mach-au1x00/au1000.h	2008-06-06 16:22:51.000000000 
+0200
@@ -623,6 +623,7 @@
 	AU1000_RTC_MATCH1_INT,
 	AU1000_RTC_MATCH2_INT,
 	AU1500_PCI_ERR_INT,
+	AU1500_RESERVED_INT,
 	AU1000_USB_DEV_REQ_INT,
 	AU1000_USB_DEV_SUS_INT,
 	AU1000_USB_HOST_INT,
