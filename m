Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5FJfYr27343
	for linux-mips-outgoing; Fri, 15 Jun 2001 12:41:34 -0700
Received: from tennyson.netexpress.net (IDENT:root@tennyson.netexpress.net [64.22.192.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5FJfVk27340
	for <linux-mips@oss.sgi.com>; Fri, 15 Jun 2001 12:41:31 -0700
Received: from localhost (vorlon@localhost)
	by tennyson.netexpress.net (8.9.3/8.9.3) with ESMTP id OAA02136;
	Fri, 15 Jun 2001 14:41:30 -0500
X-Authentication-Warning: tennyson.netexpress.net: vorlon owned process doing -bs
Date: Fri, 15 Jun 2001 14:41:30 -0500 (CDT)
From: Steve Langasek <vorlon@netexpress.net>
To: <linux-mips@oss.sgi.com>
cc: <debian-mips@lists.debian.org>
Subject: Re: First version of sid-based root-tarball for mipsel available
In-Reply-To: <20010615200828.A19897@linuxtag.org>
Message-ID: <Pine.LNX.4.30.0106151412040.1744-100000@tennyson.netexpress.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Karsten,

On Fri, 15 Jun 2001, Karsten Merker wrote:

> Hallo everyone,

> I have put together a first version of a root-tarball for mipsel based on
> Debian "Sid". This is mostly untested yet and due to the SYSMIPS-problem
> it works only on R4K and higher. If somebody wants to try it out, please
> let me know the results.

> The tarball can be found at
> ftp://bolugftp.uni-bonn.de/pub/mipsel-linux/rootfs/experimental/debian-mipsel-rootfs-20010615.tar.bz2

I'd be interested to give this a try, if only I could get a recent Linux
kernel booting on my system. :)  My Cobalt CacheRaq has so far resisted all of
my efforts to get 2.4 booting; it finds the kernel I've compiled, gets as far
as starting to load the filesystems, but then goes into a loop reporting
problems with 'spurious interrupts'.  So either I'm running the wrong patch
against the 2.4.0 sources, or the CacheRaq is not yet well-supported under
2.4.

Karsten, what type of system are you doing your mipsel testing/development on?

Regards,
Steve Langasek
postmodern programmer
