Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 10:43:53 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:61394 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28574358AbYHAJkg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 10:40:36 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 92F6CC806C;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id W5pcntaJDvBy; Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 176E3C8092;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id D3CF2108072; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rpjday@crashcourse.ca
Subject: [PATCH 6/7] [MIPS] Remove dead code from arch/mips/pmc-sierra/yosemite/irq.c
Date:	Fri,  1 Aug 2008 12:40:20 +0300
Message-Id: <1217583621-4772-7-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The code under the following conditional compilation construct

 #ifdef CONFIG_HT_LEVEL_TRIGGER
 #endif

appeared during early 2.5.x times, but it seems that the relevant
enabling config option has never existed. Therefore, it looks like
the code under HT_LEVEL_TRIGGER did not have a single chance to be
ever compiled. This patch removes the dead lines.

Build-tested using the yosemite_defconfig.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/pmc-sierra/yosemite/irq.c |   31 -------------------------------
 1 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/arch/mips/pmc-sierra/yosemite/irq.c b/arch/mips/pmc-sierra/yosemite/irq.c
index 4decc28..222948b 100644
--- a/arch/mips/pmc-sierra/yosemite/irq.c
+++ b/arch/mips/pmc-sierra/yosemite/irq.c
@@ -77,37 +77,6 @@ static void ll_ht_smp_irq_handler(int irq)
 	if (status != 0)
 		OCD_WRITE(RM9000x2_OCD_INTP1STATUS4, IRQ_ACK_BITS);
 
-#ifdef CONFIG_HT_LEVEL_TRIGGER
-	/*
-	 * Level Trigger Mode only. Send the HT EOI message back to the source.
-	 */
-	switch (status) {
-	case 0x1000000:
-		OCD_WRITE(RM9000x2_OCD_HTEOI, HYPERTRANSPORT_INTA);
-		break;
-	case 0x2000000:
-		OCD_WRITE(RM9000x2_OCD_HTEOI, HYPERTRANSPORT_INTB);
-		break;
-	case 0x4000000:
-		OCD_WRITE(RM9000x2_OCD_HTEOI, HYPERTRANSPORT_INTC);
-		break;
-	case 0x8000000:
-		OCD_WRITE(RM9000x2_OCD_HTEOI, HYPERTRANSPORT_INTD);
-		break;
-	case 0x0000001:
-		/* PLX */
-		OCD_WRITE(RM9000x2_OCD_HTEOI, 0x20);
-		OCD_WRITE(IRQ_CLEAR_REG, IRQ_ACK_BITS);
-		break;
-	case 0xf000000:
-		OCD_WRITE(RM9000x2_OCD_HTEOI, HYPERTRANSPORT_INTA);
-		OCD_WRITE(RM9000x2_OCD_HTEOI, HYPERTRANSPORT_INTB);
-		OCD_WRITE(RM9000x2_OCD_HTEOI, HYPERTRANSPORT_INTC);
-		OCD_WRITE(RM9000x2_OCD_HTEOI, HYPERTRANSPORT_INTD);
-		break;
-	}
-#endif /* CONFIG_HT_LEVEL_TRIGGER */
-
 	do_IRQ(irq);
 }
 #endif
-- 
1.5.6
