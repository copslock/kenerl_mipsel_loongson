Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 16:23:28 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:14098 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122958AbSIEOX2>;
	Thu, 5 Sep 2002 16:23:28 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17myTB-00034f-00; Thu, 05 Sep 2002 10:22:58 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17mxWz-0004AA-00; Thu, 05 Sep 2002 10:22:49 -0400
Date: Thu, 5 Sep 2002 10:22:49 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905142249.GA15843@nevyn.them.org>
References: <010301c254da$892fcc50$10eca8c0@grendel> <Pine.GSO.3.96.1020905155411.7444A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905155411.7444A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 04:09:11PM +0200, Maciej W. Rozycki wrote:
> On Thu, 5 Sep 2002, Kevin D. Kissell wrote:
> 
> > n32 has the same data types as o32, an "ILP32" C integer 
> > model.  n64 is a pretty normal "LP64" C integer model.
> > 
> > What do you consider to be broken, and how would you
> > have preferred it to have been done?
> 
>  For n32 it would be natural to have:
> 
> - sizeof(int) = 32
> 
> - sizeof(long) = 64
> 
> - sizeof(void *) = 32
> 
> as the underlying hardware directly supports 64-bit operations (n32
> requires at least MIPS III).  Thus there is no penalty for 64-bit
> arithmetics and if one uses longs one normally wants the largest native
> integer type -- using long long typically (i.e. on most platforms) implies
> double-precision arithmetics with all the drawbacks, especially for the
> division and multiplication operations. 
> 
>  With 32-bit long on 64-bit hardware software has no easy way to figure
> using 64-bit operations is still optimal performance-wise.  I can't see
> any technical benefit from such a setup -- is there any?  I doubt it. 

Well, here's one - while we all know that C code which assumes a
pointer and int are the same size is buggy, it makes everything
substantially simpler if long and void* are the same size.  That's true
for both normal LP64 and ILP32 models.  Since n32 was mostly a
transitional tool (SGI was primarily interested in n64 as I understand
it), I imagine they wanted path of least damage...

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
