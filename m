Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f853sEK11929
	for linux-mips-outgoing; Tue, 4 Sep 2001 20:54:14 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f853sBd11925
	for <linux-mips@oss.sgi.com>; Tue, 4 Sep 2001 20:54:11 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f853sA510371
	for linux-mips@oss.sgi.com; Tue, 4 Sep 2001 23:54:10 -0400
Date: Tue, 4 Sep 2001 23:54:10 -0400
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: segfault
Message-ID: <20010904235410.A8310@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm trying to get Linux working on my handheld PC (the Sharp Tripad,
very similar to the Vadem Clio), but I'm having userland problems.  

Some binaries compile and run fine, while others give a segfault right
away.  Compiling with slightly different versions of compilers, glibc,
etc, seems to affect which binaries work and which don't, although I
can't find a combination that seems to work with everything.
Fortunately, one binary that does appear to work fine is 'sash', which
lets me test this stuff.

I uncommented some debugging stuff in the kernel, and the actual error
is:

do_page_fault( )#2: sending SIGSEGV to test-prog for illegal write
access to 00000fd4 (epc == 004027b8, ra == 00402730)

The strange part about this (and the reason why I suspect someone may
be able to help me) is that the address 00000fd4 is always the same,
implying that the binaries are all failing in the same way.  Has
anyone seen this or does anyone have any ideas why this may be
happening?

My original setup was a pre-3.0 CVS GCC and glibc-2.2.3 with the
Linux-VR kernel (based on the MIPS tree as of 2.4.0-test9), but I've
since brought the Linux-VR tree up to 2.4.5 and moved to gcc-3.0.1 and
glibc-2.2.4 with binutils-2.11.90.0.31, and none of this really seems
to help the problem much.

-jim
