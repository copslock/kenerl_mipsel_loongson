Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 17:15:04 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:30226 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122958AbSIEPPD>;
	Thu, 5 Sep 2002 17:15:03 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17mzHV-00038O-00; Thu, 05 Sep 2002 11:14:58 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17myLJ-0006Wo-00; Thu, 05 Sep 2002 11:14:49 -0400
Date: Thu, 5 Sep 2002 11:14:49 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905151449.GB25023@nevyn.them.org>
References: <20020905142249.GA15843@nevyn.them.org> <Pine.GSO.3.96.1020905165445.7444D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905165445.7444D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 05:08:06PM +0200, Maciej W. Rozycki wrote:
> On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:
> 
> > Well, here's one - while we all know that C code which assumes a
> > pointer and int are the same size is buggy, it makes everything
> > substantially simpler if long and void* are the same size.  That's true
> > for both normal LP64 and ILP32 models.  Since n32 was mostly a
> > transitional tool (SGI was primarily interested in n64 as I understand
> > it), I imagine they wanted path of least damage...
> 
>  I see.  But do we need the SGI's traditional n32 in Linux then?  Having
> most experiences in the server world I'd vote for a pure 64-bit setup
> (with an optional ability to execute o32 stuff), but I understand there
> are people who consider it a waste of resources.
> 
>  Therefore, I believe we may choose another way and use an IP32 (if I
> encode it right) data model, where we have 32-bit ints and pointers for
> these who are short on memory, 64-bit longs for the maximum native
> precision (you don't choose long for the type for your favourite "i" loop
> counter unless you really need it) and an ability to have double-precision
> 128-bit long longs in the distant future (if needed). 
> 
>  Any opinions?

My opinion is that N32 is good enough for people who are short on
space.  We have too many MIPS ABIs already!

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
