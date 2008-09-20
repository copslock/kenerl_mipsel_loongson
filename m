Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 21:18:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:1226 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S36909228AbYITUSo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2008 21:18:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8KKIgMX002545;
	Sat, 20 Sep 2008 22:18:43 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8KKIdom002543;
	Sat, 20 Sep 2008 22:18:39 +0200
Date:	Sat, 20 Sep 2008 22:18:39 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jeff Garzik <jgarzik@redhat.com>
Cc:	Weiwei Wang <weiwei.wang@windriver.com>, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] convert sbmac tx to spin_lock_irqsave to prevent early
	IRQ enable
Message-ID: <20080920201839.GA27700@linux-mips.org>
References: <6781da3918e3c34d23e5f7e9cf777ab463a17d5e.1221613284.git.weiwei.wang@windriver.com> <20080917114051.GA30734@shell.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080917114051.GA30734@shell.devel.redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 17, 2008 at 07:40:51AM -0400, Jeff Garzik wrote:

> On Wed, Sep 17, 2008 at 10:25:37AM +0800, Weiwei Wang wrote:
> > Netpoll will call the interrupt handler with interrupts
> > disabled when using kgdboe, so spin_lock_irqsave() should
> > be used instead of spin_lock_irq() to prevent interrupts
> > from being incorrectly enabled.
> > 
> > Signed-off-by: Weiwei Wang <weiwei.wang@windriver.com>
> > ---
> >  drivers/net/sb1250-mac.c |   12 +++++++-----
> >  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> Please send to jeff@garzik.org or jgarzik@pobox.com.

Jeff - I haven't looked at kgdboe but if he's right half of drivers/net
will need to be fixed ...

  Ralf
