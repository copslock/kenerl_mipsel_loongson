Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 11:00:35 +0100 (BST)
Received: from p508B5C08.dip.t-dialin.net ([IPv6:::ffff:80.139.92.8]:46678
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225717AbUE1J55>; Fri, 28 May 2004 10:57:57 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4S9vsuP013020;
	Fri, 28 May 2004 11:57:55 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4S9vsTY013019;
	Fri, 28 May 2004 11:57:54 +0200
Date: Fri, 28 May 2004 11:57:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Emmanuel Michon <em@realmagic.fr>, linux-mips@linux-mips.org
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies 64bit arithmetics?
Message-ID: <20040528095754.GA12295@linux-mips.org>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com> <20040526203346.GA8430@linux-mips.org> <1085668313.20233.1249.camel@avalon.france.sdesigns.com> <20040527155947.GA4154@linux-mips.org> <20040528003525.GA27796@linux-mips.org> <20040528093634.GP17309@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528093634.GP17309@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5213
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 28, 2004 at 11:36:34AM +0200, Thiemo Seufer wrote:

> Ralf Baechle wrote:
> [snip]
> > +static __inline__ int atomic64_sub_if_positive(int i, atomic64_t * v)
> > +{
> > +	unsigned long temp, result;
> > +
> > +	__asm__ __volatile__(
> > +	"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
> > +	"	subu	%0, %1, %3				\n"
> 
> Shouldn't this be "dsubu"?

Yep, thanks for noticing.  Fortunately this function is unused; it only
exists for symmetry to it's 32-bit equivalent.  I also a few variables
that should be long in the atomic64 code were just int; I fixed that
also.

  Ralf
