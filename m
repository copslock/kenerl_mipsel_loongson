Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 20:07:21 +0100 (BST)
Received: from smtp.osdl.org ([65.172.181.4]:40639 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20039152AbWJPTHS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2006 20:07:18 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GJ6uaX015655
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 12:07:00 -0700
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k9GJ6rnh024020;
	Mon, 16 Oct 2006 12:06:55 -0700
Date:	Mon, 16 Oct 2006 12:06:53 -0700
From:	Andrew Morton <akpm@osdl.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 3/6] 2.6.18: sb1250-mac: Phylib IRQ handling fixes
Message-Id: <20061016120653.9a70135d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0610161442010.28780@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl>
	<20061005234310.6c8042b5.akpm@osdl.org>
	<Pine.LNX.4.64N.0610061152340.22053@blysk.ds.pg.gda.pl>
	<20061006080323.185f2b58.akpm@osdl.org>
	<Pine.LNX.4.64N.0610161442010.28780@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Mon, 16 Oct 2006 15:50:55 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> Andrew,
> 
> > I don't get it.  If some code does
> > 
> > 	rtnl_lock();
> > 	flush_scheduled_work();
> > 
> > and there's some work scheduled which does rtnl_lock() then it'll deadlock.
> > 
> > But it'll deadlock whether or not the caller of flush_scheduled_work() is
> > keventd.
> > 
> > Calling flush_scheduled_work() under locks is generally a bad idea.
> 
>  Indeed -- this is why I avoid it.
> 
> > I'd have thought that was still deadlockable.  Could you describe the
> > deadlock more completely please?
> 
>  The simplest sequence of calls that prevents races here is as follows:
> 
> unregister_netdev();
>   rtnl_lock();
>   unregister_netdevice();
>     dev_close();
>       sbmac_close();
>         phy_stop();
>         phy_disconnect();
>           phy_stop_interrupts();
>             phy_disable_interrupts();
>             flush_scheduled_work();
>             free_irq();
>           phy_detach();
>         mdiobus_unregister();
>   rtnl_unlock();
> 
> We want to call flush_scheduled_work() from phy_stop_interrupts(), because 
> there may still be calls to phy_change() waiting for the keventd to 
> process and mdiobus_unregister() frees structures needed by phy_change().  
> This may deadlock because of the call to rtnl_lock() though.
> 
>  So the modified sequence I have implemented is as follows:
> 
> unregister_netdev();
>   rtnl_lock();
>   unregister_netdevice();
>     dev_close();
>       sbmac_close();
>         phy_stop();
>         schedule_work(); [sbmac_phy_disconnect()]
>   rtnl_unlock();
> 
> and then:
> 
> sbmac_phy_disconnect();
>   phy_disconnect();
>     phy_stop_interrupts();
>       phy_disable_interrupts();
>       free_irq();
>     phy_detach();
>   mdiobus_unregister();
> 
> This guarantees calls to phy_change() for this PHY unit will not be run 
> after mdiobus_unregister(), because any such calls have been placed in the 
> queue before sbmac_phy_disconnect() (phy_stop() prevents the interrupt 
> handler from issuing new calls to phy_change()).
> 
>  We still need flush_scheduled_work() to be called from 
> phy_stop_interrupts() though, in case some other MAC driver calls 
> phy_disconnect() (or phy_stop_interrupts(), depending on the abstraction 
> layer of phylib used) directly rather than using keventd.  This is 
> possible if phy_disconnect() is called from the driver's module_exit() 
> call, which may make sense for devices that are known not to have their 
> MII interface available as an external connector.  Hence the:
> 
> if (!current_is_keventd())
>   flush_scheduled_work();
> 
> sequence in phy_stop_interrupts().  Of course, we can force all drivers 
> using phylib (in the interrupt mode) to call phy_disconnect() through 
> keventd instead.
> 
>  Does it sound clearer?
> 

Vaguely.  Why doesn't it deadlock if !current_is_keventd()?  I mean,
whether or not the caller is keventd, the flush_scheduled_work() caller
will still be dependent upon rtnl_lock() being acquirable.
