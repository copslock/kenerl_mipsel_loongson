Received:  by oss.sgi.com id <S553771AbQLOHqK>;
	Thu, 14 Dec 2000 23:46:10 -0800
Received: from mx.mips.com ([206.31.31.226]:6359 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553767AbQLOHqH>;
	Thu, 14 Dec 2000 23:46:07 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA13746;
	Thu, 14 Dec 2000 23:46:03 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA04770;
	Thu, 14 Dec 2000 23:46:01 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id IAA17020;
	Fri, 15 Dec 2000 08:45:36 +0100 (MET)
Message-ID: <3A39CC1F.8FE7B2FE@mips.com>
Date:   Fri, 15 Dec 2000 08:45:35 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: 64 bit build fails
References: <3A379CBC.ED1D9F@mips.com> <20001214215933.C28871@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> On Wed, Dec 13, 2000 at 04:58:52PM +0100, Carsten Langgaard wrote:
>
> > I'm trying to build a 64bit kernel, but it fails with following message:
> >
> > mips64-linux-gcc -D__KERNEL__
> > -I/home/soc/proj/work/carstenl/sw/linux-2.4.0/include -Wall
> > -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> > -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r8000 -mips4
> > -Wa,-32   -c head.S -o head.o
> > head.S: Assembler messages:
> > head.S:69: Error: Missing ')' assumed
>
> Looks like an attempt to build a 64-bit Indy kernel.  Various people working
> on the Origin support have completly broken the support for anything else in
> their battle tank-style approach ...

Ok, that explains why a lot of things are broken.
So who will be responsible for fixing all the broken pieces ?

>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
