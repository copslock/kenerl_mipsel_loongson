Received:  by oss.sgi.com id <S554062AbRBBPxr>;
	Fri, 2 Feb 2001 07:53:47 -0800
Received: from mx.mips.com ([206.31.31.226]:18157 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S554058AbRBBPx3>;
	Fri, 2 Feb 2001 07:53:29 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA12818;
	Fri, 2 Feb 2001 07:51:31 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA10279;
	Fri, 2 Feb 2001 07:51:30 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id QAA11437;
	Fri, 2 Feb 2001 16:51:19 +0100 (MET)
Message-ID: <3A7AD776.46B10823@mips.com>
Date:   Fri, 02 Feb 2001 16:51:18 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     linux-mips@oss.sgi.com
Subject: Re: Cross build applications
References: <Pine.GSO.3.96.1010202162911.28509M-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Please, can anyone provide me with the right set of RPMs, so I can cross
compile a "hello-world" program on a linux PC ?

/Carsten

"Maciej W. Rozycki" wrote:

> On Fri, 2 Feb 2001, Carsten Langgaard wrote:
>
> > >  The file is supposed to come with glibc.  Do you have glibc for
> > > mips-linux installed?
> >
> > No, where can I get it.
>
>  If you want glibc 2.2.1, you may get a source RPM package I made
> available at 'ftp://ftp.ds2.pg.gda.pl/pub/macro/'.  I make mipsel-linux
> builds only, so for cross-compilation you would get a mipsel-linux-glibc
> package, modify the few defines at the top (and possibly the spec file
> name) and build a mips-linux-glibc binary package.  Or build it in the
> traditional way.  Note the few patches I include are not MIPS-specific, so
> you do not really need them unless you want them.
>
>  If you want a glibc 2.0 package or a binary one, then I cannot help you.
> Check the usual resources -- oss.sgi.com and ftp.rfc822.org.  Others may
> provide different pointers as well.
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
