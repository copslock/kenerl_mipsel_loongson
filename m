Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HK5FRw030423
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 13:05:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HK5FRp030422
	for linux-mips-outgoing; Wed, 17 Jul 2002 13:05:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HK53Rw030401;
	Wed, 17 Jul 2002 13:05:03 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6HK9sXb003747;
	Wed, 17 Jul 2002 13:09:54 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA10513;
	Wed, 17 Jul 2002 13:09:54 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6HK9rb10252;
	Wed, 17 Jul 2002 22:09:54 +0200 (MEST)
Message-ID: <3D35D036.1EE50ADA@mips.com>
Date: Wed, 17 Jul 2002 22:14:46 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: pread and pwrite
References: <3D3532FB.E227A5AD@mips.com> <20020717155930.A25258@dea.linux-mips.net> <3D357CA9.B847EDAC@mips.com> <20020717120108.A14143@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H. J. Lu" wrote:

> On Wed, Jul 17, 2002 at 04:18:17PM +0200, Carsten Langgaard wrote:
> > Ralf Baechle wrote:
> >
> > > On Wed, Jul 17, 2002 at 11:03:55AM +0200, Carsten Langgaard wrote:
> > >
> > > >
> > > > Here there is some checking for sane values and a proper error value is
> > > > return.
> > > > I guess this routine is replaced, if we have the syscall implemented
> > > > with the sysdeps/unix/sysv/linux/mips/pread.c file.
> > > > Here there is no check for sane values, is there any reason why ?
> > > > The same thing goes for pwrite.
> > >
> > > The kernel does it's own error checking.  No need to duplicate that in
> > > userspace.
> >
> > The kernel doesn't do this a proper check then.
> > The pread/pwrite parameters is also convert in glibc, the 'offset' is
> > convert from a 'long' to a 'long long', but it isn't sign extended.
> > So when pread is call with offset -1, then kernel won't see it as -1.
> >
>
> Please check it out:
>
> http://sources.redhat.com/ml/libc-alpha/2002-07/msg00188.html
>
> H.J.

So the same issue has been raised today on the glibc list, amazing. I guess the
problem has existed quite some time.
But it look like the patch will fix the problem. Do you know if the patch has
been committed and which version of glibc will it then be fixed in ?

Thanks,
/Carsten
