Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HL9U631676
	for linux-mips-outgoing; Thu, 17 Jan 2002 13:09:30 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HL9NP31673;
	Thu, 17 Jan 2002 13:09:23 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA01192;
	Thu, 17 Jan 2002 12:08:13 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA02320;
	Thu, 17 Jan 2002 12:08:13 -0800 (PST)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g0HK7tA10490;
	Thu, 17 Jan 2002 21:07:55 +0100 (MET)
Message-ID: <3C472F60.E5B62F0C@mips.com>
Date: Thu, 17 Jan 2002 21:09:04 +0100
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: IDE driver broken in bigendian 2.4.17 kernel
References: <Pine.GSO.3.96.1020117155914.16712A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

> On Thu, 17 Jan 2002, Carsten Langgaard wrote:
>
> > One could argue that the IDE driver should use it's own special functions
> > (like ide_insl, etc ...) and not use the generic functions (insl, etc ...).
>
>  If it's due to a problem with an IDE host adapter then it should be fixed
> within the IDE driver (or not at all and kept privately as needed).  In no
> case the order of header inclusions may determine function or macro
> definitions.

The order of header inclusions doesn't matter, because the ide.h file include the
io.h file, and that way io.h always get include first.
The '#ifndef' in all header file makes sure it only get included once.

>
> > But all other architectures does it this way, so I'm just trying to follow
> > the trend.
>
>  It does not mean other architectures are right here.  Possibly they have
> not hit the problem so far.
>
>  If the problem is generic to a chipset, then you indeed need to redefine
> I/O macros, but then in <asm/io.h>.  If that's PCI-specific, for example,
> then you should probably make the redefinition conditional on CONFIG_PCI.

I'm not in a position, where I can fix and not at least test the changes, that it
needed in both the IDE driver as well as in all the other bigendian architectures
ide.h files.
I think my fix is the only one that doesn't break things for anyone else, you may
argue that it isn't the right one and I kind of agree, but at this point I think
it's the best solution.

>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
