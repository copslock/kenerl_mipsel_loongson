Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IKFEL17937
	for linux-mips-outgoing; Wed, 18 Apr 2001 13:15:14 -0700
Received: from mail.kdt.de (mail.kdt.de [195.8.224.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IKFCM17933
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 13:15:13 -0700
Received: from arthur.inka.de (arthur.kdt.de [195.8.250.5])
	by mail.kdt.de (8.11.1/8.11.0) with ESMTP id f3IKEmJ18435;
	Wed, 18 Apr 2001 22:14:48 +0200
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14pyIE-0003Ng-00; Wed, 18 Apr 2001 22:11:14 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 973861EA2E; Wed, 18 Apr 2001 22:11:12 +0200 (CEST)
Mail-Copies-To: never
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: Question on the binutils tradlittlemips patch
References: <20010418141959.A24473@nevyn.them.org>
From: Andreas Jaeger <aj@suse.de>
Date: 18 Apr 2001 22:11:11 +0200
In-Reply-To: <20010418141959.A24473@nevyn.them.org> (Daniel Jacobowitz's message of "Wed, 18 Apr 2001 14:19:59 -0400")
Message-ID: <u8vgo23r4w.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz <dan@debian.org> writes:

> I've been trying to make this patch work as part of a complete
> toolchain, based on glibc.  In addition to a little snag (when building
> glibc for big-endian mips you need an equivalent change in the target
> format), I hit a serious shared library error - nothing linked

Do I understand you correctly that glibc needs a patch?  Please send
it to me.

> dynamically worked.  This is the cause:
> 
> --- elf32lsmip.sh       Thu Jun  3 14:02:10 1999
> +++ elf32ltsmip.sh      Wed Apr 11 00:14:08 2001
> 
> ...
> 
> -SHLIB_TEXT_START_ADDR=0x5ffe0000
> +SHLIB_TEXT_START_ADDR=0x0
> 
> 
> Is this necessary for the ABI?  If so, glibc needs to be updated to
> reflect that:
> 
> /*
>  * MIPS libraries are usually linked to a non-zero base address.  We
>  * subtract the base address from the address where we map the object
>  * to.  This results in more efficient address space usage.
>  *
>  * FIXME: By the time when MAP_BASE_ADDR is called we don't have the
>  * DYNAMIC section read.  Until this is fixed make the assumption that
>  * libraries have their base address at 0x5ffe0000.  This needs to be
>  * fixed before we can safely get rid of this MIPSism.
>  */
> #if 0
> #define MAP_BASE_ADDR(l) ((l)->l_info[DT_MIPS(BASE_ADDRESS)] ? \
> 			  (l)->l_info[DT_MIPS(BASE_ADDRESS)]->d_un.d_ptr : 0)
> #else
> #define MAP_BASE_ADDR(l) 0x5ffe0000
> #endif
> 
> 
> Of course, now that is completely wrong.
> 
> One of the two definitely needs to give.  From the evilness of the hack
> in glibc, I'm assuming that glibc needs to give.
> 
> 
> Am I on the right track here?

You might be - but it's quite difficult to fix in glibc.  If you get
it working in glibc, send me a patch that works with old and new
binaries - and I'll gladly review and commit it.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
