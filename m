Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 17:02:13 +0000 (GMT)
Received: from p508B5F0A.dip.t-dialin.net ([IPv6:::ffff:80.139.95.10]:59789
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225405AbUANRCN>; Wed, 14 Jan 2004 17:02:13 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0EH03Ds026382;
	Wed, 14 Jan 2004 18:00:03 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0EH0195026381;
	Wed, 14 Jan 2004 18:00:01 +0100
Date: Wed, 14 Jan 2004 18:00:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-mips@linux-mips.org
Subject: Re: [2.6 patch] fix DECSTATION depends
Message-ID: <20040114170001.GA20227@linux-mips.org>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org> <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl> <20040113172751.GN9677@fs.tum.de> <Pine.LNX.4.55.0401141230400.1436@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401141230400.1436@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 14, 2004 at 01:01:25PM +0100, Maciej W. Rozycki wrote:

>  The problem is the official kernel would work fine for a 64-bit
> DECstation if it had an R4400 rev.2.0 or later.  I haven't heard of any
> having such a processor -- the ones I have and the others reported by
> poeple have either an R4000 rev.3.0 or an R4400 rev.1.0.  These processors
> have errata that lead to erroneous behavior in a few common 64-bit
> operations (according to the errata sheet, the R4000 actually has a
> serious 32-bit erratum as well, but I haven't been able to trigger it
> yet).  I have implemented appropriate workarounds (available upon
> request), but they require changes not only to Linux, but to gcc and gas
> as well.  I'm preparing to merge the changes to the tools -- hence my
> current gcc 3.4 effort -- but until then the 64-bit port has to be marked
> as experimental (marking R4000 and R4400 processor selections as such for
> 64-bit operation would be more accurate, but currently we don't have a
> separate setting for them).
> 
>  See also arch/mips/dec/prom/call_o32.S for the only chunk of explicit
> support code for 64-bit operation for the DECstation -- everything else
> just works as is (modulo possible protability bugs in drivers).
> 
>  Going back to the subject -- what's the problem with dependencies?

Nothing.  It was looking like you meant something else and me and Adrian
got trapped by that.  Feel free to change it back to what it was but
maybe "depends on MIPS32 || (MIPS64 && EXPERIMENTAL)" is less ambigous?

  Ralf
