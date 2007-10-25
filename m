Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 21:57:40 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:54708 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20027247AbXJYU5b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 21:57:31 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 182DE48EA5;
	Thu, 25 Oct 2007 22:50:18 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1Il9l8-0003qt-8u; Thu, 25 Oct 2007 21:56:54 +0100
Date:	Thu, 25 Oct 2007 21:56:54 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Use a sensible tlbex default for unknown CPUs
Message-ID: <20071025205654.GF3994@networkno.de>
References: <20071025155912.GD3994@networkno.de> <Pine.LNX.4.64N.0710251707170.24086@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710251707170.24086@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 25 Oct 2007, Thiemo Seufer wrote:
> 
> > currently the kernel panics when it boots on an unknown CPU model
> > (with an unknown PRID). Based on the assumption that the majority
> > of newly supported CPU will conform to Release 2 standard, I wrote
> > the appended patch which handles unknown CPUs as R2. It isn't
> > completely bulletproof, as (yet unsupported) non-R1/R2 CPUs may
> > use the AT config bits for different purposes. I still think this
> > is good enough a test.
> 
>  Good idea in general, but do we have to rely on the undefined?  How 
> about this:
> 
> > +		/* Panic if this isn't a Release 2 CPU. */
> > +		if (!((read_c0_config() & MIPS_CONF_AT) >> 13)) {
> 
> 	if (!(current_cpu_data.isa_level &
> 	      (MIPS_CPU_ISA_M64R2 | MIPS_CPU_ISA_M32R2))) {
> 
> instead for example?

This is circular, as isa_level won't be initialized for a unknown CPU.
The *_r2 check suggested by Ralf has the same problem AFAICS, so it
looks like we have to stick with the original solution.


Thiemo
