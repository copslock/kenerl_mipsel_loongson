Received:  by oss.sgi.com id <S42356AbQJFV6L>;
	Fri, 6 Oct 2000 14:58:11 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:38902 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42351AbQJFV6I>;
	Fri, 6 Oct 2000 14:58:08 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e96INcx11110;
	Fri, 6 Oct 2000 11:23:38 -0700
Message-ID: <39DE7B4D.8514FC59@mvista.com>
Date:   Fri, 06 Oct 2000 18:24:29 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com, Dominic Sweetman <dom@algor.co.uk>
Subject: Re: load_unaligned() and "uld" instruction
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com> <20001006182821.B9061@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Thu, Oct 05, 2000 at 09:32:41PM -0700, Jun Sun wrote:
> 
> > > > > > Ralf, before the perfect solution is found, the following patch makes
> > > > > > the gcc complain go away.  It just use ".set mips3" pragma.
> > >
> > > Which, as Ralf correctly observes, will generate code that will
> > > crash on 32-bit CPUs,
> >
> > Why will it crash 32-bit CPUs?  On my R5432 CPU, the lwl/lwr sequence
> > executes just fine.
> 
> That's a 64-bit CPU with a 32-bit bus ...
> 

That is what the manual claims.  However I did find something strange.

I run the following code on R5432:

0x8019dc34 <my_get_unaligned+4>:        ldl     $a2,7($a0)
0x8019dc38 <my_get_unaligned+8>:        ldr     $a2,0($a0)
0x8019dc3c <my_get_unaligned+12>:       srl     $a2,$a2,0x10

As Kevin has guessed, it actually runs fine.  However, the register
content in $a2 is not right.  Basically it appears that $a2 is a 32-bit
register instead of 64-bit register.  I put a srl instruction to make
sure I was not fooled by gdb.

I know R5432 is derived from R5000 FOR 32-bit systems.  I guess there
are probably a lot of short-cuts for 64-bit operations.

Jun
