Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 14:28:26 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:59045 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225302AbSLFN20>;
	Fri, 6 Dec 2002 14:28:26 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB6DOPNf005568;
	Fri, 6 Dec 2002 05:24:25 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA21053;
	Fri, 6 Dec 2002 05:24:24 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB6DOOb13128;
	Fri, 6 Dec 2002 14:24:25 +0100 (MET)
Message-ID: <3DF0A508.4BB7E16D@mips.com>
Date: Fri, 06 Dec 2002 14:24:24 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
References: <Pine.GSO.3.96.1021205143717.29101C-100000@delta.ds2.pg.gda.pl> <3DEF5EB0.A1A18E17@mips.com> <3DF09DA9.B3D108@mips.com> <20021206140732.A9345@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Fri, Dec 06, 2002 at 01:52:57PM +0100, Carsten Langgaard wrote:
>
> > I'm afraid I have to speak up again :-(
> > Although the new binutils (binutils-mips64el-linux-2.13.1-1.i386.rpm) work on
> > the latest sources from linux-mips.org, I have a problem with my local sources.
> >
> > I get the following error from the assembler:
> >
> >
> > {standard input}: Assembler messages:
> > {standard input}:329: Warning: dla used to load 32-bit register
> > {standard input}:382: Error: Number (0xffffffff) larger than 32 bits
> > {standard input}:408: Warning: dla used to load 32-bit register
>
> These are caused by an !%$@#$!$ incompatible change in gas.  In essence
> the code model we're using now requires to pass the additional option
> -mgp64.  arch/mips64/Makefile probes for gas accepting this new option.
>

Thanks a lot.


>
> So standard advice, update your sources.

In order to have a stable kernel at all time (for core validation), we need to stay
away from the bleeding edge.
So our local sources will always be a little bit behind the main stream.
I have started to send my last patches to you, in order to get ready for a merge
with your latest 2.4.20 sources.


>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
