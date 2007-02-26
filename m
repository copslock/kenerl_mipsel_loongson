Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2007 10:28:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12936 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038414AbXBZK17 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Feb 2007 10:27:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1QAR4ZI030249;
	Mon, 26 Feb 2007 10:27:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1QAQx4s030242;
	Mon, 26 Feb 2007 10:26:59 GMT
Date:	Mon, 26 Feb 2007 10:26:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jeff Garzik <jeff@garzik.org>
Cc:	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Philip Guo <pg@cs.stanford.edu>, ahennessy@mvista.com,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: possible bug in net/tc35815.c in linux-2.6.19
Message-ID: <20070226102659.GA28439@linux-mips.org>
References: <45DFEC09.3020801@cs.stanford.edu> <45E031A3.806@googlemail.com> <45E0B651.2050601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45E0B651.2050601@garzik.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 24, 2007 at 05:04:01PM -0500, Jeff Garzik wrote:

> >>I am a graduate student working on finding bugs in Linux drivers using
> >>an automated research tool.  I think I've found a possible bug in
> >>net/tc35815.c, and I'd appreciate it if you could confirm/disconfirm it.
> >>
> >>Thanks,
> >>Philip
> >>
> >>---
> >>net/tc35815.c
> >>
> >>tc35815_driver is never unregistered in tc35815_cleanup_module()
> >>
> >>static int __init tc35815_init_module(void)
> >>{
> >>    return pci_register_driver(&tc35815_driver);
> >>}
> >>
> >>static void __exit tc35815_cleanup_module(void)
> >>{
> >>    struct net_device *next_dev;
> >>
> >>    while (root_tc35815_dev) {
> >>        struct net_device *dev = root_tc35815_dev;
> >>        next_dev = ((struct tc35815_local *)dev->priv)->next_module;
> >>        iounmap((void *)(dev->base_addr));
> >>        unregister_netdev(dev);
> >>        free_netdev(dev);
> >>        root_tc35815_dev = next_dev;
> >>    }
> >>}
> >>
> >>
> >
> >I think that you are right, but I don't know this code.
> >
> >Jeff, what do you think about this?
> >
> >Regards,
> >Michal
> 
> I created my own patch for this (and one other bug), and checked it in.
> 
> Really, though, someone in MIPS-land should give this driver some loving 
> care.  It is filled with bugs and 2.4-era anachronisms.

Took a look at it.  It's sort of a non-bug because the driver cannot be
compiled as module, so the module_exit function cannot possibly be
executed.  The board support code is calling into the driver which makes
it impossible to build this driver as a module, yet it's possible to
select building this driver as a module ...  Oh yeah, that root_tc35815_dev
stuff is also pretty ugly.

Atsushi?

  Ralf
