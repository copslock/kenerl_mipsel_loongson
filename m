Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35EbdJ28371
	for linux-mips-outgoing; Thu, 5 Apr 2001 07:37:39 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35EbSM28363;
	Thu, 5 Apr 2001 07:37:28 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA28669;
	Thu, 5 Apr 2001 07:36:39 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA29230;
	Thu, 5 Apr 2001 07:36:36 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id QAA20302;
	Thu, 5 Apr 2001 16:35:54 +0200 (MEST)
Message-ID: <3ACC82C9.7612DCDE@mips.com>
Date: Thu, 05 Apr 2001 16:35:53 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
References: <Pine.GSO.3.96.1010405135731.21134B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I tried the following:
rpm -ba --rcfile .rpmrc-mipsel SPECS/mipsel-linux-binutils-2.10.91-2.spec

but it fails with
Architecture is excluded: mipsel

/Carsten

"Maciej W. Rozycki" wrote:

> On Thu, 5 Apr 2001, Carsten Langgaard wrote:
>
> > I have question about installation of the SRPMs, though.
> > How can I relocate the packages, so they don't need to reside under
> > /usr/src/redhat/ ?
>
>  RPM uses the value of the _topdir macro as the root for source handling.
> You may override the default from /usr/lib/rpm/macros in several places --
> see the macrofiles tag in /usr/lib/rpm/rpmrc.  I have it overriden to
> /home/macro/src/redhat in the configuration files I made available at my
> FTP site.
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
