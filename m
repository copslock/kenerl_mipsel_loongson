Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 18:24:52 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:53766 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122978AbSITQYv>;
	Fri, 20 Sep 2002 18:24:51 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17sRW3-0000yf-00; Fri, 20 Sep 2002 12:24:31 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17sQa1-0003As-00; Fri, 20 Sep 2002 12:24:33 -0400
Date: Fri, 20 Sep 2002 12:24:33 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Stuart Hughes <seh@zee2.com>
Cc: Linda Wang <linda.wang@intransa.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: FW: cannot debug multi-threaded programs with gdb/gdbserver
Message-ID: <20020920162433.GA12166@nevyn.them.org>
References: <EA23924D8B48774F889C7733226B28E8B7E51C@exalane.intransa.com> <3D8AEC84.ADA8CE0A@zee2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8AEC84.ADA8CE0A@zee2.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 20, 2002 at 10:38:12AM +0100, Stuart Hughes wrote:
> Hi Linda,
> 
> I followed the advice from Daniel/Steve and upgraded my toolchain
> (binutils-2.13/gcc-2.3/glibc-2.2.5/).  Now I can do some thread aware
> gdb/gdbserver debug.  
> 
> It seems to work fine on simple programs, but on some other large
> applications some behaviour is not predictable (this may well be the
> application, as it issues SIGSTOP/SIGCONT to control threads, and I
> think this causes gdb to get confused).

This should not confuse gdbserver.  I'm not sure what it'll do to
native GDB, but I don't think it'll confuse that either...

> set heuristic-fence-post 20		// not sure if this is actually needed
> set solib-absolute-prefix /dev/null
> set solib-search-path
> <path_to_cross_compiled_standard_libs>:<path_to_your_shared_libs>
> 
> In my case:
> <path_to_cross_compiled_standard_libs> is /usr/local/mipsel-linux
> 
> NOTE: no lib component (this is passed back from the location on the
> target ???).
> 
> <path_to_your_shared_libs>	This is only needed if you have your own
> shared libs.
> 
> NOTE: The path on the host must contain the basename component, but this
> must not be given in the <path_to_your_shared_libs>
> 
> For instance, if I build on the host and the library ends up in
> /home/seh/project/test/lib, but the library ends up on the target in
> /apps/custom/mylibs
> 
> You would need to:
> - make a symlink on the homst from lib -> mylibs
> - set <path_to_your_shared_libs> to /home/seh/project/test

You should not be doing it this way; life will be much easier if you
just set the shared libraries up in the same hierarchy on target and
host and set solib-absolute-prefix /location/of/host/lib/tree.  That
is,
	/location/of/host/lib/tree/lib/ld-2.2.5.so
	/location/of/host/lib/tree/usr/lib/libz.so
et cetera.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
