Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34EP2A18978
	for linux-mips-outgoing; Wed, 4 Apr 2001 07:25:02 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34EOxM18974;
	Wed, 4 Apr 2001 07:24:59 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA16490;
	Wed, 4 Apr 2001 07:24:12 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA21003;
	Wed, 4 Apr 2001 07:24:08 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id QAA19097;
	Wed, 4 Apr 2001 16:23:27 +0200 (MEST)
Message-ID: <3ACB2E5E.D8AFB3BF@mips.com>
Date: Wed, 04 Apr 2001 16:23:26 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
References: <Pine.GSO.3.96.1010404153012.6521E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I would like to join the fun of cross-compiling RPMs.
What I have done so far with userland is simply to collect precompiled
binaries, and only compiled less than a handful of RPMs natively.
So where do I start ?
I have started out getting the tarball
(ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev/cross-all-20010303.tar)
and compiled everything on a linux hosted PC, it worked fine, though I had
to upgrade from redhat6.1 to redhat7.0. Nice work whoever put this together.

Now I would like to start cross compile SRPMs (let say redhat7.0).
What do I need to do to make the SRPMS cross compile ?
Could someone please get me booted or is there an howto somewhere ?
I realize it probably gonna be hard work, but I like to join the fun, at
least so I have an idea what exactly the problems are, and hopefully with
time I can contribute in the bug fixing.

/Carsten


"Maciej W. Rozycki" wrote:

> On Wed, 4 Apr 2001, Ralf Baechle wrote:
>
> > stdint.h isn't available everywhere.  Aside of that I won't object ...
>
>  That's why I wrote of legacy hosts.  The AC_CHECK_HEADERS and
> AC_CHECK_TYPE macros are cross-compilation-safe and they are all that
> modern hosts need.  For other hosts AC_CHECK_SIZEOF might be used to find
> generic types suitable for ISO C definitions, which might be problematic
> for cross-compilation, though.  Still this applies to non-gcc
> cross-compilers only, which are not that common, AFAIK.
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
