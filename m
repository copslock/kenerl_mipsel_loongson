Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PEGMnC022146
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 07:16:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PEGM67022145
	for linux-mips-outgoing; Tue, 25 Jun 2002 07:16:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PEGAnC022142;
	Tue, 25 Jun 2002 07:16:10 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id HAA17101;
	Tue, 25 Jun 2002 07:18:48 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA18436;
	Tue, 25 Jun 2002 07:18:50 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5PEInb11468;
	Tue, 25 Jun 2002 16:18:49 +0200 (MEST)
Message-ID: <3D187BC8.17765700@mips.com>
Date: Tue, 25 Jun 2002 16:18:48 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: LTP testing
References: <Pine.GSO.3.96.1020625154306.29623G-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
X-MIME-Autoconverted: from 8bit to quoted-printable by mx2.mips.com id HAA17101
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g5PEGAnC022143
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

> On Tue, 25 Jun 2002, Carsten Langgaard wrote:
>
> > The next LTP failure line is:
> > pipe05      1  BROK  :  Unexpected signal 11 received.
> >
> > For this one I haven't got a fix, because the failure is due to the way
> > the pipe syscall is implemented for MIPS (so we need a fix in both the
> > kernel and glibc).
> >
> > The glibc code look like this
> > SYSCALL__ (pipe, 1)
> >         /* Plop in the two descriptors.  */
> >         sw v0, 0(a0)
> >         sw v1, 4(a0)
> >
> >         /* Go out with a clean status.  */
> >         move v0, zero
> >         j ra
> >         .end __pipe
> >
> > The problem is that the code is called with $a0 = 0. So the 'sw v0,
> > 0(a0)' after the syscall generates a segmentation fault.
>
>  The test is broken and it's what should be fixed, instead -- several
> Linux platforms do it this way, e.g. Alpha and IA-64.  A SIGSEGV is a
> valid response for an invalid address.  Remember you test pipe(3) and not
> pipe(2).

I'm not sure that you mean by pipe(2) and pipe(3), but according to my man
page, pipe should return with EFAULT in this case.

ERRORS
       EMFILE Too  many  file  descriptors are in use by the pro­
              cess.
       ENFILE The system file table is full.
       EFAULT filedes is not valid.

>
>
> > Why are the pipe syscall implemented this way, where we return the two
> > descriptors in v0 and v1 ?
>
>  For performance reasons.  Also it's safer to do such actions from the
> userland.
>
> > Why doesn't the kernel do these stores (this way we can do an access
> > check, like i386 does) ?
>
>  I suppose i386 does these stores in the kernel due to historical reasons.
> There is also the problem of a permanent lack of registers in i386 -- I
> haven't investigated it, but it may simply be unable to afford a second
> result register.
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
