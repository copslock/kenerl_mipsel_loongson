Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Mar 2009 13:08:21 +0000 (GMT)
Received: from smtp14.dti.ne.jp ([202.216.231.189]:1920 "EHLO smtp14.dti.ne.jp")
	by ftp.linux-mips.org with ESMTP id S21366774AbZCUNIO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Mar 2009 13:08:14 +0000
Received: from [192.168.1.5] (PPPax1767.tokyo-ip.dti.ne.jp [210.159.179.17]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id n2LD8CXr018616;Sat, 21 Mar 2009 22:08:12 +0900 (JST)
Message-ID: <49C4E6BC.8040902@ruby.dti.ne.jp>
Date:	Sat, 21 Mar 2009 22:08:12 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: EMMA2RH: Use set_irq_chip_and_handler_name
References: <49C4E5D5.4070408@ruby.dti.ne.jp> <49C4E646.7010309@ruby.dti.ne.jp>
In-Reply-To: <49C4E646.7010309@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Fix two remaining set_irq_chip_and_handler() users which are encourated
to migrate to set_irq_chip_and_handler_name().

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/emma/markeins/irq.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index 1e6457c..2bbc41a 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -80,9 +80,9 @@ void emma2rh_irq_init(void)
 	u32 i;
 
 	for (i = 0; i < NUM_EMMA2RH_IRQ; i++)
-		set_irq_chip_and_handler(EMMA2RH_IRQ_BASE + i,
-					 &emma2rh_irq_controller,
-					 handle_level_irq);
+		set_irq_chip_and_handler_name(EMMA2RH_IRQ_BASE + i,
+					      &emma2rh_irq_controller,
+					      handle_level_irq, "level");
 }
 
 static void emma2rh_sw_irq_enable(unsigned int irq)
@@ -120,9 +120,9 @@ void emma2rh_sw_irq_init(void)
 	u32 i;
 
 	for (i = 0; i < NUM_EMMA2RH_IRQ_SW; i++)
-		set_irq_chip_and_handler(EMMA2RH_SW_IRQ_BASE + i,
-					 &emma2rh_sw_irq_controller,
-					 handle_level_irq);
+		set_irq_chip_and_handler_name(EMMA2RH_SW_IRQ_BASE + i,
+					      &emma2rh_sw_irq_controller,
+					      handle_level_irq, "level");
 }
 
 static void emma2rh_gpio_irq_enable(unsigned int irq)
