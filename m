Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HEDZRw024766
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 07:13:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HEDZ5U024765
	for linux-mips-outgoing; Wed, 17 Jul 2002 07:13:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HEDRRw024753;
	Wed, 17 Jul 2002 07:13:27 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6HEIHXb002497;
	Wed, 17 Jul 2002 07:18:17 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA22521;
	Wed, 17 Jul 2002 07:18:18 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6HEIIb22956;
	Wed, 17 Jul 2002 16:18:18 +0200 (MEST)
Message-ID: <3D357CA9.B847EDAC@mips.com>
Date: Wed, 17 Jul 2002 16:18:17 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "H. J. Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: pread and pwrite
References: <3D3532FB.E227A5AD@mips.com> <20020717155930.A25258@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Wed, Jul 17, 2002 at 11:03:55AM +0200, Carsten Langgaard wrote:
>
> >
> > Here there is some checking for sane values and a proper error value is
> > return.
> > I guess this routine is replaced, if we have the syscall implemented
> > with the sysdeps/unix/sysv/linux/mips/pread.c file.
> > Here there is no check for sane values, is there any reason why ?
> > The same thing goes for pwrite.
>
> The kernel does it's own error checking.  No need to duplicate that in
> userspace.

The kernel doesn't do this a proper check then.
The pread/pwrite parameters is also convert in glibc, the 'offset' is
convert from a 'long' to a 'long long', but it isn't sign extended.
So when pread is call with offset -1, then kernel won't see it as -1.

>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
