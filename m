Received:  by oss.sgi.com id <S42208AbQGJUtb>;
	Mon, 10 Jul 2000 13:49:31 -0700
Received: from ns.snowman.net ([63.80.4.34]:18707 "EHLO ns.snowman.net")
	by oss.sgi.com with ESMTP id <S42188AbQGJUtR>;
	Mon, 10 Jul 2000 13:49:17 -0700
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.1a/8.9.0) with ESMTP id RAA23762;
	Mon, 10 Jul 2000 17:52:58 -0400
Date:   Mon, 10 Jul 2000 17:52:57 -0400 (EDT)
From:   <nick@mail.snowman.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Jason Mesker <jasonm@tool.net>, Ralf Baechle <ralf@uni-koblenz.de>,
        "debian-mips@lists.debian.org" <debian-mips@lists.debian.org>,
        "linux-mips@fnet.fr" <linux-mips@fnet.fr>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>,
        "linux-mips@vger.rutgers.edu" <linux-mips@vger.rutgers.edu>
Subject: Re: R5000 oops
In-Reply-To: <Pine.LNX.4.10.10007101343480.441-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.05.10007101751540.23559-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have a R5k indy with 128meg and 2x2gig disks that I can test on.  It's
currently running irix, but i've been meaning to install linux on it.  If
one of you can tell me what I should test/test for I'd be willing to try.
	Nick

On Mon, 10 Jul 2000, Geert Uytterhoeven wrote:

> On Mon, 10 Jul 2000, Jason Mesker wrote:
> > I am running kernel version: 2.4.0 test 3 pre 2.  I am useing wesolows vmlinux-0704b kernel.
> > 
> > I think I have found the problem though.  I was running the system without swap and with 64Megs of RAM.  I added around 20 megs of swap space and did the
> > configure again and it worked fine.  I am actually compiling now and will let the status be known if it completes or not.  As of right now everything looks
> > like it is working fine with the swap enabled.
> 
> I suspect that's not the problem, though. 64 MB of RAM should not be exhausted
> that fast.
> 
> I saw lots of similar oopses on the NEC DDB Vrc-5074 with various 2.3.x
> kernels. Other people reported similar oopses with other machines. And the
> common factor is the R5000.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
