Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8H4JW025372
	for linux-mips-outgoing; Sun, 16 Sep 2001 21:19:32 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8H4JTe25369
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 21:19:29 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8H4JOH28680
	for linux-mips@oss.sgi.com; Mon, 17 Sep 2001 00:19:24 -0400
Date: Mon, 17 Sep 2001 00:19:22 -0400
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: pcmcia (again)
Message-ID: <20010917001922.A28670@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've learned a bit since my question regarding PCMCIA, and haven't
gotten any answers, so here's a possibly-easier-to-answer version.

My architecture has ISA memory mapped at some high address (via
isa_slot_offset).  Turns out this isn't special; most non-x86 targets
with ISA do it (PPC, MIPS).  So, the problem seems to boil down to the
fact that the kernel's PCMCIA drivers simply don't support this (as
they assume that ISA space is absolutely addressable).

Is this true, and if so, how do you guys get PCMCIA working on MIPS?
Has anyone done it?

-jim
