Received:  by oss.sgi.com id <S42370AbQJFWWm>;
	Fri, 6 Oct 2000 15:22:42 -0700
Received: from u-150.karlsruhe.ipdial.viaginterkom.de ([62.180.18.150]:10502
        "EHLO u-150.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42368AbQJFWWg>; Fri, 6 Oct 2000 15:22:36 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869494AbQJFQ2V>;
        Fri, 6 Oct 2000 18:28:21 +0200
Date:   Fri, 6 Oct 2000 18:28:21 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com, Dominic Sweetman <dom@algor.co.uk>
Subject: Re: load_unaligned() and "uld" instruction
Message-ID: <20001006182821.B9061@bacchus.dhis.org>
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39DD55E9.AFCACB0E@mvista.com>; from jsun@mvista.com on Thu, Oct 05, 2000 at 09:32:41PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 05, 2000 at 09:32:41PM -0700, Jun Sun wrote:

> > > > > Ralf, before the perfect solution is found, the following patch makes
> > > > > the gcc complain go away.  It just use ".set mips3" pragma.
> > 
> > Which, as Ralf correctly observes, will generate code that will
> > crash on 32-bit CPUs, 
> 
> Why will it crash 32-bit CPUs?  On my R5432 CPU, the lwl/lwr sequence
> executes just fine.

That's a 64-bit CPU with a 32-bit bus ...

> Or do you mean it will crash SOME 32-bit CPUs?  Do those 32-bit CPUs
> support lwl or lwr?  If they don't, they should generate a reserved
> instruction exception.  If they do, I don't see any problem. 

It will crash all 32-bit CPUs.

> Not entirely.  I was thinking if the unaligned load/store instruction
> corrupts the upper 32 bit content on SOME cpus, maybe we do need to cut
> the upper 32bit as a workaround.  Well, I hope it is not necessary.

No, it happens on all CPUs.  Interrupts only restore the lower 32-bit of
the registers.  Partially this happens for the sake of compatibility with
32-bit cpus, partially it's also the because otherwise 8kb kernel stack
wouldn't be sufficient, we'd have to go up to 16kb stacks which again
has potencial influence on the memory managment that can reduce the
reliability of the kernel when low on memory, it increases the overhead.
In short unless a system has serious needs for 64-bit supporting 64-bit
is quite a loss.

  Ralf
