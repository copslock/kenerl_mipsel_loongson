Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Feb 2003 11:39:21 +0000 (GMT)
Received: from alg129.algor.co.uk ([IPv6:::ffff:62.254.210.129]:13323 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225194AbTBKLjU>; Tue, 11 Feb 2003 11:39:20 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1A9NwU00882;
	Mon, 10 Feb 2003 09:23:58 GMT
Date: Mon, 10 Feb 2003 09:23:57 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>
Subject: Re: porting arcboot
Message-ID: <20030210092357.A879@linux-mips.org>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030210034549.GA8408@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Mon, Feb 10, 2003 at 02:45:49PM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 10, 2003 at 02:45:49PM +1100, Andrew Clausen wrote:

> I'm planning to try porting arcboot to ip27 (mips64).
> 
> I plan to do this by cross-compiling... this is actually the only
> option since there's no 64 bit userland yet.
> 
> Some issues:
> 
>  * I'll be cross-compiling (using the mips64-linux-gcc & friends that
> are provided on ftp.linux-mips.org), which means some makefile hacking...
> 
>  * there's no mips64-linux glibc, which means no libc headers are
> available.  So I need to either cut&paste libc headers, or remove
> dependencies on them.  This affects lots of code.
> 
>  * the e2fs stuff... how is this being maintained?  It uses libc
> headers a bit... can I kill them?  Or will this make it hard to update
> to new upstream e2fsprogs releases?
> 
> Anything else?

Arcboot is a standalone program.  As such it shouldn't use anything from
glibc or it's going to be a royal pain in the lower back extension.
Look at Milo, spit and say no.  So keeping a private copy of the necessary
headers is the only sane way to get things to work.

  Ralf
