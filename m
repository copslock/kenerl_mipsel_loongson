Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2S7Cnv28089
	for linux-mips-outgoing; Tue, 27 Mar 2001 23:12:49 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2S7CmM28086
	for <linux-mips@oss.sgi.com>; Tue, 27 Mar 2001 23:12:48 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA06430;
	Tue, 27 Mar 2001 23:07:34 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA15408;
	Tue, 27 Mar 2001 23:07:31 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id JAA27891;
	Wed, 28 Mar 2001 09:06:49 +0200 (MEST)
Message-ID: <3AC18D89.A2A4386A@mips.com>
Date: Wed, 28 Mar 2001 09:06:49 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Keith M Wesolowski <wesolows@foobazco.org>, David Jez <dave.jez@seznam.cz>,
   Karel van Houten <K.H.C.vanHouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: rpm crashing on RH 7.0 indy
References: <Pine.GSO.3.96.1010327201744.17103A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

> On Sat, 17 Mar 2001, Keith M Wesolowski wrote:
>
> > That's not the problem.  The problem is that static binaries which use
> > libdl used to be (and perhaps still are) broken.  The reason it's
> > using libdl is that the nss libraries are never truly static, unless
> > you compile glibc with a special non-recommended option.  I have
> > indications that this may be fixed in glibc 2.2.2 using my current
> > toolchain, but my information is not complete.
>
>  Glibc is fine; it's the kernel that needs a fix (I've sent it here
> already once or twice).  We might possibly consider putting a workaround
> into glibc as well.

Have the kernel fix made it into the CVS.
If not, could you please resent it.

>
>
>  The problem is mmap() fails if a non-zero preferred address is given but
> the space is already occupied and no space *above* is available (space
> below is not taken into account).  A glibc workaround might be to call
> mmap() again with no preferred address specified this time.
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
