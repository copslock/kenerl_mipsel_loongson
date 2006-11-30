Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2006 18:07:58 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4102 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037721AbWK3SHx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Nov 2006 18:07:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 86771F5968;
	Thu, 30 Nov 2006 19:07:36 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3i5UWlCnytpy; Thu, 30 Nov 2006 19:07:36 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1B94DF5946;
	Thu, 30 Nov 2006 19:07:36 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kAUI7nG2001218;
	Thu, 30 Nov 2006 19:07:49 +0100
Date:	Thu, 30 Nov 2006 18:07:45 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andy Fleming <afleming@freescale.com>
cc:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 3/6] 2.6.18: sb1250-mac: Phylib IRQ handling fixes
In-Reply-To: <Pine.LNX.4.64N.0610231752440.4426@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.64N.0611301757200.1757@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl>
 <E2ACBAE3-B0E1-4D90-BF25-6981543090C4@freescale.com>
 <Pine.LNX.4.64N.0610231752440.4426@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.6/2263/Thu Nov 30 07:51:08 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 23 Oct 2006, Maciej W. Rozycki wrote:

> > I'm not too enthusiastic about requiring the ethernet drivers to call
> > phy_disconnect in a separate thread after "close" is called.  Assuming there's
> > not some sort of "squash work queue" function that can be invoked with
> > rtnl_lock held, I think phy_disconnect should schedule itself to flush the
> > queue.  This would also require that mdiobus_unregister hold off on freeing
> > phydevs if any of the phys were still waiting for pending flush_pending calls
> > to finish.  Which would, in turn, require mdiobus_unregister to schedule
> > cleaning up memory for some later time.
> 
>  This could work, indeed.
> 
> > I'm not enthusiastic about that implementation, either, but it maintains the
> > abstractions I consider important for this code.  The ethernet driver should
> > not need to know what structures the PHY lib uses to implement its interrupt
> > handling, and how to work around their failings, IMHO.
> 
>  Agreed.

 So what's the plan?

 Here's a new version of the patch that addresses your other concerns.

  Maciej

patch-mips-2.6.18-20060920-phy-irq-18
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/net/phy/phy.c linux-mips-2.6.18-20060920/drivers/net/phy/phy.c
--- linux-mips-2.6.18-20060920.macro/drivers/net/phy/phy.c	2006-08-05 04:58:46.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/net/phy/phy.c	2006-11-30 17:58:37.000000000 +0000
@@ -7,6 +7,7 @@
  * Author: Andy Fleming
  *
  * Copyright (c) 2004 Freescale Semiconductor, Inc.
+ * Copyright (c) 2006  Maciej W. Rozycki
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -32,6 +33,8 @@
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -484,6 +487,9 @@ static irqreturn_t phy_interrupt(int irq
 {
 	struct phy_device *phydev = phy_dat;
 
+	if (PHY_HALTED == phydev->state)
+		return IRQ_NONE;		/* It can't be ours.  */
+
 	/* The MDIO bus is not allowed to be written in interrupt
 	 * context, so we need to disable the irq here.  A work
 	 * queue will write the PHY to disable and clear the
@@ -577,6 +583,13 @@ int phy_stop_interrupts(struct phy_devic
 	if (err)
 		phy_error(phydev);
 
+	/*
+	 * Finish any pending work; we might have been scheduled
+	 * to be called from keventd ourselves, though.
+	 */
+	if (!current_is_keventd())
+		flush_scheduled_work();
+
 	free_irq(phydev->irq, phydev);
 
 	return err;
@@ -596,14 +609,17 @@ static void phy_change(void *data)
 		goto phy_err;
 
 	spin_lock(&phydev->lock);
+
 	if ((PHY_RUNNING == phydev->state) || (PHY_NOLINK == phydev->state))
 		phydev->state = PHY_CHANGELINK;
-	spin_unlock(&phydev->lock);
 
 	enable_irq(phydev->irq);
 
 	/* Reenable interrupts */
-	err = phy_config_interrupt(phydev, PHY_INTERRUPT_ENABLED);
+	if (PHY_HALTED != phydev->state)
+		err = phy_config_interrupt(phydev, PHY_INTERRUPT_ENABLED);
+
+	spin_unlock(&phydev->lock);
 
 	if (err)
 		goto irq_enable_err;
@@ -624,15 +640,15 @@ void phy_stop(struct phy_device *phydev)
 	if (PHY_HALTED == phydev->state)
 		goto out_unlock;
 
-	if (phydev->irq != PHY_POLL) {
-		/* Clear any pending interrupts */
-		phy_clear_interrupt(phydev);
+	phydev->state = PHY_HALTED;
 
+	if (phydev->irq != PHY_POLL) {
 		/* Disable PHY Interrupts */
 		phy_config_interrupt(phydev, PHY_INTERRUPT_DISABLED);
-	}
 
-	phydev->state = PHY_HALTED;
+		/* Clear any pending interrupts */
+		phy_clear_interrupt(phydev);
+	}
 
 out_unlock:
 	spin_unlock(&phydev->lock);
