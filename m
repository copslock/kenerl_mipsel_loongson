Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35B46Z21802
	for linux-mips-outgoing; Thu, 5 Apr 2001 04:04:06 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35B42M21798;
	Thu, 5 Apr 2001 04:04:02 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA27641;
	Thu, 5 Apr 2001 03:57:21 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA25289;
	Thu, 5 Apr 2001 03:56:23 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id MAA08356;
	Thu, 5 Apr 2001 12:54:45 +0200 (MEST)
Message-ID: <3ACC4EF4.D0F7D810@mips.com>
Date: Thu, 05 Apr 2001 12:54:44 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
References: <Pine.GSO.3.96.1010404171225.6521F-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks a lot.
I have question about installation of the SRPMs, though.
How can I relocate the packages, so they don't need to reside under
/usr/src/redhat/ ?

/Carsten

"Maciej W. Rozycki" wrote:

> On Wed, 4 Apr 2001, Carsten Langgaard wrote:
>
> > Now I would like to start cross compile SRPMs (let say redhat7.0).
> > What do I need to do to make the SRPMS cross compile ?
>
>  Spec files need to be written appropriately for cross-compilation to be
> supported as you need to override the compiler used (and possibly other
> tools) and configure scripts need to be passed a host system name.  Also
> depending on the cluefulness of a given maintainer/team, packages might be
> easy or difficult to cross-compile -- heavy patching is required in some
> cases.
>
>  For the way I am using RPM to cross-compile you might visit my FTP site
> at 'ftp://ftp.ds2.pg.gda.pl/pub/macro/' (mirrored at
> 'ftp://ftp.rfc822.org/pub/mirror/ftp.ds2.pg.gda.pl/pub/macro' -- thanks,
> Flo).  There are source and binary packages as well as configuration files
> I use.  Read the READMEs and look at a few spec files and everything
> should be clear.  Many of the *.mipsel.rpm packages available there were
> cross-built -- you may verify it with `rpm -qip': "macro" is my i386-linux
> system, while "3maxp" is my mipsel-linux one (still no i386-linux
> cross-compiler on my mipsel-linux system, sigh... :-( ).
>
>  You need to build cross-binutils, cross-gcc and cross-glibc to start.
> I've already written and sent a detailed description on cross-gcc
> bootstrapping here.  I'm not sure if the list is archived, or not.  If
> not, I may dig through my mail archives and send it again.
>
>  If you have any specific questions, don't hesitate to ask me.
>
>   Maciej
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
