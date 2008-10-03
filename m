Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2008 19:25:50 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:27295
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20476585AbYJCSZs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Oct 2008 19:25:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m93IPjOo025382;
	Fri, 3 Oct 2008 19:25:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m93IPhON025381;
	Fri, 3 Oct 2008 19:25:43 +0100
Date:	Fri, 3 Oct 2008 19:25:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE
	driver
Message-ID: <20081003182542.GA24989@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <20080928175450.GA8478@linux-mips.org> <48DFFC62.9050300@ru.mvista.com> <200810031900.55214.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200810031900.55214.bzolnier@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 03, 2008 at 07:00:54PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > > The Swarm IDE driver uses a release method which is defined in the driver
> > > itself thus potentially oopsable.  The simple fix would be to just leak
> > > the device but this patch goes the full length and moves the entire
> > > handling of the platform device in the platform code and retains only
> > > the platform driver code in drivers/ide/mips/swarm.c.
> > >
> > > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> wow, v2 happened really quickly :)

It not just tidying up, it fixing a potencial crash so had to happen
quickly to (hopefully) make the release ...

> [ I removed no longer needed BLK_DEV_IDE_SWARM from ide/Kconfig while at it ]

Thanks!

  Ralf
