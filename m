Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3P9Xct25589
	for linux-mips-outgoing; Wed, 25 Apr 2001 02:33:38 -0700
Received: from colo.asti-usa.com (IDENT:root@colo.asti-usa.com [205.252.89.99])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3P9XaM25586
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 02:33:36 -0700
Received: from lineo.com (hal.uk.zentropix.com [212.74.13.151])
	by colo.asti-usa.com (8.9.3/8.9.3) with ESMTP id FAA06767;
	Wed, 25 Apr 2001 05:41:09 -0400
Message-ID: <3AE69AAA.76A20F08@lineo.com>
Date: Wed, 25 Apr 2001 10:36:42 +0100
From: Ian Soanes <ians@lineo.com>
Organization: Lineo UK
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Shmulevich <michaels@jungo.com>
CC: FR Linux/MIPS <linux-mips@fnet.fr>, Linux/MIPS <linux-mips@oss.sgi.com>
Subject: Re: usermode gdb / remote gdb
References: <3AE67CBA.4060606@jungo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Michael Shmulevich wrote:
> 
> Hi,
> 
> I am trying to configure gdb to debug usermode on my mips box. i have
> two choices: one is to use "native"-compiled gdb, ot remote debugging on
> x86 box via serial or IP.
> 
> Currently I have no luck making any of the two configurations.
> 
> For "native" gdb I try to
> $ CC=mips-linux-gcc ./configure mips-linux
> and eventually I get
> configure: error: *** Gdb does not support host mips-mips-linux-gnu
> 
> For remote debugging, I use
> $ ./configure --target=mips
> which succeded, and I even am able to get cross 'mips-gdb' which
> understands mips executables. However, when trying to configure gdbserver,
> 
> $ cd gdb/gdbserver
> $ ../../configure mips-linux
> *** ./configure.in has no "per-host:" line.
> *** Hmm, looks like this directory has been autoconfiscated.
> *** Running the local configure script.
> creating cache config.cache
> checking host system type... mips-mips-linux-gnu
> checking target system type... mips-mips-linux-gnu
> checking build system type... mips-mips-linux-gnu
> checking for a BSD compatible install... /usr/bin/install -c
> configure: error: *** GDB remote does not support host mips-mips-linux-gnu
> 
> Too bad, have seen it before, so I just tried to
> 
> $ ../../configure --host=mips --target=mips
> *** ./configure.in has no "per-host:" line.
> *** Hmm, looks like this directory has been autoconfiscated.
> *** Running the local configure script.
> loading cache config.cache
> checking host system type... mips-mips-elf
> checking target system type... mips-mips-elf
> checking build system type... mips-mips-elf
> checking for a BSD compatible install... /usr/bin/install -c
> configure: error: *** GDB remote does not support host mips-mips-elf
> 
> And the last try (like the one that worked before):
> 
> $ ../../configure --target=mips
> Configuring for a i686-pc-linux-gnu host.
> *** ./configure.in has no "per-host:" line.
> *** Hmm, looks like this directory has been autoconfiscated.
> *** Running the local configure script.
> loading cache config.cache
> checking host system type... i686-pc-linux-gnu
> checking target system type... mips-mips-elf
> checking build system type... i686-pc-linux-gnu
> checking for a BSD compatible install... /usr/bin/install -c
> updating cache config.cache
> creating ./config.status
> creating Makefile
> linking ./../config/i386/xm-linux.h to xm.h
> linking ./../config/mips/tm-embed.h to tm.h
> linking ./../config/nm-empty.h to nm.h
> 
> which clearly misconfigured, because of host system type set to x86, and
> nm.h is pointing to nm-emty.h (?).
> 
>  From what I see, I cannot use neither mips-linux nor mips-elf for host
> specification. On the other hand, I have seen lately a lot of discussion
> for gdb support for MIPS (bot kernel and usermode).
> 
> I just wonder what I am missing from all this story.
> Your help is greatly appreciated.
> 

Hi Michael,

I can't really comment on self hosted debugging with a native compiled
gdb. However I have been working on host target debugging with the
kernel gdbstub and gdbserver. As you're not interested in kernel
debugging I won't say any more about the kernel stub.

The (host side) gdb I've been using was configured with ./configure
--target=mipsel-linux-elf (my target is an IDT MIPS 79S334 evaluation
board). I too am using an x86 host. I used a development version of
gdb-5.0 (I found the 'official' 5.0 had problems with the
add-symbol-file command that I use for kernel module debugging, and more
importantly for you... breakpoints didn't work) These problems are gone
in the later version.

Yesterday I got gdbserver working correctly on my target (over IP or
serial). It's a combination of Martin Rivers' mips port and my 'fixes'.
At this stage the build is hand cranked and neither of us have put it
under the control of the gdb configuration files. However, we (lineo)
will now start doing this.

I hope this helps in some way. Please let me know if there is anything I
can help with. It might also be worth contacting Fabrice, as it sounds
like he has a working gdb and gdbserver.

Best regards,
Ian
