Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DD13W12428
	for linux-mips-outgoing; Fri, 13 Jul 2001 06:01:03 -0700
Received: from dea.waldorf-gmbh.de (u-18-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.18])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DD10V12424
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 06:01:01 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6DBZIO01441;
	Fri, 13 Jul 2001 13:35:18 +0200
Date: Fri, 13 Jul 2001 13:35:18 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: sti() does not work.
Message-ID: <20010713133517.C1378@bacchus.dhis.org>
References: <20010704152619.E3829@bacchus.dhis.org> <Pine.GSO.3.96.1010705132623.11517D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010705132623.11517D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jul 05, 2001 at 01:35:11PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 05, 2001 at 01:35:11PM +0200, Maciej W. Rozycki wrote:

> > > (why is noreorder used here?).
> > 
> > Without the .set noreorder the assembler would be free to do arbitrary
> > reordering of the object code generated.  Gas doesn't do that but there
> > are other assemblers that do flow analysis and may generate object code
> > that doesn't look very much like the source they were fed with.
> 
>  Hmm, I would consider that a bug in such an assembler.  The mtc0 and
> possibly the mfc0 opcode should be treated as reordering barriers as they
> may involve side effects an assembler might not be aware of. 

Assembler is the art of using sideeffects so things are fairly explicit.
Optimizations are controlled using

  .set noreorder / reorder
  .set volatile / novolatile
  .set nomove / nomove
  .set nobopt / bopt

  Ralf
