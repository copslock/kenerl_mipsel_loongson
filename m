Received:  by oss.sgi.com id <S554092AbRA1S4b>;
	Sun, 28 Jan 2001 10:56:31 -0800
Received: from hermes.cs.kuleuven.ac.be ([134.58.40.3]:26566 "EHLO
        hermes.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S554078AbRA1S4H>; Sun, 28 Jan 2001 10:56:07 -0800
Received: from cassiopeia.home (root@dialup001.cs.kuleuven.ac.be [134.58.47.130])
	by hermes.cs.kuleuven.ac.be (A_Good_MTA/8.11.1) with ESMTP id f0SIu3r00988;
	Sun, 28 Jan 2001 19:56:03 +0100 (MET)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id TAA01170;
	Sun, 28 Jan 2001 19:27:40 +0100
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Sun, 28 Jan 2001 19:27:40 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Pete Popov <ppopov@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
In-Reply-To: <20010126212341.A26384@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.10.10101281921160.1105-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 26 Jan 2001, Florian Lohoff wrote:
> On Fri, Jan 26, 2001 at 10:37:03AM -0800, Pete Popov wrote:
> > glibc.  Others might have similar toolchains they can point you at. 
> > Another option is native builds, which I personally don't like.
> 
> Cross compiling is definitly no option for debian as the dependencies
> etc are all made from "ldd binary" which has to fail for cross-compiling.
> I guess this also happens to rpm packages so cross-compiling to really
> get a correct distribution is definitly no option.

    [...]

> I definitly go for native builds - Once you have a working stable 
> base you can set up debian autobuilders which will do nearly 
> everything for you except signing and uploading the package into
> the main repository.

I really like what they did for ia64 (cfr. the Linux Kongress talk in 1999):
they are running an (emulated) ia64 chrooted environment on an ia32 box.
Binaries in the chrooted environment can be both native (ia32, fast) or
non-native (ia64, emulated and slower). May help for autobuilders for `slow'
architectures (emulated m68k may be faster than the fastest existing '060) as
well...

Using such a technique would allow to let weird stuff like `ldd' and
intermediate created binaries work.

Gr{oetje,eeting}s,

						Geert

P.S. I also think Debian should provide cross-gccs and cross-binutils for all
     architectures it supports, so I don't have to build them myself. And if I
     then could install any lib*-dev*.deb for architecture <arch> into
     /usr/<arch>-linux/ I can cross-compile userspace as well...
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
