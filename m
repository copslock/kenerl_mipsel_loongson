Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OEjLnC032048
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 07:45:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OEjLJ1032047
	for linux-mips-outgoing; Mon, 24 Jun 2002 07:45:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OEjDnC032044;
	Mon, 24 Jun 2002 07:45:14 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA01609;
	Mon, 24 Jun 2002 16:49:02 +0200 (MET DST)
Date: Mon, 24 Jun 2002 16:49:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: sys_syscall patch.
In-Reply-To: <20020624134549.B27807@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020624162311.22509M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 24 Jun 2002, Ralf Baechle wrote:

> It's in the kernel for no better reason than Risc/OS and IRIX having this
> syscall.  Also the glibc syscall implementation was historically broken
> wrt. syscall restarting and a few other subtilities.

 Well, userland implementations for other archs seem quite
straightforward.  So should be ours -- we only have to shuffle arguments
appropriately.  Restarting is easy -- we just have to make sure to reload
v0 just before "syscall" reliably (we can use a static register or an
automatic variable to preserve it).  What are the few other subtleties?

 Also I can't see an implementation of syscall() for MIPS/Linux anywhere
in glibc.  What implementation do you refer to?  The Mach one?

 The win is we don't have to mess with user accesses specially -- the
final syscall will handle them. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
