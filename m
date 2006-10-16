Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 15:51:11 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:43277 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039620AbWJPOvG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 15:51:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id AB1C8E1C8A;
	Mon, 16 Oct 2006 16:50:49 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LhtbzwRMzsnT; Mon, 16 Oct 2006 16:50:49 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 07E61E1C89;
	Mon, 16 Oct 2006 16:50:48 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k9GEouUJ015690;
	Mon, 16 Oct 2006 16:50:57 +0200
Date:	Mon, 16 Oct 2006 15:50:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>
cc:	Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 3/6] 2.6.18: sb1250-mac: Phylib IRQ handling fixes
In-Reply-To: <20061006080323.185f2b58.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64N.0610161442010.28780@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl>
 <20061005234310.6c8042b5.akpm@osdl.org> <Pine.LNX.4.64N.0610061152340.22053@blysk.ds.pg.gda.pl>
 <20061006080323.185f2b58.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Andrew,

> I don't get it.  If some code does
> 
> 	rtnl_lock();
> 	flush_scheduled_work();
> 
> and there's some work scheduled which does rtnl_lock() then it'll deadlock.
> 
> But it'll deadlock whether or not the caller of flush_scheduled_work() is
> keventd.
> 
> Calling flush_scheduled_work() under locks is generally a bad idea.

 Indeed -- this is why I avoid it.

> I'd have thought that was still deadlockable.  Could you describe the
> deadlock more completely please?

 The simplest sequence of calls that prevents races here is as follows:

unregister_netdev();
  rtnl_lock();
  unregister_netdevice();
    dev_close();
      sbmac_close();
        phy_stop();
        phy_disconnect();
          phy_stop_interrupts();
            phy_disable_interrupts();
            flush_scheduled_work();
            free_irq();
          phy_detach();
        mdiobus_unregister();
  rtnl_unlock();

We want to call flush_scheduled_work() from phy_stop_interrupts(), because 
there may still be calls to phy_change() waiting for the keventd to 
process and mdiobus_unregister() frees structures needed by phy_change().  
This may deadlock because of the call to rtnl_lock() though.

 So the modified sequence I have implemented is as follows:

unregister_netdev();
  rtnl_lock();
  unregister_netdevice();
    dev_close();
      sbmac_close();
        phy_stop();
        schedule_work(); [sbmac_phy_disconnect()]
  rtnl_unlock();

and then:

sbmac_phy_disconnect();
  phy_disconnect();
    phy_stop_interrupts();
      phy_disable_interrupts();
      free_irq();
    phy_detach();
  mdiobus_unregister();

This guarantees calls to phy_change() for this PHY unit will not be run 
after mdiobus_unregister(), because any such calls have been placed in the 
queue before sbmac_phy_disconnect() (phy_stop() prevents the interrupt 
handler from issuing new calls to phy_change()).

 We still need flush_scheduled_work() to be called from 
phy_stop_interrupts() though, in case some other MAC driver calls 
phy_disconnect() (or phy_stop_interrupts(), depending on the abstraction 
layer of phylib used) directly rather than using keventd.  This is 
possible if phy_disconnect() is called from the driver's module_exit() 
call, which may make sense for devices that are known not to have their 
MII interface available as an external connector.  Hence the:

if (!current_is_keventd())
  flush_scheduled_work();

sequence in phy_stop_interrupts().  Of course, we can force all drivers 
using phylib (in the interrupt mode) to call phy_disconnect() through 
keventd instead.

 Does it sound clearer?

  Maciej
