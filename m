Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f38MX4o20722
	for linux-mips-outgoing; Sun, 8 Apr 2001 15:33:04 -0700
Received: from feynman.localnet (jtobey.ne.mediaone.net [24.147.19.222])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f38MX3M20719
	for <linux-mips@oss.sgi.com>; Sun, 8 Apr 2001 15:33:03 -0700
Received: by ne.mediaone.net
	via sendmail from stdin
	id <m14mNtJ-000FQ5C@feynman.localnet> (Debian Smail3.2.0.102)
	for linux-mips@oss.sgi.com; Sun, 8 Apr 2001 18:42:41 -0400 (EDT) 
Date: Sun, 8 Apr 2001 18:42:41 -0400
From: John Tobey <jtobey@john-edwin-tobey.org>
To: linux-mips@oss.sgi.com
Subject: 64-bit on Cobalt?
Message-ID: <20010408184241.A3443@john-edwin-tobey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi folks,

I keep having this fantasy that I will one day make my old Cobalt RaQ
run a Debian system including 64-bit apps.  I've got a copy of _See
MIPS Run_ (wonderful book) and a working system based on Cobalt's
hacked-up kernel 2.0.34 and Red Hat 5.x.  I am comfortable using
cross-gcc and messing with glibc.

It seems that I have all the information required to do it all myself,
but perhaps I might save a few years of work (or rid myself of this
delusion) by consulting with you all first.

The CPU is a QED RM5231 (CONFIG_NEVADA) 150MHz.  May I assume that
nobody has run a 64-bit kernel on this thing?  The RaQ has no video
card but a serial console, PCI, IDE, Ethernet, and special LEDs, panel
buttons, and LCD display.  If I can get a 64-bit kernel to boot and
prove its existence through any of these devices, I will be drunk with
power.

The reason I want 64 bits is that I (a) want a challenge, (b) plan to
write an application that uses a sparse address space (40 bits is
better than 31), (c) plan to outlive the 31-bit time_t, and (d) am
p.o.ed at having bought the thing based on misleading advertising that
mentioned a 64-bit processor but not the 32-bit OS.

Big/little endian macht nichts.  I guess big will be easier, and I'm
not concerned with running any existing 32-bit binaries.

I imagine that I would start by grafting Cobalt's peripheral support
code from arch/mips/cobalt (now defunct) and include/asm-mips/cobalt.h
into the mips64 tree from cvs@oss.sgi.com:/cvs/linux.

I will appreciate your advice.

-John

-- 
John Tobey, late nite hacker <jtobey@john-edwin-tobey.org>
\\\                                                               ///
]]]             With enough bugs, all eyes are shallow.           [[[
///                                                               \\\
