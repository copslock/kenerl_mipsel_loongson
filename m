Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78NseL08493
	for linux-mips-outgoing; Wed, 8 Aug 2001 16:54:40 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78NsdV08482
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 16:54:39 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA01271
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 16:53:44 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 15Ud0Y-0001q5-00; Wed, 08 Aug 2001 16:45:02 -0700
Date: Wed, 8 Aug 2001 16:45:02 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: gcc 3.0 / glibc 2.2.3 cross-toolchain
Message-ID: <20010808164502.A6966@nevyn.them.org>
References: <02a401c12063$cde1e830$3501010a@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <02a401c12063$cde1e830$3501010a@ltc.com>; from brad@ltc.com on Wed, Aug 08, 2001 at 07:42:17PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 07:42:17PM -0400, Bradley D. LaRonde wrote:
> I have spent quite a bit of time trying to get a gcc 3.0 / glibc 2.2.3
> cross-toolchain working.  I am not a Toolchain Builder, but I really wanted
> to try this combo and I don't see any way around building it myself.
> 
> I've had some success.  Everything seems to build fine.  However, when I try
> to run a simple "hello world" dynamically linked with glibc, I get this:
> 
>     <myprogram>: error while loading shared libraries: failed to map
>     segment from shared object: cannot load shared object file: Invalid
> argument
> 
> I think it is trying to load libc.so.6, which is in my root in /lib/,
> symlinked to libc-2.2.3.so, and so is ld.so.1, symlinked to ld-2.2.3.so.
> 
> I feel like I am pretty close, but I am starting to get discouraged and
> could really use some help.  I really am clueless about what
> should/shouldn't work.  I'm trying to do this based on bits and pieces of
> information that I've collected from countless sources.  I have heard that
> gcc 3.0 isn't really "working", but I still want to try.
> 
> Here is what I've used:
> 
>    * binutils-2.11.90.0.25.tar.gz (extracted from H. J. Lu's
>      srpm on oss.sgi.com; I've tried others also)
>    * gcc-3.0.tar.gz (released version - no patches)
>    * glibc-linuxthreads-2.2.3.tar.gz (released version - no
>      patches; glibc didn't want to configure without this)
>    * glibc-2.2.3.tar.gz (released version)

You're missing the patch to change MAP_BASE_ADDR.  You need that. 
Something as simple as changing it to 0 will work for you, since you're
building everything yourself.

If you want debugging info, of course, it's much more complicated :)

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
