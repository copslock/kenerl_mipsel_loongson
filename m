Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 14:34:56 +0100 (CET)
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:11536 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225302AbSLFNez>; Fri, 6 Dec 2002 14:34:55 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18KIcy-0006Tl-00; Fri, 06 Dec 2002 14:34:48 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18KIcy-0000jc-00; Fri, 06 Dec 2002 14:34:48 +0100
Date: Fri, 6 Dec 2002 14:34:48 +0100
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021206133448.GC23743@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.3.96.1021205143717.29101C-100000@delta.ds2.pg.gda.pl> <3DEF5EB0.A1A18E17@mips.com> <3DF09DA9.B3D108@mips.com> <20021206132412.GB23743@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206132412.GB23743@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Carsten Langgaard wrote:
> [snip]
> > I'm afraid I have to speak up again :-(
> > Although the new binutils (binutils-mips64el-linux-2.13.1-1.i386.rpm) work on
> > the latest sources from linux-mips.org, I have a problem with my local sources.
> >
> > I get the following error from the assembler:
> > 
> > 
> > mips64el-linux-gcc -D__KERNEL__
> > -I/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -I
> > /home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include/asm/gcc
> > -D__KERNEL__
> > -I/home/soc/proj/work/carstenl/linux-2.4.18/sw/linux-2.4.18/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -mabi=64 -G 0 -mno-abicalls -fno-pic
                                     ^^^^^^^^
> > -Wa,--trap -pipe -mcpu=r8000 -mips4 -Wa,-32   -DKBUILD_BASENAME=sched
                                        ^^^^^^^
Then again, I missed you are building for a 64 bit kernel. The
commandline given advises the compiler to create N64 code, but
the assembler is forced to regard it as O32.

I guess the reason for this is the hack to pack 64 bit code in
O32 binaries.


Thiemo
