Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CDGsRw025246
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 06:16:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CDGsiI025245
	for linux-mips-outgoing; Fri, 12 Jul 2002 06:16:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CDGhRw025234;
	Fri, 12 Jul 2002 06:16:46 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 17T03Y-0002tg-00; Fri, 12 Jul 2002 14:01:56 +0100
Subject: Re: Sigcontext->sc_pc Passed to User
To: ralf@oss.sgi.com (Ralf Baechle)
Date: Fri, 12 Jul 2002 14:01:56 +0100 (BST)
Cc: kevink@mips.com (Kevin D. Kissell), linux-mips@oss.sgi.com
In-Reply-To: <20020712120024.A20727@dea.linux-mips.net> from "Ralf Baechle" at Jul 12, 2002 12:00:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T03Y-0002tg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Non-overcommit means large amounts of memory are required when forking
> of a new process.  The standard example is a fat bloated Mozilla forking
> for printing.  Non-overcommit means you need those 50 or 100 megs of
> Mozilla process size once more and if not as physical memory then at
> least as swap space.  Deciede yourself if you're paranoid and want that
> operation to only succeed if that much memory is actually available or
> if you take the risk of the fork & exec operation failing the other way.

Your numbers are ridiculously off.

A mozilla instance on x86 commits 17Mb of potentially swap backed memory
when viewing the mozilla 1.0 start page. (Its actually a bit less but there
is delay in the garbage collector)

2.4.18/19-ac support non overcommit, and its rather useful

Alan
