Received: from cthulhu.engr.sgi.com ([192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA16463; Wed, 20 Aug 1997 08:03:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA16934 for linux-list; Wed, 20 Aug 1997 08:02:48 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA16888 for <linux@cthulhu.engr.sgi.com>; Wed, 20 Aug 1997 08:02:38 -0700
Received: from gatekeeper.qms.com (gatekeeper.qms.com [161.33.3.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id IAA17608
	for <linux@cthulhu.engr.sgi.com>; Wed, 20 Aug 1997 08:02:33 -0700
	env-from (marks@sun470.rd.qms.com)
Received: from sun470.rd.qms.com (sun470.qms.com) by gatekeeper.qms.com (4.1/SMI-4.1)
	id AA16384; Wed, 20 Aug 97 10:02:27 CDT
Received: from neptune.rd.qms.com by sun470.rd.qms.com (4.1/SMI-4.1)
	id AA15592; Wed, 20 Aug 97 10:02:25 CDT
Received: by neptune.rd.qms.com (4.1) id AA03372; Wed, 20 Aug 97 10:02:24 CDT
Date: Wed, 20 Aug 97 10:02:24 CDT
Message-Id: <9708201502.AA03372@neptune.rd.qms.com>
From: Mark Salter <marks@sun470.sun470.rd.qms.com>
To: linux@cthulhu.engr.sgi.com
Subject: ethernet driver patch
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


This patch seems to have fixed the excessive ethernet timeouts
I've been seeing. The problem was a race condition when queueing
another packet for transmisson. The code in sgiseeq_start_xmit()
would try to start another transmission from the head of the
transmit queue if the HPC was inactive. Because interrupts are
off at this time, it was possible that that packet had been
transmitted but the queue head had not been advanced by an
interrupt service. This resulted in a duplicate packet being
sent over the wire and when interrupts were reenabled, the
normal ack'ing of the original transmission of that packet
would put the HPC into a wedged state which eventually led to
a timeout and reset.

--Mark


*** sgiseeq.c.orig	Wed Aug 20 09:36:58 1997
--- sgiseeq.c	Wed Aug 20 09:37:08 1997
***************
*** 351,356 ****
--- 351,375 ----
  	}
  }
  
+ static inline void kick_tx(struct sgiseeq_tx_desc *td,
+ 			   volatile struct hpc3_ethregs *hregs)
+ {
+ 	/* If the HPC aint doin nothin, and there are more packets
+ 	 * with ETXD cleared and XIU set we must make very certain
+ 	 * that we restart the HPC else we risk locking up the
+ 	 * adapter.  The following code is only safe iff the HPCDMA
+ 	 * is not active!
+ 	 */
+ 	while((td->tdma.cntinfo & (HPCDMA_XIU | HPCDMA_ETXD)) ==
+ 	      (HPCDMA_XIU | HPCDMA_ETXD))
+ 		td = (struct sgiseeq_tx_desc *)
+ 			KSEG1ADDR(td->tdma.pnext);
+ 	if(td->tdma.cntinfo & HPCDMA_XIU) {
+ 		hregs->tx_ndptr = PHYSADDR(td);
+ 		hregs->tx_ctrl = HPC3_ETXCTRL_ACTIVE;
+ 	}
+ }
+ 
  static inline void sgiseeq_tx(struct device *dev, struct sgiseeq_private *sp,
  			      volatile struct hpc3_ethregs *hregs,
  			      volatile struct sgiseeq_regs *sregs)
***************
*** 371,392 ****
  			if(status & SEEQ_TSTAT_LCLS)
  				sp->stats.collisions++;
  		}
! 		/* If the HPC aint doin nothin, and there are more packets
! 		 * with ETXD cleared and XIU set we must make very certain
! 		 * that we restart the HPC else we risk locking up the
! 		 * adapter.  The following read of tx_ndptr is only safe
! 		 * iff the HPCDMA is not active!
! 		 */
! 		td = (struct sgiseeq_tx_desc *)
! 			KSEG1ADDR(((hregs->tx_ndptr) & ~0xf));
! 		while((td->tdma.cntinfo & (HPCDMA_XIU | HPCDMA_ETXD)) ==
! 		      (HPCDMA_XIU | HPCDMA_ETXD))
! 			td = (struct sgiseeq_tx_desc *)
! 				KSEG1ADDR(td->tdma.pnext);
! 		if(td->tdma.cntinfo & HPCDMA_XIU) {
! 			hregs->tx_ndptr = PHYSADDR(td);
! 			hregs->tx_ctrl = HPC3_ETXCTRL_ACTIVE;
! 		}
  	}
  
  	/* Ack 'em... */
--- 390,397 ----
  			if(status & SEEQ_TSTAT_LCLS)
  				sp->stats.collisions++;
  		}
! 		kick_tx((struct sgiseeq_tx_desc *)KSEG1ADDR((hregs->tx_ndptr & ~0xf)),
! 			hregs);
  	}
  
  	/* Ack 'em... */
***************
*** 515,521 ****
  	}
  
  	if(skb->len <= 0) {
! 		printk("%s: skb len is %ld\n", dev->name, skb->len);
  		return -1;
  	}
  	/* Are we getting in someone else's way? */
--- 520,526 ----
  	}
  
  	if(skb->len <= 0) {
! 		printk("%s: skb len is %d\n", dev->name, skb->len);
  		return -1;
  	}
  	/* Are we getting in someone else's way? */
***************
*** 575,584 ****
  	sp->tx_new = NEXT_TX(sp->tx_new); /* Advance. */
  
  	/* Maybe kick the HPC back into motion. */
! 	if(!(hregs->tx_ctrl & HPC3_ETXCTRL_ACTIVE)) {
! 		hregs->tx_ndptr = PHYSADDR(&sp->srings.tx_desc[sp->tx_old]);
! 		hregs->tx_ctrl = HPC3_ETXCTRL_ACTIVE;
! 	}
  	dev->trans_start = jiffies;
  	dev_kfree_skb(skb, FREE_WRITE);
  
--- 580,588 ----
  	sp->tx_new = NEXT_TX(sp->tx_new); /* Advance. */
  
  	/* Maybe kick the HPC back into motion. */
! 	if(!(hregs->tx_ctrl & HPC3_ETXCTRL_ACTIVE))
! 		kick_tx(&sp->srings.tx_desc[sp->tx_old], hregs);
! 
  	dev->trans_start = jiffies;
  	dev_kfree_skb(skb, FREE_WRITE);
  
