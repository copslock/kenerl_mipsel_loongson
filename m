Received:  by oss.sgi.com id <S553743AbQJQNae>;
	Tue, 17 Oct 2000 06:30:34 -0700
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:9161 "EHLO
        styx.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S553709AbQJQNaQ>; Tue, 17 Oct 2000 06:30:16 -0700
Received: from cassiopeia.home (root@dialup005.cs.kuleuven.ac.be [134.58.47.134])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id e9HDU3n23665;
	Tue, 17 Oct 2000 15:30:03 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id NAA00702;
	Tue, 17 Oct 2000 13:20:04 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Tue, 17 Oct 2000 13:20:04 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc:     linux-mips@oss.sgi.com
Subject: Re: base.tgz
In-Reply-To: <20001017041449.A17546@lug-owl.de>
Message-ID: <Pine.LNX.4.10.10010171318580.394-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 17 Oct 2000, Jan-Benedict Glaw wrote:
> On Mon, Oct 16, 2000 at 04:33:47AM +0200, Jan-Benedict Glaw wrote:
> > My next goal is to cleanly build something like base.tgz. Maybe
> > we can get a smooth debian installation in some days;)
> 
> Okay, I took the package list off potato's base.tgz. Please comment
> on the missing packets or which files to take instead. Please also
> have a look at the perl packages...
> 
> Packages which seem to be not used/useable. They'll not be included:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Package: pciutils
  ^^^^^^^^^^^^^^^^^
I prefer to have pciutils. It's very handy for debugging PCI problems.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
