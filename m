Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CF8NRw031076
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 08:08:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CF8N9t031075
	for linux-mips-outgoing; Fri, 12 Jul 2002 08:08:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CF7vRw031066;
	Fri, 12 Jul 2002 08:08:14 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 17T2Sz-0003EN-00; Fri, 12 Jul 2002 16:36:21 +0100
Subject: Re: Sigcontext->sc_pc Passed to User
To: ralf@oss.sgi.com (Ralf Baechle)
Date: Fri, 12 Jul 2002 16:36:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kevink@mips.com (Kevin D. Kissell),
   linux-mips@oss.sgi.com
In-Reply-To: <20020712162322.A18691@dea.linux-mips.net> from "Ralf Baechle" at Jul 12, 2002 04:23:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T2Sz-0003EN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > A mozilla instance on x86 commits 17Mb of potentially swap backed memory
> > when viewing the mozilla 1.0 start page. (Its actually a bit less but there
> > is delay in the garbage collector)
> 
> These were typical numbers of the last Mozilla I hacked myself on MIPS.
> It can grow larger without doing alot.  Aside of that this isn't Mozilla
> specific; any arbitrary program that does some fork & exec thing and
> it's memory size could be choosen.

These are precise page accurate measurements from the real world. What most
people forget is that very little of an ELF application is actually swap
backed as opposed to file backed read only
