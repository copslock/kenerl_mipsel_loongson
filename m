Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GDrPRw031327
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 06:53:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GDrPFf031326
	for linux-mips-outgoing; Tue, 16 Jul 2002 06:53:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GDrFRw031316;
	Tue, 16 Jul 2002 06:53:15 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6GDvVXb027628;
	Tue, 16 Jul 2002 06:57:31 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA26548;
	Tue, 16 Jul 2002 06:57:31 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6GDvUb05899;
	Tue, 16 Jul 2002 15:57:31 +0200 (MEST)
Message-ID: <3D34264A.7845DFDC@mips.com>
Date: Tue, 16 Jul 2002 15:57:30 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Ralf Baechle <ralf@oss.sgi.com>, "H. J. Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com
Subject: Re: Personality
References: <3D33DAB2.353A4399@mips.com> <20020716134014.GA19350@nevyn.them.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:

> On Tue, Jul 16, 2002 at 10:34:58AM +0200, Carsten Langgaard wrote:
> > The include/linux/personality.h file has changed between the 2.4.3 and
> > the 2.4.18 kernel.
> > Now there is a define of personality (#define personality(pers) (pers &
> > PER_MASK), but that breaks things for the users, if they include this
> > file.
> > The user wishes to call the glibc personality function (which do the
> > syscall), and not use the above definition.
> >
> > So I guess we need a "#ifdef __KERNEL__" around some of the code in
> > include/linux/personality.h (at least around the define of personality),
> > which then has to go into the glibc kernel header files.
> >
> > Any comments ?
>
> Why is the user program including <linux/personality.h> in the first
> place?
>

It need some personality type defines.

>
> The right thing to do here is to provide the necessary bits in a glibc
> header, probably in bits/personality.h or so.
>

Agree, that is probably the right way to do it.

>
> --
> Daniel Jacobowitz                           Carnegie Mellon University
> MontaVista Software                         Debian GNU/Linux Developer

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
