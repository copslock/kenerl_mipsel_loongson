Received:  by oss.sgi.com id <S42368AbQJEVeC>;
	Thu, 5 Oct 2000 14:34:02 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:6142 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42353AbQJEVda>;
	Thu, 5 Oct 2000 14:33:30 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e95LVqx11009;
	Thu, 5 Oct 2000 14:31:52 -0700
Message-ID: <39DD55E9.AFCACB0E@mvista.com>
Date:   Thu, 05 Oct 2000 21:32:41 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com, Dominic Sweetman <dom@algor.co.uk>
Subject: Re: load_unaligned() and "uld" instruction
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> 
> > > > Ralf, before the perfect solution is found, the following patch makes
> > > > the gcc complain go away.  It just use ".set mips3" pragma.
> 
> Which, as Ralf correctly observes, will generate code that will
> crash on 32-bit CPUs, 

Why will it crash 32-bit CPUs?  On my R5432 CPU, the lwl/lwr sequence
executes just fine.

Or do you mean it will crash SOME 32-bit CPUs?  Do those 32-bit CPUs
support lwl or lwr?  If they don't, they should generate a reserved
instruction exception.  If they do, I don't see any problem. 

> > With the second half, are you saying the "cut-off-upper-32-bit" bug
> > actually hides the register corruption problem?  If so, maybe we need
> > the "cut-off-upper_32-bit" bug for the 32-bit MIPS tree.
> 
> This is a joke, right?
> 

Not entirely.  I was thinking if the unaligned load/store instruction
corrupts the upper 32 bit content on SOME cpus, maybe we do need to cut
the upper 32bit as a workaround.  Well, I hope it is not necessary.

Jun
