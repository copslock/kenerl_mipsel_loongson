Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8F6Ivt12764
	for linux-mips-outgoing; Fri, 14 Sep 2001 23:18:57 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8F6Ire12761
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 23:18:53 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8F6Iq914048
	for linux-mips@oss.sgi.com; Sat, 15 Sep 2001 02:18:52 -0400
Date: Sat, 15 Sep 2001 02:18:52 -0400
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: No low memory for PCMCIA?
Message-ID: <20010915021852.A14022@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm (still) working on getting Linux running on my Mobilon Tripad (aka
Vadem Clio).  I'm running linux-vr hacked up to 2.4.5-ish, and I'm
currently trying to get PCMCIA working (built into the kernel; not a
module, since I need to access the compactflash card as root and
building pcmcia as a module turns off both PCMCIA ports at boot time).

My current problem: it sees the controller (VG-469), sees the card,
finds an IO port.. but can't map it anywhere.  The PCMCIA is basically
on an ISA bus, so I believe the card needs to be mapped to low memory
(under a meg), but the system memory takes up the first 16 megs,
leaving none:

> -more /proc/iomem
<< /proc/iomem >>
00000000-00ffffff : System RAM
  00100000-0023de17 : Kernel code
  0024f280-00260fff : Kernel data

(I had moved the kernel's starting address for this kernel; the
default for my platform is start the kernel at 00002000)

On x86, this problem doesn't exist because there's a hole in the
system memory map between 640k and 1MB, so the PCMCIA driver would
probe and find something like 0c0000-0cffff or 0d0000-0dffff to be
clean, whereas those segments are quite unavailable on the Clio.

One possible (untested) solution would be to simply remove a section
of RAM from the memory map, which would effectively duplicate the x86
memory hole and allow the card to be mapped there.  Would this work?
It seems a bit strange that I would have to give up some physical
memory for PCMCIA.

Oh, and if I modify the PCMCIA driver so it probes memory above 16M,
it succeeds and marks them as clean, but the card refuses to map to
anything over a meg; again, probably because it's ISA and ISA is
limited to that.

thanks in advance,
-jim
