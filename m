Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 11:39:23 +0200 (CEST)
Received: from [212.74.13.151] ([212.74.13.151]:35837 "EHLO dell.zee2.com")
	by linux-mips.org with ESMTP id <S1122960AbSITJjW>;
	Fri, 20 Sep 2002 11:39:22 +0200
Received: from zee2.com (localhost [127.0.0.1])
	by dell.zee2.com (8.11.6/8.11.6) with ESMTP id g8K9cCM20345;
	Fri, 20 Sep 2002 10:38:14 +0100
Message-ID: <3D8AEC84.ADA8CE0A@zee2.com>
Date: Fri, 20 Sep 2002 10:38:12 +0100
From: Stuart Hughes <seh@zee2.com>
Organization: Zee2 Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linda Wang <linda.wang@intransa.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: FW: cannot debug multi-threaded programs with gdb/gdbserver
References: <EA23924D8B48774F889C7733226B28E8B7E51C@exalane.intransa.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <seh@zee2.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: seh@zee2.com
Precedence: bulk
X-list: linux-mips

Hi Linda,

I followed the advice from Daniel/Steve and upgraded my toolchain
(binutils-2.13/gcc-2.3/glibc-2.2.5/).  Now I can do some thread aware
gdb/gdbserver debug.  

It seems to work fine on simple programs, but on some other large
applications some behaviour is not predictable (this may well be the
application, as it issues SIGSTOP/SIGCONT to control threads, and I
think this causes gdb to get confused).

One thing that is not obvious is that you need to set (either at the
command line or in a .gdbinit file):

set heuristic-fence-post 20		// not sure if this is actually needed
set solib-absolute-prefix /dev/null
set solib-search-path
<path_to_cross_compiled_standard_libs>:<path_to_your_shared_libs>

In my case:
<path_to_cross_compiled_standard_libs> is /usr/local/mipsel-linux

NOTE: no lib component (this is passed back from the location on the
target ???).

<path_to_your_shared_libs>	This is only needed if you have your own
shared libs.

NOTE: The path on the host must contain the basename component, but this
must not be given in the <path_to_your_shared_libs>

For instance, if I build on the host and the library ends up in
/home/seh/project/test/lib, but the library ends up on the target in
/apps/custom/mylibs

You would need to:
- make a symlink on the homst from lib -> mylibs
- set <path_to_your_shared_libs> to /home/seh/project/test

Regards, Stuart



Linda Wang wrote:
> 
> Hi Stuart,
> 
> Have you manage to get gdb to work with 5.3 version, with pthread
> without seeing the Warning problems?
> 
> We are encountered the same problem on our system as well, but
> we have different mips processor.
> 
> any further info would be greatly appreciated.
> thanks,
> -linda
> 
> -----Original Message-----
> From: Stuart Hughes [mailto:seh@zee2.com]
> Sent: Tuesday, September 17, 2002 10:03 AM
> Subject: cannot debug multi-threaded programs with gdb/gdbserver
> 
> Hi,
> 
> I managed to get gdb to do multi-threaded debug using a gdb on the
> target, after Daniel J helped with a patch to sys/procfs.h
> 
> I am now trying to do host target with gdb/gdbserver.  The program on
> the target uses pthreads.
> 
> I can connect, but as soon as you try to continue (to a breakpoint) I
> get:
> 
> Program received signal SIG32, Real-time event 32.
> warning: Warning: GDB can't find the start of the function at
> 0x2abee684.
> ....
> 
> I know that SIG32 is used for the thread control on the target, but I'm
> not sure if the host gdb is supposed to receive this.  I tried "set
> handle SIG32 pass noprint nostop"
> and variations, but this didn't help.
> 
> Does anyone know whether there is some special setup needed on
> gdb/gdbserver to use the multi-threaded gdbserver ??
> 
> My environment is as follows:
> 
> CPU:            NEC VR5432
> kernel:         linux-2.4.18 + patches
> glibc:          2.2.3 + patches
> gdb:            5.2/3 from CVS
> gcc:            3.1
> binutils:       Version 2.11.90.0.25
> 
> cross-gdb configured using:
> 
> configure --prefix=/usr --target=mipsel-linux --disable-sim
> --disable-tcl --enable-threads --enable-shared
> 
> gdbserver configured using:
> 
> configure --prefix=/usr --host=mipsel-linux --target=mipsel-linux
> --enable-threads --enable-shared
> 
> Regards, Stuart
