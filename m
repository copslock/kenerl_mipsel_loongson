Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 16:02:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:55182 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22593681AbYJ1QCo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 16:02:44 +0000
Date:	Tue, 28 Oct 2008 16:02:44 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 02/36] Add Cavium OCTEON files to
 arch/mips/include/asm/mach-cavium-octeon
In-Reply-To: <20081028075733.GB20858@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0810281600460.27396@ftp.linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <20081028075733.GB20858@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Oct 2008, Ralf Baechle wrote:

> > +/* 144 - 151 represent the i8259 master */
> > +#define OCTEON_IRQ_I8259M0      144
> > +#define OCTEON_IRQ_I8259M1      145
> > +#define OCTEON_IRQ_I8259M2      146
> > +#define OCTEON_IRQ_I8259M3      147
> > +#define OCTEON_IRQ_I8259M4      148
> > +#define OCTEON_IRQ_I8259M5      149
> > +#define OCTEON_IRQ_I8259M6      150
> > +#define OCTEON_IRQ_I8259M7      151
> > +/* 152 - 159 represent the i8259 slave */
> > +#define OCTEON_IRQ_I8259S0      152
> > +#define OCTEON_IRQ_I8259S1      153
> > +#define OCTEON_IRQ_I8259S2      154
> > +#define OCTEON_IRQ_I8259S3      155
> > +#define OCTEON_IRQ_I8259S4      156
> > +#define OCTEON_IRQ_I8259S5      157
> > +#define OCTEON_IRQ_I8259S6      158
> > +#define OCTEON_IRQ_I8259S7      159
> 
> You have some code for an i8259.  Since ISA interrupts are well known
> numbers which are even hardcoded in drivers, manuals, printed on PCBs
> etc. I recommend to renumber interrupts such that i8259 interrupts are
> interrupts 0..15 and everything else follows after.  Oh the pleassures
> of ISA cruft.

 I have long had plans to lift this stupid assumption and if I finally 
lose my patience, I may even actually do it one day. ;)

  Maciej
