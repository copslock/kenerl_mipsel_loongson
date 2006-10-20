Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2006 23:13:44 +0100 (BST)
Received: from smtp.osdl.org ([65.172.181.4]:17037 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20038942AbWJTWNi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2006 23:13:38 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KMDTaX011498
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 15:13:30 -0700
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k9KMDS0L005250;
	Fri, 20 Oct 2006 15:13:28 -0700
Date:	Fri, 20 Oct 2006 15:13:28 -0700
From:	Andrew Morton <akpm@osdl.org>
To:	Andy Fleming <afleming@freescale.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 3/6] 2.6.18: sb1250-mac: Phylib IRQ handling fixes
Message-Id: <20061020151328.788bc38e.akpm@osdl.org>
In-Reply-To: <E2ACBAE3-B0E1-4D90-BF25-6981543090C4@freescale.com>
References: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl>
	<E2ACBAE3-B0E1-4D90-BF25-6981543090C4@freescale.com>
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
X-archive-position: 13047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Fri, 20 Oct 2006 16:40:20 -0500
Andy Fleming <afleming@freescale.com> wrote:

> >    The solution is to ignore phy_interrupt() calls if the reported  
> > device
> >    has already been halted and calling flush_scheduled_work() from
> >    phy_stop_interrupts() (but guarded with current_is_keventd() in  
> > case
> >    the function has been called through keventd from the MAC device's
> >    close call to avoid a deadlock on the netlink lock).
> 
> 
> I've been trying to figure out this problem since you posted this,  
> and I'm not sure I understand it fully

Me either, but I basically gave up.

If it is deadlocky for keventd to call flush_scheduled_work() I fail to see
why it is not deadlocky for other processes.

If the caller of flush_scheduled_work() holds rtnl_lock, and if a queued
work callback also takes rtnl_lock then the flush_scheduled_work() caller
will deadlock regardless of whether or not it is keventd.

Because the flush_scheduled_work() caller holds a lock which will prevent
the flush from completing.
