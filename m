Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 16:53:07 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:16593 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8226093AbVF3Pwu>; Thu, 30 Jun 2005 16:52:50 +0100
Received: from gw.junsun.net (c-24-6-106-170.hsd1.ca.comcast.net[24.6.106.170])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005063015522801300ru20ce>; Thu, 30 Jun 2005 15:52:29 +0000
Received: from gw.junsun.net (gw.junsun.net [127.0.0.1])
	by gw.junsun.net (8.13.1/8.13.1) with ESMTP id j5UFqKJf025050;
	Thu, 30 Jun 2005 08:52:21 -0700
Received: (from jsun@localhost)
	by gw.junsun.net (8.13.1/8.13.1/Submit) id j5UFqJ8s025049;
	Thu, 30 Jun 2005 08:52:19 -0700
Date:	Thu, 30 Jun 2005 08:52:19 -0700
From:	Jun Sun <jsun@junsun.net>
To:	maxim@mox.ru
Cc:	Ralf Baechle <ralf@linux-mips.org>, Krishna B S <bskris@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: Popular MIPS4Kc boards?
Message-ID: <20050630155219.GC21968@gw.junsun.net>
References: <1943a413050629014858a124f7@mail.gmail.com> <20050630091056.GA2935@linux-mips.org> <6097c49050630030859b061c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6097c49050630030859b061c5@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Thu, Jun 30, 2005 at 02:08:32PM +0400, Maxim Osipov wrote:
> And if we talk about fan project, are there any MIPS64 based devices on market?
> 

Another 64bit MIPS CPU based device is Tivo series 2.  So I heard.

Jun

> On 6/30/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Wed, Jun 29, 2005 at 02:18:40PM +0530, Krishna B S wrote:
> > 
> > > I have to develop toolchains for various MIPS boards my company
> > > develops. All the boards consist of MIPS 4KC.
> > >
> > > I would like to know from you what is the most popular board used by
> > > the community with this kind of processor. I know, its tough to get a
> > > clear answer.
> > >
> > > But, my intention is to first port my toolchain/kernel for this
> > > popular board so that I can get your support, in case I encounter any
> > > problems. Having confirmed the working of the toolchain for this
> > > board, I would port it to my company's boards.
> > >
> > > (The popular board in the community would be my reference board for
> > > development.)
> > 
> > The price tag is juicy but for serious development with a 4Kc I'd
> > recommend a MIPS Malta.  Forcing consumer hardware into submission may
> > be a fun project for a spare time hacker but in general isn't a very
> > productive process for somebody who needs to finish a job soon or needs
> > to additional hardware such as PCI cards, logic analyzer, additional
> > memory, other CPU types etc.
> > 
> >   Ralf
> > 
> >
