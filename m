Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 08:40:30 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:43512 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123253AbSJDGk3>;
	Fri, 4 Oct 2002 08:40:29 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g946diNf014923;
	Thu, 3 Oct 2002 23:39:44 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA20483;
	Thu, 3 Oct 2002 23:40:12 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g946dhb24938;
	Fri, 4 Oct 2002 08:39:43 +0200 (MEST)
Message-ID: <3D9D37AC.B239FA5D@mips.com>
Date: Fri, 04 Oct 2002 08:39:40 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
References: <Pine.GSO.3.96.1021003133548.7000A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Hmm, are you sure it's related ?
It works fine for me, and it fixes the problems I had before I added this
fix.

/Carsten


"Maciej W. Rozycki" wrote:

> On Wed, 2 Oct 2002, Ralf Baechle wrote:
>
> > > Ok, here is the next patch.
> > > It fixes the sys32_sendmsg and sys32_recvmsg.
> >
> > Ok, in.  Maciej, you can start the chainsawing ;-)
>
>  Hmm, I couldn't test it as init now crashes with a SIGSEGV soon after
> starting.  I had no time to investigate it further.  I fear it might be
> related, though -- /dev/initctl communication?
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
