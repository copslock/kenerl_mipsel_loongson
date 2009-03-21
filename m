Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Mar 2009 13:04:34 +0000 (GMT)
Received: from smtp14.dti.ne.jp ([202.216.231.189]:65535 "EHLO
	smtp14.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S21369760AbZCUNE1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Mar 2009 13:04:27 +0000
Received: from [192.168.1.5] (PPPax1767.tokyo-ip.dti.ne.jp [210.159.179.17]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id n2LD4Ls8018579;Sat, 21 Mar 2009 22:04:24 +0900 (JST)
Message-ID: <49C4E5D5.4070408@ruby.dti.ne.jp>
Date:	Sat, 21 Mar 2009 22:04:21 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Mark Eins: Fix cascading interrupt dispatcher
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

* Fix mis-calculated IRQ bitshift on cascading interrupts
* Prevent cascading interrupt bits being processed afterward

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/emma/markeins/irq.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index c2583ec..263132d 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -213,8 +213,7 @@ void emma2rh_irq_dispatch(void)
 		    emma2rh_in32(EMMA2RH_BHIF_INT_EN_0);
 
 #ifdef EMMA2RH_SW_CASCADE
-	if (intStatus &
-	    (1 << ((EMMA2RH_SW_CASCADE - EMMA2RH_IRQ_INT0) & (32 - 1)))) {
+	if (intStatus & (1UL << EMMA2RH_SW_CASCADE)) {
 		u32 swIntStatus;
 		swIntStatus = emma2rh_in32(EMMA2RH_BHIF_SW_INT)
 		    & emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
@@ -225,6 +224,8 @@ void emma2rh_irq_dispatch(void)
 			}
 		}
 	}
+	/* Skip S/W interrupt */
+	intStatus &= ~(1UL << EMMA2RH_SW_CASCADE);
 #endif
 
 	for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
@@ -238,8 +239,7 @@ void emma2rh_irq_dispatch(void)
 		    emma2rh_in32(EMMA2RH_BHIF_INT_EN_1);
 
 #ifdef EMMA2RH_GPIO_CASCADE
-	if (intStatus &
-	    (1 << ((EMMA2RH_GPIO_CASCADE - EMMA2RH_IRQ_INT0) & (32 - 1)))) {
+	if (intStatus & (1UL << (EMMA2RH_GPIO_CASCADE % 32))) {
 		u32 gpioIntStatus;
 		gpioIntStatus = emma2rh_in32(EMMA2RH_GPIO_INT_ST)
 		    & emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
@@ -250,6 +250,8 @@ void emma2rh_irq_dispatch(void)
 			}
 		}
 	}
+	/* Skip GPIO interrupt */
+	intStatus &= ~(1UL << (EMMA2RH_GPIO_CASCADE % 32));
 #endif
 
 	for (i = 32, bitmask = 1; i < 64; i++, bitmask <<= 1) {
