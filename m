Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PF4CnC022971
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 08:04:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PF4CiY022970
	for linux-mips-outgoing; Tue, 25 Jun 2002 08:04:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PF41nC022967;
	Tue, 25 Jun 2002 08:04:01 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id IAA17304;
	Tue, 25 Jun 2002 08:06:41 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA20130;
	Tue, 25 Jun 2002 08:06:41 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5PF6eb13825;
	Tue, 25 Jun 2002 17:06:40 +0200 (MEST)
Message-ID: <3D1886FF.8D63762C@mips.com>
Date: Tue, 25 Jun 2002 17:06:39 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: LTP testing
References: <Pine.GSO.3.96.1020625162041.29623I-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
X-MIME-Autoconverted: from 8bit to quoted-printable by mx2.mips.com id IAA17304
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g5PF41nC022968
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ok, you have convinced me, as long as the man page and the LTP get fixed.

/Carsten

"Maciej W. Rozycki" wrote:

> On Tue, 25 Jun 2002, Carsten Langgaard wrote:
>
> > > Linux platforms do it this way, e.g. Alpha and IA-64.  A SIGSEGV is a
> > > valid response for an invalid address.  Remember you test pipe(3) and not
> > > pipe(2).
> >
> > I'm not sure that you mean by pipe(2) and pipe(3), but according to my man
> > page, pipe should return with EFAULT in this case.
>
>  pipe(2) is a syscall, while pipe(3) is a library call (see `man 2 intro'
> and `man 3 intro', respectively).  You rarely access syscalls directly --
> the system library usually does this for you.  Depending on a system
> certain library functions may be trivial syscall wrappers, invoke a number
> of syscalls (see e.g. the stat() family) or be implemented entirely in the
> userland.
>
> > ERRORS
> >        EMFILE Too  many  file  descriptors are in use by the pro­
> >               cess.
> >        ENFILE The system file table is full.
> >        EFAULT filedes is not valid.
>
>  Yep, this denotes such an error is possible and under what conditions.  I
> don't think it actually mandates it, at least it's not expressed
> explicitly.  Anyway, it's valid for i386 and possibly nothing else.  Look
> at the system version it refers to -- my version is: "Linux 0.99.11 23
> July 1993".
>
>  A brief search of the web for "EFAULT pipe" reveals confirms others agree
> with me -- the error is not mandatory (the EFAULT vs SIGSEGV issue was
> discussed a few times at least in various contexts -- go search the web).
>
>  I believe a SIGSEGV is saner, too -- this way it's harder for an error
> resulting from passing an invalid pointer to remain unnoticed (consider
> some code that passes a pointer to read-only memory and fails to check a
> result of pipe()).
>
>  If still in doubt, you may try to discuss the LTP result at
> <linux-kernel@vger.kernel.org>.  I don't think anybody wants to rewrite
> pipe(2) for all the platforms that handle it our way.
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
