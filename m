Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PB9Kh28914
	for linux-mips-outgoing; Wed, 25 Apr 2001 04:09:20 -0700
Received: from colo.asti-usa.com (IDENT:root@colo.asti-usa.com [205.252.89.99])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3PB9JM28911
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 04:09:19 -0700
Received: from lineo.com (hal.uk.zentropix.com [212.74.13.151])
	by colo.asti-usa.com (8.9.3/8.9.3) with ESMTP id HAA07438;
	Wed, 25 Apr 2001 07:17:50 -0400
Message-ID: <3AE6B14F.B5844932@lineo.com>
Date: Wed, 25 Apr 2001 12:13:19 +0100
From: Ian Soanes <ians@lineo.com>
Organization: Lineo UK
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Shmulevich <michaels@jungo.com>
CC: Linux/MIPS <linux-mips@oss.sgi.com>
Subject: Re: usermode gdb / remote gdb
References: <3AE67CBA.4060606@jungo.com> <3AE69AAA.76A20F08@lineo.com> <3AE6A795.1080004@jungo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Michael Shmulevich wrote:
> 
> Ian Soanes wrote:
> 
> > The (host side) gdb I've been using was configured with ./configure
> > --target=mipsel-linux-elf (my target is an IDT MIPS 79S334 evaluation
> > board). I too am using an x86 host. I used a development version of
> > gdb-5.0 (I found the 'official' 5.0 had problems with the
> > add-symbol-file command that I use for kernel module debugging, and more
> > importantly for you... breakpoints didn't work) These problems are gone
> > in the later version.
> 
> To start with, mips-linux-elf is not supported by gdbserver either with
> out-of-the-box 5.0:
> 

Hi Michael,

No, I meant configuring the 'cross-debugging' gdb that I use on the x86
host. I think standard 5.0 will support the mipsel-linux-elf target also
(but something later is better). As for gdbserver... yes, you'll be out
of luck... that's why I have to hand build (cross compile) it (pending
getting the config stuff sorted out).

> $ ../../configure --target=mips-linux-elf --host=mips-linux-elf
> *** ./configure.in has no "per-host:" line.
> *** Hmm, looks like this directory has been autoconfiscated.
> *** Running the local configure script.
> loading cache config.cache
> checking host system type... mips-linux-elf
> checking target system type... mips-linux-elf
> checking build system type... mips-linux-elf
> checking for a BSD compatible install... (cached) /usr/bin/install -c
> configure: error: *** GDB remote does not support host mips-linux-elf
> 
> Can you tell me which sources do you use?

It's actually a tar bundle that we include on one of our CDs. I think
it's a gdb snapshot dating from around August or September last year.
I'll see if I can dig out some more info and let you know. Or you could
try the latest snapshots, I haven't tried them, but they're probably OK.

> 
> > Yesterday I got gdbserver working correctly on my target (over IP or
> > serial). It's a combination of Martin Rivers' mips port and my 'fixes'.
> > At this stage the build is hand cranked and neither of us have put it
> > under the control of the gdb configuration files. However, we (lineo)
> > will now start doing this.
> 
> Happy to hear that  you got working GDB. I hope to make one too. For
> this I need to know where to get the MIPS port and your patches.
> Can you send them to me?
>

Sure, just give me a bit of time to get something together... it's a bit
rough round the edges at the moment :)
 
> > I hope this helps in some way. Please let me know if there is anything I
> > can help with. It might also be worth contacting Fabrice, as it sounds
> > like he has a working gdb and gdbserver.
> 
> These are indeed good news.
> 

Best regards,
Ian
