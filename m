Received:  by oss.sgi.com id <S554052AbRBBPUf>;
	Fri, 2 Feb 2001 07:20:35 -0800
Received: from mx.mips.com ([206.31.31.226]:59116 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S554045AbRBBPUV>;
	Fri, 2 Feb 2001 07:20:21 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA12614;
	Fri, 2 Feb 2001 07:18:22 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA09622;
	Fri, 2 Feb 2001 07:18:21 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id QAA09136;
	Fri, 2 Feb 2001 16:18:10 +0100 (MET)
Message-ID: <3A7ACFB2.DAFC52E3@mips.com>
Date:   Fri, 02 Feb 2001 16:18:10 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     linux-mips@oss.sgi.com
Subject: Re: Cross build applications
References: <Pine.GSO.3.96.1010202160104.28509I-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:

> On Fri, 2 Feb 2001, Carsten Langgaard wrote:
>
> > I'm trying to cross build a small test program on a linux PC, but it
> > fails.
> >
> > mips-linux-gcc -o test test.c
> > /usr/mips-linux/bin/ld: cannot open crt1.o: No such file or directory
>
>  The file is supposed to come with glibc.  Do you have glibc for
> mips-linux installed?
>

No, where can I get it.

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
