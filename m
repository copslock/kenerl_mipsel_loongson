Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 02:44:01 +0100 (BST)
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:58834 "EHLO
	smtp-out2.tiscali.nl") by ftp.linux-mips.org with ESMTP
	id S20027056AbYDPBn6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Apr 2008 02:43:58 +0100
Received: from [82.171.187.43] (helo=[192.168.1.2])
	by smtp-out2.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Jlwgo-0001bX-8j; Wed, 16 Apr 2008 03:43:58 +0200
Message-ID: <480559DC.2060807@tiscali.nl>
Date:	Wed, 16 Apr 2008 03:43:56 +0200
From:	Roel Kluin <12o3l@tiscali.nl>
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] MIPS: ip27-timer: fix unsigned irq < 0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <12o3l@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 12o3l@tiscali.nl
Precedence: bulk
X-list: linux-mips

irq is unsigned, cast to signed to evaluate the allocate_irqno() return value,
    
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---   
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 25d3baf..3c08afd 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -222,19 +222,19 @@ static void __init hub_rt_clock_event_global_init(void)
 	unsigned int irq;
 
 	do {
 		smp_wmb();
 		irq = rt_timer_irq;
 		if (irq)
 			break;
 
 		irq = allocate_irqno();
-		if (irq < 0)
+		if ((int) irq < 0)
 			panic("Allocation of irq number for timer failed");
 	} while (xchg(&rt_timer_irq, irq));
 
 	set_irq_chip_and_handler(irq, &rt_irq_type, handle_percpu_irq);
 	setup_irq(irq, &hub_rt_irqaction);
 }
 
 static cycle_t hub_rt_read(void)
 {
