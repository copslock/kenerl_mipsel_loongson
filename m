Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HEXNg13372
	for linux-mips-outgoing; Thu, 17 Jan 2002 06:33:23 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HEXGP13368;
	Thu, 17 Jan 2002 06:33:16 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA25292;
	Thu, 17 Jan 2002 05:31:52 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA06415;
	Thu, 17 Jan 2002 05:31:51 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g0HDVXA16794;
	Thu, 17 Jan 2002 14:31:33 +0100 (MET)
Message-ID: <3C46D248.931FB659@mips.com>
Date: Thu, 17 Jan 2002 14:31:52 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: IDE driver broken in bigendian 2.4.17 kernel
References: <Pine.GSO.3.96.1020117135554.10407B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

> On Thu, 17 Jan 2002, Carsten Langgaard wrote:
>
> > Due to changes in the string port macros/functions (insl, outsl, insw,
> > ...) the bigendian IDE driver doesn't work anymore.
> > I think we need to have local versions of these functions in
> > include/asm-mips/ide.h, therefore these functions should be macros
> > (#define) and not static functions in include/asm-mips/io.h (in order to
> > redefine them).
>
>  I believe the inline functions should be left as they are and the IDE
> driver should use own ones that call the formers and perform byteswapping
> on results as needed.  You should avoid the name clash.
>
>  Also if that's a chipset-specific issue and not an IDE host adapter's
> one, this should be resolved globally as other devices/drivers may be
> affected.

One could argue that the IDE driver should use it's own special functions
(like ide_insl, etc ...) and not use the generic functions (insl, etc ...).
But all other architectures does it this way, so I'm just trying to follow
the trend.

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
