Received:  by oss.sgi.com id <S42222AbQGKW2E>;
	Tue, 11 Jul 2000 15:28:04 -0700
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:167 "EHLO
        styx.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S42205AbQGKW1q>; Tue, 11 Jul 2000 15:27:46 -0700
Received: from cassiopeia.home (root@dialup005.cs.kuleuven.ac.be [134.58.47.134])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id e6BCneA12233;
	Tue, 11 Jul 2000 14:49:40 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id OAA00581;
	Tue, 11 Jul 2000 14:35:00 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Tue, 11 Jul 2000 14:34:59 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     nick@ns.snowman.net
cc:     Jason Mesker <jasonm@tool.net>, Ralf Baechle <ralf@uni-koblenz.de>,
        "debian-mips@lists.debian.org" <debian-mips@lists.debian.org>,
        "linux-mips@fnet.fr" <linux-mips@fnet.fr>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>,
        "linux-mips@vger.rutgers.edu" <linux-mips@vger.rutgers.edu>
Subject: Re: R5000 oops
In-Reply-To: <Pine.LNX.4.05.10007101751540.23559-100000@ns.snowman.net>
Message-ID: <Pine.LNX.4.10.10007111434310.426-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 10 Jul 2000 nick@ns.snowman.net wrote:
> I have a R5k indy with 128meg and 2x2gig disks that I can test on.  It's
> currently running irix, but i've been meaning to install linux on it.  If
> one of you can tell me what I should test/test for I'd be willing to try.

Just stress test the box and you'll see.

> On Mon, 10 Jul 2000, Geert Uytterhoeven wrote:
> > On Mon, 10 Jul 2000, Jason Mesker wrote:
> > > I am running kernel version: 2.4.0 test 3 pre 2.  I am useing wesolows vmlinux-0704b kernel.
> > > 
> > > I think I have found the problem though.  I was running the system without swap and with 64Megs of RAM.  I added around 20 megs of swap space and did the
> > > configure again and it worked fine.  I am actually compiling now and will let the status be known if it completes or not.  As of right now everything looks
> > > like it is working fine with the swap enabled.
> > 
> > I suspect that's not the problem, though. 64 MB of RAM should not be exhausted
> > that fast.
> > 
> > I saw lots of similar oopses on the NEC DDB Vrc-5074 with various 2.3.x
> > kernels. Other people reported similar oopses with other machines. And the
> > common factor is the R5000.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
