Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 15:12:47 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:21757 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225265AbSLEOMr>;
	Thu, 5 Dec 2002 15:12:47 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB5EC0Nf029516;
	Thu, 5 Dec 2002 06:12:01 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA17451;
	Thu, 5 Dec 2002 06:12:01 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB5EC1b09303;
	Thu, 5 Dec 2002 15:12:01 +0100 (MET)
Message-ID: <3DEF5EB0.A1A18E17@mips.com>
Date: Thu, 05 Dec 2002 15:12:00 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
References: <Pine.GSO.3.96.1021205143717.29101C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" wrote:

> On Thu, 5 Dec 2002, Carsten Langgaard wrote:
>
> > > Everybody satisfied?
> >
> > Not quite, I afraid.
> > I would like to be able to compile a 64-bit kernel, using the
> > MIPS32/MIPS64 config1 register, but I don't have a MIPS64 compliant n64
> > compiler (assembler). So I need the hardcoded ".word" opcode version, we
> > previously had.
>
>  Please upgrade/patch your tools.  If you can't, then this qualifies for a
> privately maintained patch perfectly.

I can live with that, already done.


>
>  Support for MIPS32/MIPS64 was added to binutils two years ago.  Version
> 2.11 suffices.
>

I just checked the FTP server for a new version
(ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/i386-linux/), and someone
actually provided a
new set of binutils. It's less than a month ago (Nov 12), it was put there.
But if that works you won't hear more about it from my side ;-)

Thanks.
/Carsten



>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
