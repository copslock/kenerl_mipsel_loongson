Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8R2CU403348
	for linux-mips-outgoing; Wed, 26 Sep 2001 19:12:30 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8R2CRD03345
	for <linux-mips@oss.sgi.com>; Wed, 26 Sep 2001 19:12:27 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8R2CNj17748
	for linux-mips@oss.sgi.com; Wed, 26 Sep 2001 22:12:23 -0400
Date: Wed, 26 Sep 2001 22:12:23 -0400
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: test machines; illegal instructions
Message-ID: <20010926221223.A17628@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Anyone looking for test machines?  My dorm has three unused SGI
machines sitting in the basement, and I'd be willing to dump a kernel
on them and plug them into the network if anyone here is looking to do
some testing or whatnot.  I don't know much about SGIs, but here's
what they tell me (or what I can gleam from looking at them):

Crimson: IP17, R4000 50 MHz (R4010 FPU), 64MB RAM, GR2-Elan graphics, 
	 two 1.3 gig drives, one currently has Irix 4.0.5
Indigo2: Aqua, IP22, R4000 100 MHz, ~192MB RAM, some beefy graphics
	 card, no drive but I could spare at least a gig (or 60 over NFS)
Indigo2: Purple, IP22, R4400 250 MHz, 128MB RAM, High Impact graphics,
	 one 2 gig drive, CD-ROM, currently has Irix 6.2 or so

----

On an unrelated note, my Vadem Clio project is halted again, this time
with frequent SIGILLs.  In particular, GCC 3.0.1 (and latest CVS)
crashes (in cc1), and 'rm' crashes unless I disable the 'check for
infinite recursion' code.  (the problem also goes away if I add some
debugging printf()s, sometimes).  A cross-gdb on my PC doesn't seem to
like core files, and I haven't had much luck getting gdb to run
natively, so I'm running out of ideas for how to debug this.  Anyone
seen anything similar?  It's quite possibly a buggy cross compiler
just generating buggy binaries (GCC 3.0.1 on the PC, with glibc 2.2.4)
but I thought others were using this compiler just fine.

(Running a somewhat hacked 2.4.5-ish Linux-VR/Linux-MIPS kernel, with
sysmips patches as recommended by Maciej)

-jim
