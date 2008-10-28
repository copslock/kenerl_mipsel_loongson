Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 16:18:08 +0000 (GMT)
Received: from [81.2.74.4] ([81.2.74.4]:13238 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22594383AbYJ1QSA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 16:18:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9SGHv8h000715;
	Tue, 28 Oct 2008 16:17:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9SGHvCo000713;
	Tue, 28 Oct 2008 16:17:57 GMT
Date:	Tue, 28 Oct 2008 16:17:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 02/36] Add Cavium OCTEON files to
	arch/mips/include/asm/mach-cavium-octeon
Message-ID: <20081028161757.GA349@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <20081028075733.GB20858@linux-mips.org> <alpine.LFD.1.10.0810281600460.27396@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810281600460.27396@ftp.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 28, 2008 at 04:02:44PM +0000, Maciej W. Rozycki wrote:

> > > +/* 144 - 151 represent the i8259 master */
> > > +#define OCTEON_IRQ_I8259M0      144
> > > +#define OCTEON_IRQ_I8259M1      145
> > > +#define OCTEON_IRQ_I8259M2      146
> > > +#define OCTEON_IRQ_I8259M3      147
> > > +#define OCTEON_IRQ_I8259M4      148
> > > +#define OCTEON_IRQ_I8259M5      149
> > > +#define OCTEON_IRQ_I8259M6      150
> > > +#define OCTEON_IRQ_I8259M7      151
> > > +/* 152 - 159 represent the i8259 slave */
> > > +#define OCTEON_IRQ_I8259S0      152
> > > +#define OCTEON_IRQ_I8259S1      153
> > > +#define OCTEON_IRQ_I8259S2      154
> > > +#define OCTEON_IRQ_I8259S3      155
> > > +#define OCTEON_IRQ_I8259S4      156
> > > +#define OCTEON_IRQ_I8259S5      157
> > > +#define OCTEON_IRQ_I8259S6      158
> > > +#define OCTEON_IRQ_I8259S7      159
> > 
> > You have some code for an i8259.  Since ISA interrupts are well known
> > numbers which are even hardcoded in drivers, manuals, printed on PCBs
> > etc. I recommend to renumber interrupts such that i8259 interrupts are
> > interrupts 0..15 and everything else follows after.  Oh the pleassures
> > of ISA cruft.
> 
>  I have long had plans to lift this stupid assumption and if I finally 
> lose my patience, I may even actually do it one day. ;)

If we're talking about actual ISA cards - I don't think we should even try
to remove the restriction.  Interrupt numbers are printed on PCBs and
the sysadmin has to jumper the bloody board so for sanity and consistency
we rather stick to 0..15 for these systems.

It's different for systems that only have on-board ISA-peripherals with
no jumpers - but making that difference only makes it more complicated
again ...

  Ralf
