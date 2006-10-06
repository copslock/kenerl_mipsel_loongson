Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 12:26:52 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5900 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039021AbWJFL0q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Oct 2006 12:26:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 25875F59DD;
	Fri,  6 Oct 2006 13:26:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZMVGRJZ+l6Ie; Fri,  6 Oct 2006 13:26:20 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id ADA48E1C66;
	Fri,  6 Oct 2006 13:26:20 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k96BQPVc016697;
	Fri, 6 Oct 2006 13:26:25 +0200
Date:	Fri, 6 Oct 2006 12:26:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>
cc:	Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 3/6] 2.6.18: sb1250-mac: Phylib IRQ handling fixes
In-Reply-To: <20061005234310.6c8042b5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64N.0610061152340.22053@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl>
 <20061005234310.6c8042b5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1999/Thu Oct  5 19:35:38 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 5 Oct 2006, Andrew Morton wrote:

> > 2. The driver uses schedule_work() for handling interrupts, but does not 
> >    make sure any pending work scheduled thus has been completed before 
> >    driver's structures get freed from memory.  This is especially 
> >    important as interrupts may keep arriving if the line is shared with 
> >    another PHY.
> > 
> >    The solution is to ignore phy_interrupt() calls if the reported device 
> >    has already been halted and calling flush_scheduled_work() from 
> >    phy_stop_interrupts() (but guarded with current_is_keventd() in case 
> >    the function has been called through keventd from the MAC device's 
> >    close call to avoid a deadlock on the netlink lock).
> > 
> 
> eww, hack.
> 
> Also not module-friendly:
> 
> WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!
> 
> Does this
> 
> static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
> {
> 	if (cwq->thread == current) {
> 		/*
> 		 * Probably keventd trying to flush its own queue. So simply run
> 		 * it by hand rather than deadlocking.
> 		 */
> 		run_workqueue(cwq);
> 
> not work???

 It does, too well even! -- in the case I am trying to take care of we are 
run with "rtnl_mutex" held as a result of rtnl_lock() called from 
unregister_netdev() and there is some work already in the workqueue 
(linkwatch_event(), apparently) wanting to acquire the same lock.  Hence a 
deadlock.  It seems problematic elsewhere as well -- see tg3.c -- but a 
different way to deal with it has been found there.

 I am not that fond of this solution, but at least it works, unlike 
calling flush_scheduled_work() here, which deadlocks the current CPU in my 
system instantly.  Any suggestions as to how to do this differently?  
Perhaps linkwatch_event() should be scheduled differently (using a 
separate workqueue?)...  Or does dev_close() have to be called under this 
lock from unregister_netdevice()?  Perhaps code like this would do:

	while (dev->flags & IFF_UP) {
		rtnl_unlock();
		dev_close(dev);
		rtnl_lock();
	}

  Maciej
