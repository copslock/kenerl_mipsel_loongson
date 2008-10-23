Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:36:39 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:25228 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22230174AbYJWQgg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:36:36 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGaYQj006754;Fri, 24 Oct 2008 01:36:34 +0900 (JST)
Message-ID: <4900A811.1040905@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:36:33 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 12/12] MIPS: Markeins: Remove unnecessary define and cleanup
 comments, etc.
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/emma/markeins/irq.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index 9d6c866..c2583ec 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -37,24 +37,6 @@
 
 #include <asm/emma/emma2rh.h>
 
-/* number of total irqs supported by EMMA2RH */
-#define	NUM_EMMA2RH_IRQ		96
-
-/*
- * IRQ mapping
- *
- *  0-7: 8 CPU interrupts
- *	0 -	software interrupt 0
- *	1 - 	software interrupt 1
- *	2 - 	most Vrc5477 interrupts are routed to this pin
- *	3 - 	(optional) some other interrupts routed to this pin for debugg
- *	4 - 	not used
- *	5 - 	not used
- *	6 - 	not used
- *	7 - 	cpu timer (used by default)
- *
- */
-
 static void emma2rh_irq_enable(unsigned int irq)
 {
 	u32 reg_value;
@@ -347,5 +329,3 @@ asmlinkage void plat_irq_dispatch(void)
 	else
 		spurious_interrupt();
 }
-
-
