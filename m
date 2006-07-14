Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 15:53:28 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:3085 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133431AbWGNOxT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Jul 2006 15:53:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 6DB9A7F4028
	for <linux-mips@linux-mips.org>; Fri, 14 Jul 2006 16:53:15 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10818-04 for <linux-mips@linux-mips.org>;
	Fri, 14 Jul 2006 16:53:15 +0200 (CEST)
Received: from [192.168.1.100] (port-83-236-238-37.static.qsc.de [83.236.238.37])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id 1DC9E7F4024
	for <linux-mips@linux-mips.org>; Fri, 14 Jul 2006 16:53:15 +0200 (CEST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <2F5D781B-2119-4942-82C1-70B5037F5622@caiaq.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To:	linux-mips@linux-mips.org
From:	Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] fix irq_chip struct for Pb1200/Db1200 platform
Date:	Fri, 14 Jul 2006 16:53:11 +0200
X-Mailer: Apple Mail (2.752.2)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

Hi,

the following patch makes external interrupt sources work again
on AMD's Au1200 development boards. The unnamed initialization
of 'external_irq_type' lead to a defective function mapping.

I resent it because of the missing Signed-off-by: line, sorry.

Daniel


Signed-off-by: Daniel Mack <daniel@caiaq.de>

--- a/arch/mips/au1000/pb1200/irqmap.c
+++ b/arch/mips/au1000/pb1200/irqmap.c
@@ -151,18 +151,17 @@ static void pb1200_end_irq(unsigned int
static struct irq_chip external_irq_type =
{
#ifdef CONFIG_MIPS_PB1200
-       "Pb1200 Ext",
+       .name = "Pb1200 Ext",
#endif
#ifdef CONFIG_MIPS_DB1200
-       "Db1200 Ext",
+       .name = "Db1200 Ext",
#endif
-       pb1200_startup_irq,
-       pb1200_shutdown_irq,
-       pb1200_enable_irq,
-       pb1200_disable_irq,
-       pb1200_mask_and_ack_irq,
-       pb1200_end_irq,
-       NULL
+       .startup  = pb1200_startup_irq,
+       .shutdown = pb1200_shutdown_irq,
+       .enable   = pb1200_enable_irq,
+       .disable  = pb1200_disable_irq,
+       .mask_ack = pb1200_mask_and_ack_irq,
+       .end      = pb1200_end_irq
};
void _board_init_irq(void)
