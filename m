Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 14:42:20 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:18854 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225302AbSLFNmT>;
	Fri, 6 Dec 2002 14:42:19 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB6Df1Nf005612;
	Fri, 6 Dec 2002 05:41:01 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA21481;
	Fri, 6 Dec 2002 05:41:01 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB6Df1b14248;
	Fri, 6 Dec 2002 14:41:02 +0100 (MET)
Message-ID: <3DF0A8ED.D9B80781@mips.com>
Date: Fri, 06 Dec 2002 14:41:01 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
References: <Pine.GSO.3.96.1021205143717.29101C-100000@delta.ds2.pg.gda.pl> <3DEF5EB0.A1A18E17@mips.com> <3DF09DA9.B3D108@mips.com> <20021206132412.GB23743@rembrandt.csv.ica.uni-stuttgart.de> <20021206133448.GC23743@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

> Thiemo Seufer wrote:
> > Carsten Langgaard wrote:
> > [snip]
> > > I'm afraid I have to speak up again :-(
> > > Although the new binutils (binutils-mips64el-linux-2.13.1-1.i386.rpm) work on
> > > the latest sources from linux-mips.org, I have a problem with my local sources.
> > >
> > > I get the following error from the assembler:
> > >
> > >
> > > mips64el-linux-gcc -D__KERNEL__
> > > -I/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include -Wall
> > > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > > -fno-strict-aliasing -fno-common -I
> > > /home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include/asm/gcc
> > > -D__KERNEL__
> > > -I/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include -Wall
> > > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > > -fno-strict-aliasing -fno-common -mabi=64 -G 0 -mno-abicalls -fno-pic
>                                      ^^^^^^^^
> > > -Wa,--trap -pipe -mcpu=r8000 -mips4 -Wa,-32   -DKBUILD_BASENAME=sched
>                                         ^^^^^^^
> Then again, I missed you are building for a 64 bit kernel. The
> commandline given advises the compiler to create N64 code, but
> the assembler is forced to regard it as O32.
>
> I guess the reason for this is the hack to pack 64 bit code in
> O32 binaries.
>

Exactly.
Note, Ralf has already identified the problem, please see his answer.
After hacking the Makefile (gas option), everything work fine.


>
> Thiemo

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
