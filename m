Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 16:16:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44502 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023031AbXJ1QQf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 16:16:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9SNdgR0016621;
	Sun, 28 Oct 2007 23:39:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9SNdfSV016620;
	Sun, 28 Oct 2007 23:39:41 GMT
Date:	Sun, 28 Oct 2007 23:39:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use a sensible tlbex default for unknown CPUs
Message-ID: <20071028233941.GA16471@linux-mips.org>
References: <20071025155912.GD3994@networkno.de> <Pine.LNX.4.64N.0710251707170.24086@blysk.ds.pg.gda.pl> <20071025205654.GF3994@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071025205654.GF3994@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 09:56:54PM +0100, Thiemo Seufer wrote:

> > > currently the kernel panics when it boots on an unknown CPU model
> > > (with an unknown PRID). Based on the assumption that the majority
> > > of newly supported CPU will conform to Release 2 standard, I wrote
> > > the appended patch which handles unknown CPUs as R2. It isn't
> > > completely bulletproof, as (yet unsupported) non-R1/R2 CPUs may
> > > use the AT config bits for different purposes. I still think this
> > > is good enough a test.
> > 
> >  Good idea in general, but do we have to rely on the undefined?  How 
> > about this:
> > 
> > > +		/* Panic if this isn't a Release 2 CPU. */
> > > +		if (!((read_c0_config() & MIPS_CONF_AT) >> 13)) {
> > 
> > 	if (!(current_cpu_data.isa_level &
> > 	      (MIPS_CPU_ISA_M64R2 | MIPS_CPU_ISA_M32R2))) {
> > 
> > instead for example?
> 
> This is circular, as isa_level won't be initialized for a unknown CPU.
> The *_r2 check suggested by Ralf has the same problem AFAICS, so it
> looks like we have to stick with the original solution.

The ISA level is determined earlier by another probe.  If it cannot be
determined the kernel will already have paniced so the cleaner variant is
ok.

  Ralf
