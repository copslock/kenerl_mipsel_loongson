Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 14:11:29 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:22526 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123253AbSJDML3>;
	Fri, 4 Oct 2002 14:11:29 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g94CB7Nf016191;
	Fri, 4 Oct 2002 05:11:07 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA29129;
	Fri, 4 Oct 2002 05:11:37 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g94CB7b26187;
	Fri, 4 Oct 2002 14:11:07 +0200 (MEST)
Message-ID: <3D9D855B.12128FA2@mips.com>
Date: Fri, 04 Oct 2002 14:11:07 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominic Sweetman <dom@algor.co.uk>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
References: <3D9D484B.4C149BD8@mips.com> <200210041153.MAA12052@mudchute.algor.co.uk>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Dominic Sweetman wrote:

> Carsten Langgaard (carstenl@mips.com) writes:
>
> > I think we have a problem with the PREF instructions spread out in the
> > memcpy function.
>
> Not really.  The MIPS32 manual (for example):
>
>  "PREF does not cause addressing-related exceptions. If it does happen
>   to raise an exception condition, the exception condition is
>   ignored. If an addressing-related exception condition is raised and
>   ignored, no data movement occurs."

Is a bus error exception an address related exception ?
I'm afraid some implementation think it's not.


>
>   PREF never generates a memory operation for a location with an
>   uncached memory access type."
>
> For a Linux user program, at least, memory pages are "memory-like":
> reads are guaranteed to be side-effect free, so any outlying
> prefetches are harmless.  It's hard to see any circumstance where an
> accessible cacheable location would lead to bad side-effects on read.

What about an UART RX register, we might loose a character ?
You can also configure you system, so you get a external interrupt from you
system controller in case of a bus error, there is no way the CPU can
relate this interrupt to the prefetching.




>
>
> --
> Dominic Sweetman,
> MIPS Technologies (UK) - formerly Algorithmics
> The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
> phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
> http://www.algor.co.uk

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
