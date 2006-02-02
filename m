Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 16:51:51 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:36363 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465645AbWBBQve (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 16:51:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k12Guu7n021042;
	Thu, 2 Feb 2006 16:56:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k12Guuxa021041;
	Thu, 2 Feb 2006 16:56:56 GMT
Date:	Thu, 2 Feb 2006 16:56:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
Message-ID: <20060202165656.GC17352@linux-mips.org>
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0602021636380.11727@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602021636380.11727@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 02, 2006 at 04:38:37PM +0000, Maciej W. Rozycki wrote:
> Date:	Thu, 2 Feb 2006 16:38:37 +0000 (GMT)
> From:	"Maciej W. Rozycki" <macro@linux-mips.org>
> To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
> Subject: Re: [PATCH] TX49 MFC0 bug workaround
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
> On Fri, 3 Feb 2006, Atsushi Nemoto wrote:
> 
> > Workaround: mask EXL bit of the result or place a nop before mfc0.
> [...]
> > @@ -55,8 +56,13 @@ __asm__ (
> >  	"	di							\n"
> >  #else
> >  	"	mfc0	$1,$12						\n"
> > +#if TX49XX_MFC0_WAR && defined(MODULE)
> > +	"	ori	$1,3						\n"
> > +	"	xori	$1,3						\n"
> > +#else
> >  	"	ori	$1,1						\n"
> >  	"	xori	$1,1						\n"
> > +#endif
> >  	"	.set	noreorder					\n"
> >  	"	mtc0	$1,$12						\n"
> >  #endif
> 
>  Hmm, wouldn't that "nop" alternative be simpler?

Simpler maybe - but this variant has zero runtime overhead.

  Ralf
