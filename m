Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 16:35:34 +0000 (GMT)
Received: from p508B76C0.dip.t-dialin.net ([IPv6:::ffff:80.139.118.192]:6775
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225343AbUBJQfW>; Tue, 10 Feb 2004 16:35:22 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1AGYWex030653;
	Tue, 10 Feb 2004 17:34:32 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1AGY7jm030643;
	Tue, 10 Feb 2004 17:34:07 +0100
Date: Tue, 10 Feb 2004 17:34:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] dump_tlb.c clean-ups
Message-ID: <20040210163407.GA30617@linux-mips.org>
References: <Pine.LNX.4.55.0402101653290.6769@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0402101653290.6769@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 10, 2004 at 05:15:39PM +0100, Maciej W. Rozycki wrote:

> Ralf,
> 
>  Gcc 3.4 complains about a possibly undefined operation in dump16() in 
> arch/mips/lib/r3k_dump_tlb.c.  The following patch fixes it.  I've taken 
> the opportunity to clean up the file and its counterparts thus:
> 
> 1. I've cast the pointers to "unsigned long" consistently for output
> formatting as the width specifier doesn't work very well with pointers.
> 
> 2. I've renamed msg2str() to msk2str() in one of the variations.
> 
> 3. I've reordered header inclusions in one of the variations.
> 
> 4. I've fixed indentation throughout, perhaps not completely, but still 
> the result should be somewhat closer to sanity.
> 
> These changes make the three variations closer to one another where 
> possible.
> 
>  OK to apply?

Sure, go ahead.

I guess the output format could also use some improvments for readability ...

  Ralf
