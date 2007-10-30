Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 12:42:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5334 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024133AbXJ3MmE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 12:42:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9UCfuKr025037;
	Tue, 30 Oct 2007 12:41:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9UCft16025036;
	Tue, 30 Oct 2007 12:41:55 GMT
Date:	Tue, 30 Oct 2007 12:41:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Denys Vlasenko <vda.linux@googlemail.com>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org,
	Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
Subject: Re: [IDE] Fix build bug
Message-ID: <20071030124155.GA7582@linux-mips.org>
References: <20071025135334.GA23272@linux-mips.org> <200710252341.38902.bzolnier@gmail.com> <200710301134.30087.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200710301134.30087.vda.linux@googlemail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 30, 2007 at 11:34:29AM +0000, Denys Vlasenko wrote:

> On Thursday 25 October 2007 22:41, Bartlomiej Zolnierkiewicz wrote:
> > > -static const struct ide_port_info generic_chipsets[] __devinitdata = {
> > > +static struct ide_port_info generic_chipsets[] __devinitdata = {
> > >  	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
> > >  
> > >  	{	/* 1 */
> > 
> > I would prefer to not remove const from generic_chipsets[] so:
> > 
> > [PATCH] drivers/ide/pci/generic: fix build for CONFIG_HOTPLUG=n
> > 
> > It turns out that const and __{dev}initdata cannot be mixed currently
> > and that generic IDE PCI host driver is also affected by the same issue:
> > 
> > On Thursday 25 October 2007, Ralf Baechle wrote:
> > >   CC      drivers/ide/pci/generic.o
> > > drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> > > +section type conflict
> > 
> > [ Also reported by Martijn Uffing <mp3project@sarijopen.student.utwente.nl>. ]
> > 
> > This patch workarounds the problem in a bit hackish way but without
> > removing const from generic_chipsets[] (it adds const to __setup() so
> > __setup_str_ide_generic_all becomes const).
> 
> You wouldn't believe how much const data is not marked as const because
> we don't have __constinitdata etc. Literally megabytes.

The gain from marking it const is very little and once any non-const
__initdata object is added to a compilation unit all other const declarations
will have to be removed.  Bad tradeoff.

  Ralf
