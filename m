Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OA3nnC023723
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 03:03:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OA3m1A023721
	for linux-mips-outgoing; Mon, 24 Jun 2002 03:03:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OA3fnC023715;
	Mon, 24 Jun 2002 03:03:41 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id DAA11070;
	Mon, 24 Jun 2002 03:06:54 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA29277;
	Mon, 24 Jun 2002 03:06:52 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5OA6rb18664;
	Mon, 24 Jun 2002 12:06:53 +0200 (MEST)
Message-ID: <3D16EF3C.BCCB020@mips.com>
Date: Mon, 24 Jun 2002 12:06:52 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: sys_syscall patch.
References: <3D16E14C.5C8D2FAD@mips.com> <20020624115452.A25138@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Mon, Jun 24, 2002 at 11:07:24AM +0200, Carsten Langgaard wrote:
>
> > The 'sys_syscall' syscall isn't properly implemented in the 64-bit
> > kernel (for o32 as well as n64).
> > Below is a patch, it seems to work for in the o32 case, but I haven't
> > tested the n64 version (obviously).
>
> > +/*
> > + * Do the indirect syscall syscall.
> > + * Don't care about kernel locking; the actual syscall will do it.
> > + *
> > + * XXX This is broken.
> > + */
>
> As the comment says - it's broken.  This implementation just like it's
> 32-bit predecessor don't handle the error return value correctly.  Worse,
> there's unprotected accesses to userspace which allow any user crashing
> the system ...
>

At least it makes my system work as well as for the 32-bit kernel.



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
