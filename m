Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IKbNb19265
	for linux-mips-outgoing; Wed, 18 Apr 2001 13:37:23 -0700
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.225])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IKbLM19255
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 13:37:21 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14pyhb-0007jJ-00; Wed, 18 Apr 2001 16:37:27 -0400
Date: Wed, 18 Apr 2001 16:37:27 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Question on the binutils tradlittlemips patch
Message-ID: <20010418163727.A29531@nevyn.them.org>
References: <20010418141959.A24473@nevyn.them.org> <3ADDFD6A.AD0DDE4A@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3ADDFD6A.AD0DDE4A@cotw.com>; from sjhill@cotw.com on Wed, Apr 18, 2001 at 03:47:38PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 18, 2001 at 03:47:38PM -0500, Steven J. Hill wrote:
> Daniel Jacobowitz wrote:
> > 
> > I've been trying to make this patch work as part of a complete
> > toolchain, based on glibc.  In addition to a little snag (when building
> > glibc for big-endian mips you need an equivalent change in the target
> > format), I hit a serious shared library error - nothing linked
> > dynamically worked.  This is the cause:
> > 
> Yes, I have a patch against GLIBC. Go to my FTP site here:
> 
>     ftp://ftp.cotw.com/pub/linux/nino/toolchain
> 
> It is currently a hack as I have not figured out how to construct a
> patch for GLIBC since it will break the other MIPS targets. See if
> it helps.

If you're referring to libc-mips-04052001.patch.bz2, that's what I
started with.  I needed two changes on top of it.  I'll post them in a
bit.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
