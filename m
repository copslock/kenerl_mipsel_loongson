Received:  by oss.sgi.com id <S305156AbQAMQOY>;
	Thu, 13 Jan 2000 08:14:24 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:13601 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbQAMQOF>;
	Thu, 13 Jan 2000 08:14:05 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA04916; Thu, 13 Jan 2000 08:14:04 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA20669
	for linux-list;
	Thu, 13 Jan 2000 08:04:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA82923
	for <linux@engr.sgi.com>;
	Thu, 13 Jan 2000 08:03:59 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from aeon.tvd.be (aeon.tvd.be [195.162.196.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA05317
	for <linux@engr.sgi.com>; Thu, 13 Jan 2000 08:03:43 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from callisto.of.borg (cable-195-162-216-83.customer.chello.be [195.162.216.83])
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id RAA13592
	for <linux@engr.sgi.com>; Thu, 13 Jan 2000 17:03:40 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian/GNU) with ESMTP id RAA05091
	for <linux@engr.sgi.com>; Thu, 13 Jan 2000 17:03:39 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Thu, 13 Jan 2000 17:03:39 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linux/MIPS <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel sources?
In-Reply-To: <Pine.LNX.4.05.10001130944010.3492-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10001131652390.3492-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

	Hi,

As Ralf pointed out, my ELF loader problems were caused by the `-N' linker
option, triggering a bug in binutils 2.8.1.

FYI, I get until `Kernel panic: VFS: Unable to mount root fs' now.

I used the R5000 CP0_COUNTER/CP0_COMPARE registers for the timer interrupt. I
know it's not accurate, but it's better than nothing. I still have to figure
out how more complex interrupts work in the MIPS source tree.

Now we just have to do interrupts and PCI probing, and we're finished :-)

The board has the 16 standard i8259 interrupts, and 15 additional interrupts on
the host bridge. The i8259 is cascaded through one interrupt of the host
bridge, similar to the cascading through the OpenPIC on my CHRP board.
PCI is not connected to the i8259, but to the host bridge.

I can program the host bridge to map any interrupt to any of the CPU interrupts
(#0-#5 or NMI). I think the simplest way is to route them all through #0. Or do
you think it's better not to do that, and e.g. route the timer interrupt (after
I moved it from CP0_COUNTER/CP0_COMPARE to the PC style timer) to a different
interrupt? Instead of the PC style timer, I could also use the general purpose
timer in the host bridge.

Thx!

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
