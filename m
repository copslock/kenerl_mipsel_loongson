Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 13:57:04 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:165 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225302AbSLFM5D>;
	Fri, 6 Dec 2002 13:57:03 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB6CqwNf005486;
	Fri, 6 Dec 2002 04:52:58 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA20168;
	Fri, 6 Dec 2002 04:52:57 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB6Cqvb10965;
	Fri, 6 Dec 2002 13:52:57 +0100 (MET)
Message-ID: <3DF09DA9.B3D108@mips.com>
Date: Fri, 06 Dec 2002 13:52:57 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
References: <Pine.GSO.3.96.1021205143717.29101C-100000@delta.ds2.pg.gda.pl> <3DEF5EB0.A1A18E17@mips.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Carsten Langgaard wrote:

> "Maciej W. Rozycki" wrote:
>
> > On Thu, 5 Dec 2002, Carsten Langgaard wrote:
> >
> > > > Everybody satisfied?
> > >
> > > Not quite, I afraid.
> > > I would like to be able to compile a 64-bit kernel, using the
> > > MIPS32/MIPS64 config1 register, but I don't have a MIPS64 compliant n64
> > > compiler (assembler). So I need the hardcoded ".word" opcode version, we
> > > previously had.
> >
> >  Please upgrade/patch your tools.  If you can't, then this qualifies for a
> > privately maintained patch perfectly.
>
> I can live with that, already done.
>
> >
> >  Support for MIPS32/MIPS64 was added to binutils two years ago.  Version
> > 2.11 suffices.
> >
>
> I just checked the FTP server for a new version
> (ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/i386-linux/), and someone
> actually provided a
> new set of binutils. It's less than a month ago (Nov 12), it was put there.
> But if that works you won't hear more about it from my side ;-)
>

I'm afraid I have to speak up again :-(
Although the new binutils (binutils-mips64el-linux-2.13.1-1.i386.rpm) work on
the latest sources from linux-mips.org, I have a problem with my local sources.

I get the following error from the assembler:


mips64el-linux-gcc -D__KERNEL__
-I/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -I
/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include/asm/gcc
-D__KERNEL__
-I/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -mabi=64 -G 0 -mno-abicalls -fno-pic
-Wa,--trap -pipe -mcpu=r8000 -mips4 -Wa,-32   -DKBUILD_BASENAME=sched
-fno-omit-frame-pointer -c -o sched.o sched.c
{standard input}: Assembler messages:
{standard input}:329: Warning: dla used to load 32-bit register
{standard input}:382: Error: Number (0xffffffff) larger than 32 bits
{standard input}:408: Warning: dla used to load 32-bit register
{standard input}:431: Warning: dla used to load 32-bit register
{standard input}:541: Warning: dla used to load 32-bit register
{standard input}:542: Warning: dla used to load 32-bit register
{standard input}:554: Warning: dla used to load 32-bit register
{standard input}:557: Warning: dla used to load 32-bit register
{standard input}:558: Warning: dla used to load 32-bit register
{standard input}:567: Warning: dla used to load 32-bit register
{standard input}:569: Warning: dla used to load 32-bit register
{standard input}:570: Warning: dla used to load 32-bit register
{standard input}:581: Warning: dla used to load 32-bit register
{standard input}:824: Warning: dla used to load 32-bit register
{standard input}:847: Warning: dla used to load 32-bit register
{standard input}:848: Warning: dla used to load 32-bit register
{standard input}:884: Warning: dla used to load 32-bit register
{standard input}:885: Warning: dla used to load 32-bit register
{standard input}:898: Warning: dla used to load 32-bit register
{standard input}:1107: Warning: dla used to load 32-bit register
{standard input}:1251: Warning: dla used to load 32-bit register
{standard input}:1407: Warning: dla used to load 32-bit register
{standard input}:2017: Error: Number (0xffffffff) larger than 32 bits
{standard input}:2029: Error: Number (0x0) larger than 32 bits
{standard input}:2031: Error: Number (0xffffffff) larger than 32 bits
{standard input}:2082: Warning: dla used to load 32-bit register
{standard input}:2262: Warning: dla used to load 32-bit register
{standard input}:2393: Warning: dla used to load 32-bit register
{standard input}:2478: Warning: dla used to load 32-bit register
{standard input}:2517: Error: Number (0xffffffff) larger than 32 bits
{standard input}:2529: Error: Number (0x0) larger than 32 bits
{standard input}:2531: Error: Number (0xffffffff) larger than 32 bits
{standard input}:2635: Warning: dla used to load 32-bit register
{standard input}:2797: Warning: dla used to load 32-bit register
{standard input}:2885: Error: Number (0xffffffff) larger than 32 bits
{standard input}:2897: Error: Number (0x0) larger than 32 bits
{standard input}:2899: Error: Number (0xffffffff) larger than 32 bits
{standard input}:3030: Warning: dla used to load 32-bit register
{standard input}:3102: Warning: dla used to load 32-bit register
{standard input}:3113: Warning: dla used to load 32-bit register
{standard input}:3123: Warning: dla used to load 32-bit register
{standard input}:3134: Warning: dla used to load 32-bit register
{standard input}:3140: Warning: dla used to load 32-bit register
{standard input}:3164: Warning: dla used to load 32-bit register
{standard input}:3178: Warning: dla used to load 32-bit register
{standard input}:3194: Warning: dla used to load 32-bit register
{standard input}:3199: Warning: dla used to load 32-bit register
{standard input}:3215: Warning: dla used to load 32-bit register
{standard input}:3220: Warning: dla used to load 32-bit register
{standard input}:3236: Warning: dla used to load 32-bit register
{standard input}:3241: Warning: dla used to load 32-bit register
{standard input}:3244: Warning: dla used to load 32-bit register
{standard input}:3398: Warning: dla used to load 32-bit register
{standard input}:3408: Warning: dla used to load 32-bit register
{standard input}:3410: Warning: dla used to load 32-bit register
{standard input}:3412: Warning: dla used to load 32-bit register
{standard input}:3502: Warning: dla used to load 32-bit register
{standard input}:3532: Error: Number (0xffffffff) larger than 32 bits
{standard input}:3534: Warning: dla used to load 32-bit register
{standard input}:3596: Warning: dla used to load 32-bit register
{standard input}:3657: Warning: dla used to load 32-bit register
{standard input}:3658: Warning: dla used to load 32-bit register
{standard input}:3677: Warning: dla used to load 32-bit register
{standard input}:3708: Warning: dla used to load 32-bit register
{standard input}:3755: Warning: dla used to load 32-bit register
{standard input}:3757: Warning: dla used to load 32-bit register
{standard input}:3773: Warning: dla used to load 32-bit register
{standard input}:3781: Warning: dla used to load 32-bit register
{standard input}:3789: Warning: dla used to load 32-bit register
{standard input}:3849: Warning: dla used to load 32-bit register
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory
`/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/kernel'
make: *** [_dir_kernel] Error 2


The old binutils (binutils-mips64el-linux-2.9.5-3.i386.rpm) worked fine.



>
> Thanks.
> /Carsten
>
> >
> > --
> > +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> > +--------------------------------------------------------------+
> > +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
>
> --
> _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark            http://www.mips.com

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
