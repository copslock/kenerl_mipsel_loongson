Received:  by oss.sgi.com id <S42302AbQJFVKK>;
	Fri, 6 Oct 2000 14:10:10 -0700
Received: from mx.mips.com ([206.31.31.226]:6077 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S42325AbQJFVJx>;
	Fri, 6 Oct 2000 14:09:53 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA19105;
	Fri, 6 Oct 2000 13:43:50 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA15542;
	Fri, 6 Oct 2000 13:44:05 -0700 (PDT)
Message-ID: <00e201c02fd6$9964c9c0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>, "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>,
        "Dominic Sweetman" <dom@algor.co.uk>
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com> <20001006182821.B9061@bacchus.dhis.org> <39DE7B4D.8514FC59@mvista.com>
Subject: Re: load_unaligned() and "uld" instruction
Date:   Fri, 6 Oct 2000 22:46:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Jun Sun wrote:
> Ralf Baechle wrote:
> >
> > On Thu, Oct 05, 2000 at 09:32:41PM -0700, Jun Sun wrote:
> >
> > > > > > > Ralf, before the perfect solution is found, the following
patch makes
> > > > > > > the gcc complain go away.  It just use ".set mips3" pragma.
> > > >
> > > > Which, as Ralf correctly observes, will generate code that will
> > > > crash on 32-bit CPUs,
> > >
> > > Why will it crash 32-bit CPUs?  On my R5432 CPU, the lwl/lwr sequence
> > > executes just fine.
> >
> > That's a 64-bit CPU with a 32-bit bus ...
> >
>
> That is what the manual claims.  However I did find something strange.
>
> I run the following code on R5432:
>
> 0x8019dc34 <my_get_unaligned+4>:        ldl     $a2,7($a0)
> 0x8019dc38 <my_get_unaligned+8>:        ldr     $a2,0($a0)
> 0x8019dc3c <my_get_unaligned+12>:       srl     $a2,$a2,0x10
>
> As Kevin has guessed, it actually runs fine.  However, the register
> content in $a2 is not right.  Basically it appears that $a2 is a 32-bit
> register instead of 64-bit register.  I put a srl instruction to make
> sure I was not fooled by gdb.

Please read the instruction manual for srl more closely.
In order to preserve binary compatibility with 32-bit MIPS
CPUs, srl, sll, and sra always work *as if* only a 32-bit register
is implemented.  If you want to shift the full 64 bits, you need
to use explicit 64-bit shifts: dsrl, dsll, dsra, etc.  Use a dsrl
instead of an srl and you *may* see what you are expecting.

But there is also the issue that  Ralf alluded to in earlier
messages on this thread:  If your kernel exception
handler is only saving and restoring register state
using 32-bit loads and stores, the upper 32-bits of
the registers will tend to decay into sign-extensions
of the least significant 32-bits.

            Regards,

            Kevin K.
