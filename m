Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 14:36:23 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:52222 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123920AbSJDMgQ>;
	Fri, 4 Oct 2002 14:36:16 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g94CZxNf016273;
	Fri, 4 Oct 2002 05:36:00 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA29822;
	Fri, 4 Oct 2002 05:36:29 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g94CZxb29382;
	Fri, 4 Oct 2002 14:35:59 +0200 (MEST)
Message-ID: <3D9D8B2E.8258A952@mips.com>
Date: Fri, 04 Oct 2002 14:35:58 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dominic Sweetman <dom@algor.co.uk>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
References: <3D9D484B.4C149BD8@mips.com>
		<200210041153.MAA12052@mudchute.algor.co.uk>  <3D9D855B.12128FA2@mips.com> <1033734968.31839.5.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:

> On Fri, 2002-10-04 at 13:11, Carsten Langgaard wrote:
> > Is a bus error exception an address related exception ?
> > I'm afraid some implementation think it's not.
> >
>
> So you need an option for broken systems, no new news 8)
>
> > What about an UART RX register, we might loose a character ?
> > You can also configure you system, so you get a external interrupt from you
> > system controller in case of a bus error, there is no way the CPU can
> > relate this interrupt to the prefetching.
>
> The use of memcpy for I/O space isnt permitted in Linux, thats why we
> have memcpy_*_io stuff. Thus prefetches should never touch 'special'
> spaces. (On x86 the older Athlons corrupt their cache if you do this so
> its not a mips specific matter)

That's exactly the problem.
The actually loads and stores in memcpy is fine, it's the prefetching that
prefetch too much.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
