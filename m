Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8E4S8u21966
	for linux-mips-outgoing; Thu, 13 Sep 2001 21:28:08 -0700
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8E4S3e21963
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 21:28:04 -0700
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15hkaZ-0000bd-00; Fri, 14 Sep 2001 00:28:27 -0400
Date: Fri, 14 Sep 2001 00:28:27 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: binutils@sources.redhat.com, gdb@sourceware.cygnus.com,
   linux-mips@oss.sgi.com
Subject: Re: Continued MIPS kernel debugging symbols problem...
Message-ID: <20010914002827.A2305@nevyn.them.org>
Mail-Followup-To: "Steven J. Hill" <sjhill@cotw.com>,
	binutils@sources.redhat.com, gdb@sourceware.cygnus.com,
	linux-mips@oss.sgi.com
References: <3BA16CAA.6B4DF4A1@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3BA16CAA.6B4DF4A1@cotw.com>; from sjhill@cotw.com on Thu, Sep 13, 2001 at 09:34:18PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 13, 2001 at 09:34:18PM -0500, Steven J. Hill wrote:
>     configure --prefix=/opt/tools --target=mipsel-linux-elf
> 
> since my target is a NEC 5432 running in LE mode. I had
> also tried 'mips-linux-elf' targets earlier in the day
> with no difference. I am still getting the following
> mismatch in symbols:

(Could you try building a mipsel-unknown-linux-gnu debugger/compiler
instead?  Does it make any difference?  I don't expect it to.)

> I compiled my kernel with a toolchain that used the following
> versions of tools:
> 
>     binutils-2.11.90.0.31 (HJLu patches applied)
>     gcc-3.0.1 (stock)
>     glibc-2.2.3 (minor build patches)

If you'll post a binary that you're having trouble debugging, I'll try
to find time in the next couple of days to see what GDB is doing wrong.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
