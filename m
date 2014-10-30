Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:22:34 +0100 (CET)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:49286 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012254AbaJ3CT4pSqOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:19:56 +0100
Received: by mail-pd0-f177.google.com with SMTP id v10so4143118pde.36
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g2S+uJnY3hN43GASB2wuuFBeb9bHDkUm6J1OmWQ+Jtg=;
        b=Fls+Eo2hsL5r7+zZqKJuPCkF3e61grdtEDtJhc9XrAzu+kVkfeu457Yc/WeziBeer0
         SwzSTwKfFjEg/Ir3qeLMht3M0HxQjqo5lZ1OoPWkK2WCEbjN9YemsdFAg/qz4R++JQbn
         suFpgyF9B6W/2MYl8cSq0Xc/1j4W9C6B9/tSwOGkqxMpAni9t7gY07Gx4bmJrD2mz7aG
         Ni3Esk2vO6eTqU+iLyISIEUlfCwFDPtKTM3KcrDS/Ku8EVGxXMmf/Nvc3GPr6DNDklOU
         aPzbNfQH9zG1WJiDovlw/zLtjcTgkUhdHfzkL95X11AYmgQ5eiwingmAwIjVToUs7XZX
         40cg==
X-Received: by 10.67.15.69 with SMTP id fm5mr13891416pad.91.1414635590634;
        Wed, 29 Oct 2014 19:19:50 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:50 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 08/15] irqchip: bcm7120-l2: Eliminate bad IRQ check
Date:   Wed, 29 Oct 2014 19:18:01 -0700
Message-Id: <1414635488-14137-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This check may be prone to race conditions, e.g.

1) Some external event (e.g. GPIO level) causes an IRQ to become pending
2) Peripheral asserts the L2 IRQ
3) CPU takes an interrupt
4) The event from #1 goes away
5) bcm7120_l2_intc_irq_handle() reads back a 0 status

Unlike the hardware supported by brcmstb-l2, the bcm7120-l2 controller
does not latch the IRQ status.  Bits can change if the inputs to the
controller change.  Also, do_bad_IRQ() is an ARM-specific macro.

So let's just nuke it.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index b9f4fb8..49d8f3d 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -27,8 +27,6 @@
 
 #include "irqchip.h"
 
-#include <asm/mach/irq.h>
-
 /* Register offset in the L2 interrupt controller */
 #define IRQEN		0x00
 #define IRQSTAT		0x04
@@ -51,19 +49,12 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	status = __raw_readl(b->base + IRQSTAT);
-
-	if (status == 0) {
-		do_bad_IRQ(irq, desc);
-		goto out;
-	}
-
 	do {
 		irq = ffs(status) - 1;
 		status &= ~(1 << irq);
 		generic_handle_irq(irq_find_mapping(b->domain, irq));
 	} while (status);
 
-out:
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.1.1
