Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5QBKBnC000323
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 26 Jun 2002 04:20:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5QBKBPO000322
	for linux-mips-outgoing; Wed, 26 Jun 2002 04:20:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5QBJrnC000314;
	Wed, 26 Jun 2002 04:19:54 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id EAA22319;
	Wed, 26 Jun 2002 04:22:39 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA06209;
	Wed, 26 Jun 2002 04:22:39 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5QBMZb22925;
	Wed, 26 Jun 2002 13:22:38 +0200 (MEST)
Message-ID: <3D19A3FA.760B3F6F@mips.com>
Date: Wed, 26 Jun 2002 13:22:34 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Williamson <robbiew@us.ibm.com>
CC: Johannes Stezenbach <js@convergence.de>, linux-mips@oss.sgi.com,
   ltp-list@lists.sourceforge.net, ltp-list-admin@lists.sourceforge.net,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: [LTP] Re: LTP testing
References: <OFDCED143B.2CF490DC-ON85256BE3.005EDCBA@pok.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
X-MIME-Autoconverted: from 8bit to quoted-printable by mx2.mips.com id EAA22319
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g5QBJsnC000315
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The setgroup03 test also fails:
setgroups03    1  FAIL  :  setgroups() fails, Size is > NGROUPS, errno=1, expected errno=22

Is this a kernel failure or a LTP failure ?

The kernel do the following check in sys_setgroups:
     if (!capable(CAP_SETGID))
          return -EPERM;
     if ((unsigned) gidsetsize > NGROUPS)
          return -EINVAL;

If I changes the kernel, so it does the size check first, then the test passes.
But one could also changes the LTP, so it makes sure that one is super user when making the size check test.

So my question is, should this be fixed in the kernel or in LTP ?
/Carsten

Robert Williamson wrote:

> We actually try to stick to the Single Unix Specification whenever
> possible.  I agree that the test should handle the SIGSEGV call.  We
> actually have had other tests with the same scenario and have fixed them.
> These tests were ported from OS's with strict guidelines on what to expect
> that matched the manpages....this is obviously not the case with Linux.
> We'll take a look at it and hopefully have a fixed version by the July
> release...if not a patch will be supplied on the LTP mailing list
> <ltp-list@lists.sf.net>
>
> - Robbie
>
> Robert V. Williamson <robbiew@us.ibm.com>
> Linux Test Project
> IBM Linux Technology Center
> Phone: (512) 838-9295   T/L: 638-9295
> http://ltp.sourceforge.net
>
>
>                       Johannes Stezenbach
>                       <js@convergence.de>              To:       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
>                       Sent by:                         cc:       Carsten Langgaard <carstenl@mips.com>, Ralf Baechle
>                       ltp-list-admin@lists.sour         <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
>                       ceforge.net                       ltp-list@lists.sourceforge.net
>                                                        Subject:  [LTP] Re: LTP testing
>
>                       06/25/2002 09:28 AM
>
>
>
> On Tue, Jun 25, 2002 at 03:53:25PM +0200, Maciej W. Rozycki wrote:
> > On Tue, 25 Jun 2002, Carsten Langgaard wrote:
> >
> > > The next LTP failure line is:
> > > pipe05      1  BROK  :  Unexpected signal 11 received.
> > >
> > > For this one I haven't got a fix, because the failure is due to the way
> > > the pipe syscall is implemented for MIPS (so we need a fix in both the
> > > kernel and glibc).
> > >
> > > The glibc code look like this
> > > SYSCALL__ (pipe, 1)
> > >         /* Plop in the two descriptors.  */
> > >         sw v0, 0(a0)
> > >         sw v1, 4(a0)
> > >
> > >         /* Go out with a clean status.  */
> > >         move v0, zero
> > >         j ra
> > >         .end __pipe
> > >
> > > The problem is that the code is called with $a0 = 0. So the 'sw v0,
> > > 0(a0)' after the syscall generates a segmentation fault.
> >
> >  The test is broken and it's what should be fixed, instead -- several
> > Linux platforms do it this way, e.g. Alpha and IA-64.  A SIGSEGV is a
> > valid response for an invalid address.  Remember you test pipe(3) and not
> > pipe(2).
>
> The question is what API spec is relevant for Linux. My pipe(2) man page
> says (there is no pipe(3) man page):
>
>   int pipe(int filedes[2]);
>   ...
>   ERRORS
>     ...
>     EFAULT filedes is not valid.
>
> whereas The Single UNIX ® Specification, Version 2
> (http://www.opengroup.org/onlinepubs/007908799/xsh/pipe.html)
> implies the SIGSEGV is OK.
>
> Maybe the LTP folks can shed a light on this.
>
> Regards,
> Johannes
>
> -------------------------------------------------------
> Sponsored by:
> ThinkGeek at http://www.ThinkGeek.com/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
