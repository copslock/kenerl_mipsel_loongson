Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6IHFtRw003953
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 10:15:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6IHFtlJ003952
	for linux-mips-outgoing; Thu, 18 Jul 2002 10:15:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc01.attbi.com (sccrmhc01.attbi.com [204.127.202.61])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6IHFkRw003943;
	Thu, 18 Jul 2002 10:15:46 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020717190109.RXRS29588.sccrmhc01.attbi.com@ocean.lucon.org>;
          Wed, 17 Jul 2002 19:01:09 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A87BB125D8; Wed, 17 Jul 2002 12:01:08 -0700 (PDT)
Date: Wed, 17 Jul 2002 12:01:08 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: pread and pwrite
Message-ID: <20020717120108.A14143@lucon.org>
References: <3D3532FB.E227A5AD@mips.com> <20020717155930.A25258@dea.linux-mips.net> <3D357CA9.B847EDAC@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D357CA9.B847EDAC@mips.com>; from carstenl@mips.com on Wed, Jul 17, 2002 at 04:18:17PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 17, 2002 at 04:18:17PM +0200, Carsten Langgaard wrote:
> Ralf Baechle wrote:
> 
> > On Wed, Jul 17, 2002 at 11:03:55AM +0200, Carsten Langgaard wrote:
> >
> > >
> > > Here there is some checking for sane values and a proper error value is
> > > return.
> > > I guess this routine is replaced, if we have the syscall implemented
> > > with the sysdeps/unix/sysv/linux/mips/pread.c file.
> > > Here there is no check for sane values, is there any reason why ?
> > > The same thing goes for pwrite.
> >
> > The kernel does it's own error checking.  No need to duplicate that in
> > userspace.
> 
> The kernel doesn't do this a proper check then.
> The pread/pwrite parameters is also convert in glibc, the 'offset' is
> convert from a 'long' to a 'long long', but it isn't sign extended.
> So when pread is call with offset -1, then kernel won't see it as -1.
> 

Please check it out:

http://sources.redhat.com/ml/libc-alpha/2002-07/msg00188.html


H.J.
