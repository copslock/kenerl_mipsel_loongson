Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 19:01:19 +0100 (BST)
Received: from exch1.onstor.com ([66.201.51.80]:12518 "EHLO exch1.onstor.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025096AbZETSBN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 19:01:13 +0100
Received: from ripper.onstor.net (10.0.0.42) by exch1.onstor.com (10.0.0.224)
 with Microsoft SMTP Server id 8.1.311.2; Wed, 20 May 2009 11:01:06 -0700
Date:	Wed, 20 May 2009 11:01:05 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Laurent GUERBY <laurent@guerby.net>,
	Jon Fraser <jfraser@broadcom.com>,
	Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Bigsur?
Message-ID: <20090520110105.6fb81573@ripper.onstor.net>
In-Reply-To: <20090519125310.GA17733@linux-mips.org>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com>
	<1242663215.18301.26.camel@chaos.ne.broadcom.com>
	<20090518222334.GD16847@linux-mips.org>
	<alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org>
	<1242735440.6098.101.camel@localhost>
	<20090519125310.GA17733@linux-mips.org>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 2K3Xl1OQTInXD6xxuA8z3Q==
X-EMS-STAMP: F1vJUhij/Kk+rd5L/cfEGQ==
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Tue, 19 May 2009 05:53:10 -0700 Ralf Baechle <ralf@linux-mips.org>
wrote:

> On Tue, May 19, 2009 at 02:17:20PM +0200, Laurent GUERBY wrote:
> 
> > On Mon, 2009-05-18 at 23:47 +0100, Maciej W. Rozycki wrote:
> > >  Yes, invaluable for native builds and there is a considerable
> > > number of software packages which is not capable of being
> > > cross-compiled, or requires extreme contortions to be built this
> > > way, or if buildable with a reasonable effort, the functionality
> > > is limited.  Besides a three-stage GCC bootstrap is a good way of
> > > verifying the quality of the tool, never mind standard
> > > DejaGNU-based regression testing which although possible using
> > > cross-tools and a remote target, is awfully painful to be set up
> > > this way.
> > 
> > For MIPS in the GCC Compile Farm http://gcc.gnu.org/wiki/CompileFarm
> > (which is open to all free software, not limited to GCC) we
> > have two loongson-2f based netbooks on which a GCC bootstrap
> > and check is manageable.
> > 
> > Right now this farm is more oriented towards upstream userland
> > developpers debug/test cycles - they get access to 12 architectures
> > when they sign in. It's not really oriented towards porting
> > kernel/distributions or building distribution packages which is
> > already well covered by existing distribution farms and individual
> > developpers and those developpers should get priority on new
> > hardware :).
> > 
> > This farm project is part of the Free Software Fundation France (a
> > french not-for-profit organization) effort to help free software
> > development and we accept hardware and hosting donations, and also
> > discounts to purchase commercial hardware when donations are not
> > possible and there is significant interest in one platform.
> 
> That I think is a great solution for people who need short term access
> but doesn't really solve the fundamental problem that hardware with
> sufficient punch for efficient native development isn't easily
> available.

Question: are machines that must be NFS-root and tftp booted acceptable
or not acceptable for such work?  The machines in question would 750MHz
Sibyte 1250s, so 3 Gigabit ports natively, and 2 serial consoles.

Cheers,

a
