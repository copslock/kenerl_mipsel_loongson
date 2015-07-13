Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:47:54 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56984 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011077AbbGMUqJVPnNV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:09 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkc3-0006Vy-Sq; Mon, 13 Jul 2015 22:46:07 +0200
Message-Id: <20150713200714.939366830@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:46:01 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org
Subject: [patch 06/12] MIPS/alchemy: Use irq_set_chip_handler_name_locked()
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=MIPS-alchemy-Use-irq_set_chip_handler_name_locked.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

Hand in irq_data and avoid the redundant lookup of irq_desc.

Originally-from: Jiang Liu <jiang.liu@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/alchemy/common/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: tip/arch/mips/alchemy/common/irq.c
===================================================================
--- tip.orig/arch/mips/alchemy/common/irq.c
+++ tip/arch/mips/alchemy/common/irq.c
@@ -491,7 +491,7 @@ static int au1x_ic_settype(struct irq_da
 	default:
 		ret = -EINVAL;
 	}
-	__irq_set_chip_handler_name_locked(d->irq, chip, handler, name);
+	irq_set_chip_handler_name_locked(d, chip, handler, name);
 
 	wmb();
 
@@ -703,7 +703,7 @@ static int au1300_gpic_settype(struct ir
 		return -EINVAL;
 	}
 
-	__irq_set_chip_handler_name_locked(d->irq, &au1300_gpic, hdl, name);
+	irq_set_chip_handler_name_locked(d, &au1300_gpic, hdl, name);
 
 	au1300_gpic_chgcfg(d->irq - ALCHEMY_GPIC_INT_BASE, GPIC_CFG_IC_MASK, s);
 
