Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 15:45:16 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:32455 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123897AbSJBNpP>;
	Wed, 2 Oct 2002 15:45:15 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g92DiVrZ006824;
	Wed, 2 Oct 2002 06:44:31 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA22768;
	Wed, 2 Oct 2002 06:45:01 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g92DiWb04021;
	Wed, 2 Oct 2002 15:44:32 +0200 (MEST)
Message-ID: <3D9AF840.CDF33026@mips.com>
Date: Wed, 02 Oct 2002 15:44:32 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
References: <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" wrote:

> On Wed, 2 Oct 2002, Carsten Langgaard wrote:
>
> > I have a number of patches for the o32 syscall wrapper/conversion
> > routines, which is needed when running a 64-bit kernel on an o32
> > userland.
> > Here is the first one. Ralf, could you please apply it, so I can send
> > the next one.
>
>  Do you have a fix for sys32_sendmsg/sys32_recvmsg as well?  I just
> started working on it and I'd prefer not to do a duplicate work.

Yes, that's exactly the next one, I will be sending.
So stay tuned.


>
>  As a side note -- arch/mips64/kernel/linux32.c is a huge collection of
> often unrelated functions.  It might be beneficial to split the file
> functionally, e.g. into fs32.c, net32.c, etc. or even with a finer grain,
> preferably in a subdirectory, e.g. arch/mips64/linux32/.  What do you
> think?

That's probably a good idea, but I would like to get my patches out first,
before splitting things up.


>
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
