Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f450Ysl30298
	for linux-mips-outgoing; Fri, 4 May 2001 17:34:54 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f450YpF30291
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 17:34:52 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f450Xj320572;
	Fri, 4 May 2001 21:33:45 -0300
Date: Fri, 4 May 2001 21:33:45 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Justin Carlson <carlson@sibyte.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: mips64 linux glibc compilation broken?
Message-ID: <20010504213345.B20515@bacchus.dhis.org>
References: <0104301108411I.31854@plugh.sibyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0104301108411I.31854@plugh.sibyte.com>; from carlson@sibyte.com on Mon, Apr 30, 2001 at 11:07:33AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 30, 2001 at 11:07:33AM -0700, Justin Carlson wrote:

> I could swear I saw this topic go by before, but searching my archives,
> I don't see it.
> 
> glibc fresh out of redhat cvs doesn't compile for mips64-linux; it fails
> with quite a bit of stuff like this:
> 
> ---
> In file included from dynamic-link.h:21,
> from dl-load.c:32:
> ../sysdeps/mips/mips64/dl-machine.h: In function `elf_machine_got_rel':
> ../sysdeps/mips/mips64/dl-machine.h:178: warning: passing arg 2 of `_dl_lookup_symbol' from incompatible pointer type
> ../sysdeps/mips/mips64/dl-machine.h:178: warning: passing arg 3 of `_dl_lookup_symbol' from incompatible pointer type
> ../sysdeps/mips/mips64/dl-machine.h:178: warning: passing arg 4 of `_dl_lookup_symbol' from incompatible pointer type
> ../sysdeps/mips/mips64/dl-machine.h:178: too few arguments to function `_dl_lookup_symbol'
> ../sysdeps/mips/mips64/dl-machine.h:181: warning: passing arg 2 of `_dl_lookup_symbol' from incompatible pointer type
> ../sysdeps/mips/mips64/dl-machine.h:181: warning: passing arg 3 of `_dl_lookup_symbol' from incompatible pointer type
> ../sysdeps/mips/mips64/dl-machine.h:181: warning: passing arg 4 of `_dl_lookup_symbol' from incompatible pointer type
> ---
> 
> It looks like this is something that has been fixed for mips, but not mips64. 
> I'm sure I can fix the immediate compile problems, but am not familiar enough
> with glibc to be confident of doing the Right Thing overall.
> 
> Are there any patches for mips64 linux that haven't made it into the mainline
> cvs yet?

I already answered this before in private email - mips64 is not support
in glibc nor was it ever working properly.  And won't until somebody fixed
the assembler and ld first ...

All software mips64 systems are currently running is 32-bit stuff running
in the binary compatibility mode.

  Ralf
