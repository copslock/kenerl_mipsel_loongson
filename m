Received:  by oss.sgi.com id <S305155AbQAOA40>;
	Fri, 14 Jan 2000 16:56:26 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:6257 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305165AbQAOA4R>;
	Fri, 14 Jan 2000 16:56:17 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA12008; Fri, 14 Jan 2000 16:53:25 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA89510
	for linux-list;
	Fri, 14 Jan 2000 16:43:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA77245
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Jan 2000 16:42:57 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04699
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 16:42:55 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA21174;
	Sat, 15 Jan 2000 01:41:48 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407893AbQANLcc>;
	Fri, 14 Jan 2000 12:32:32 +0100
Date:   Fri, 14 Jan 2000 12:32:32 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/MIPS <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel sources?
Message-ID: <20000114123232.C4278@uni-koblenz.de>
References: <Pine.LNX.4.05.10001130944010.3492-100000@callisto.of.borg> <Pine.LNX.4.05.10001131652390.3492-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.05.10001131652390.3492-100000@callisto.of.borg>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Jan 13, 2000 at 05:03:39PM +0100, Geert Uytterhoeven wrote:

> I used the R5000 CP0_COUNTER/CP0_COMPARE registers for the timer interrupt. I
> know it's not accurate, but it's better than nothing. I still have to figure
> out how more complex interrupts work in the MIPS source tree.

It is accurate as driven by the CPU's clock.  It is just somewhat tricky to
handle and even more tricky on some broken CPUs.  From an old email written
by Bill Earl:

[...]
As far as I know, all R4000 processors, and possibly some R4400 processors,
are affected.  The bug is that, if you read $count exactly when it equals
$compare, the count/compare interrupt for that count/compare crossing is
discarded.  The workaround from IRIX is appended.  The variable
r4000_clock_war is set to 1 if the system is an Indy with an R4000 processor.
The r4k_compare_shadow is set to the same value as $compare whenever $compare
is updated (with interrupts masked while the variable and $compare are
updated together).
[...]

Just calibrating the internal timer's value 100% exact is somewhat tricky.
The code used by the Indy generates a value that is somewhat off the
theoretical value.  In practice I think it may be a good idea to meassure
the clock rate, the round it to the nearest frequency that is known to
be used with that system.  Like rounding meassured 151MHz to 150MHz.

As for the time sources I think you best use a two-timer based scheme as
Intel or the Cobalt Qube 1/2.  That will give you the low overhead of the
internal timer combined with the (hopefully!) higher precission of the
external timer.

> Now we just have to do interrupts and PCI probing, and we're finished :-)
> 
> The board has the 16 standard i8259 interrupts, and 15 additional interrupts
> on the host bridge. The i8259 is cascaded through one interrupt of the host
> bridge, similar to the cascading through the OpenPIC on my CHRP board.
> PCI is not connected to the i8259, but to the host bridge.
> 
> I can program the host bridge to map any interrupt to any of the CPU
> interrupts (#0-#5 or NMI). I think the simplest way is to route them all
> through #0. Or do you think it's better not to do that, and e.g. route the
> timer interrupt (after I moved it from CP0_COUNTER/CP0_COMPARE to the PC
> style timer) to a different interrupt? Instead of the PC style timer, I
> could also use the general purpose timer in the host bridge.

What you want to do is to optimize the whole thing for the least interrupt
overhead.  An uncached read from the bridge chip is probably reasonably fast
but polling c0_cause is faster.  Given that the best thing to do will depend
on how many interrupts from what device you expect.  In any case you should
consider that the i8259 is supposed to be slow even though I guess that's no
longer correct for modern implementations.  Also the timer interrupt will
have to be the highest priority interrupt or you may deadlock, so your
arrangements should to ensure that this will be easy.

  Ralf
