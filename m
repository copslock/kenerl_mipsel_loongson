Received:  by oss.sgi.com id <S553834AbQLRIMf>;
	Mon, 18 Dec 2000 00:12:35 -0800
Received: from mx.mips.com ([206.31.31.226]:33262 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553820AbQLRIML>;
	Mon, 18 Dec 2000 00:12:11 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA06374;
	Mon, 18 Dec 2000 00:12:04 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA28304;
	Mon, 18 Dec 2000 00:12:02 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id JAA01484;
	Mon, 18 Dec 2000 09:11:39 +0100 (MET)
Message-ID: <3A3DC6BA.DAC68261@mips.com>
Date:   Mon, 18 Dec 2000 09:11:38 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: 64 bit build fails
References: <3A379CBC.ED1D9F@mips.com> <20001214215933.C28871@bacchus.dhis.org> <3A39CC1F.8FE7B2FE@mips.com> <20001215162023.B28594@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> On Fri, Dec 15, 2000 at 08:45:35AM +0100, Carsten Langgaard wrote:
>
> > > > mips64-linux-gcc -D__KERNEL__
> > > > -I/home/soc/proj/work/carstenl/sw/linux-2.4.0/include -Wall
> > > > -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> > > > -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r8000 -mips4
> > > > -Wa,-32   -c head.S -o head.o
> > > > head.S: Assembler messages:
> > > > head.S:69: Error: Missing ')' assumed
> > >
> > > Looks like an attempt to build a 64-bit Indy kernel.  Various people working
> > > on the Origin support have completly broken the support for anything else in
> > > their battle tank-style approach ...
> >
> > Ok, that explains why a lot of things are broken.
> > So who will be responsible for fixing all the broken pieces ?
>
> This is the question you'd ask a company.  This is Free Software, not some
> company's product ...

What I mean is that we need some discipline, as you mention yourself, it is
unfortunate with this battle tank-style approach.
And I think you do a pretty good job trying to make the rest of the code as clean
as possible.
Of course some time it is a little bit annoying you doesn't just accept my patches
:-)
Just kidding, I think that's the right way to do things.

I was just hoping that the 64bit code was in the same condition as the rest of the
code.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
