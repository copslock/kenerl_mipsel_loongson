Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:46:50 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53287 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012020AbaKGGpQB4Pz2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:16 +0100
Received: by mail-pa0-f53.google.com with SMTP id kx10so2926385pab.12
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=riGQ5T67v7cabDXnSkNXaziN0y4nGlD36niEIPnT2eQ=;
        b=hA1nb37SGj0kdFB6AlMbo+hdH7EXQXeAJsRKTzm2Gre/rk4nLFguu2GTnSlX2fdA11
         w39NssBVPnDRQ499m3XCdngWjUzikQeAoOXrl+TRfigvd2Zzje0AiR1CE4LS7+BpOSJh
         OYbNYeAZh7TI+UQjSELQ0/ILZAwMu9hrwln3VGgOKbm3S0PB7ctotvdM0Fym3Yf8tc4B
         h3+nbaLz9RxXP622TfnvIZSt1z3WleyIDkjZSrxdLZqfmKNiXxSuhUXDjwt1NNxJ6G5s
         /CC9JzmAMA8oJugF3cXe5jqIyu3flYvk13e90UYUDEekhH+i8shfcUSCgZP7wV758A9V
         E1KA==
X-Received: by 10.66.179.75 with SMTP id de11mr3609274pac.24.1415342710387;
        Thu, 06 Nov 2014 22:45:10 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:09 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 06/14] irqchip: bcm7120-l2: Eliminate bad IRQ check
Date:   Thu,  6 Nov 2014 22:44:21 -0800
Message-Id: <1415342669-30640-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43899
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
 drivers/irqchip/irq-bcm7120-l2.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index b9f4fb8..7086fe0 100644
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
-	do {
+	while (status) {
 		irq = ffs(status) - 1;
 		status &= ~(1 << irq);
 		generic_handle_irq(irq_find_mapping(b->domain, irq));
-	} while (status);
+	}
 
-out:
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.1.1
