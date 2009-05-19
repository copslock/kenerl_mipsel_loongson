Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 13:53:39 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48522 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023992AbZESMxd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 13:53:33 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4JCrBYv018047;
	Tue, 19 May 2009 13:53:11 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4JCrATa018043;
	Tue, 19 May 2009 13:53:10 +0100
Date:	Tue, 19 May 2009 13:53:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Laurent GUERBY <laurent@guerby.net>
Cc:	Jon Fraser <jfraser@broadcom.com>,
	Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Bigsur?
Message-ID: <20090519125310.GA17733@linux-mips.org>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com> <1242663215.18301.26.camel@chaos.ne.broadcom.com> <20090518222334.GD16847@linux-mips.org> <alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org> <1242735440.6098.101.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242735440.6098.101.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 19, 2009 at 02:17:20PM +0200, Laurent GUERBY wrote:

> On Mon, 2009-05-18 at 23:47 +0100, Maciej W. Rozycki wrote:
> >  Yes, invaluable for native builds and there is a considerable number of 
> > software packages which is not capable of being cross-compiled, or 
> > requires extreme contortions to be built this way, or if buildable with a 
> > reasonable effort, the functionality is limited.  Besides a three-stage 
> > GCC bootstrap is a good way of verifying the quality of the tool, never 
> > mind standard DejaGNU-based regression testing which although possible 
> > using cross-tools and a remote target, is awfully painful to be set up 
> > this way.
> 
> For MIPS in the GCC Compile Farm http://gcc.gnu.org/wiki/CompileFarm
> (which is open to all free software, not limited to GCC) we
> have two loongson-2f based netbooks on which a GCC bootstrap
> and check is manageable.
> 
> Right now this farm is more oriented towards upstream userland
> developpers debug/test cycles - they get access to 12 architectures when
> they sign in. It's not really oriented towards porting
> kernel/distributions or building distribution packages which is already
> well covered by existing distribution farms and individual developpers
> and those developpers should get priority on new hardware :).
> 
> This farm project is part of the Free Software Fundation France (a
> french not-for-profit organization) effort to help free software
> development and we accept hardware and hosting donations, and also
> discounts to purchase commercial hardware when donations are not
> possible and there is significant interest in one platform.

That I think is a great solution for people who need short term access
but doesn't really solve the fundamental problem that hardware with
sufficient punch for efficient native development isn't easily available.

  Ralf
