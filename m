Received:  by oss.sgi.com id <S42185AbQGJUob>;
	Mon, 10 Jul 2000 13:44:31 -0700
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:44182 "EHLO
        styx.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S42188AbQGJUoQ>; Mon, 10 Jul 2000 13:44:16 -0700
Received: from cassiopeia.home (root@dialup006.cs.kuleuven.ac.be [134.58.47.135])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id e6AKhrA08806;
	Mon, 10 Jul 2000 22:43:54 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id NAA00567;
	Mon, 10 Jul 2000 13:46:17 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Mon, 10 Jul 2000 13:46:17 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jason Mesker <jasonm@tool.net>
cc:     Ralf Baechle <ralf@uni-koblenz.de>,
        "debian-mips@lists.debian.org" <debian-mips@lists.debian.org>,
        "linux-mips@fnet.fr" <linux-mips@fnet.fr>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>,
        "linux-mips@vger.rutgers.edu" <linux-mips@vger.rutgers.edu>
Subject: Re: R5000 oops
In-Reply-To: <396978F7.A309E715@tool.net>
Message-ID: <Pine.LNX.4.10.10007101343480.441-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 10 Jul 2000, Jason Mesker wrote:
> I am running kernel version: 2.4.0 test 3 pre 2.  I am useing wesolows vmlinux-0704b kernel.
> 
> I think I have found the problem though.  I was running the system without swap and with 64Megs of RAM.  I added around 20 megs of swap space and did the
> configure again and it worked fine.  I am actually compiling now and will let the status be known if it completes or not.  As of right now everything looks
> like it is working fine with the swap enabled.

I suspect that's not the problem, though. 64 MB of RAM should not be exhausted
that fast.

I saw lots of similar oopses on the NEC DDB Vrc-5074 with various 2.3.x
kernels. Other people reported similar oopses with other machines. And the
common factor is the R5000.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
