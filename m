Received:  by oss.sgi.com id <S553924AbQLQOgl>;
	Sun, 17 Dec 2000 06:36:41 -0800
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:50915 "EHLO
        styx.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S553921AbQLQOgb>; Sun, 17 Dec 2000 06:36:31 -0800
Received: from cassiopeia.home (root@dialup004.cs.kuleuven.ac.be [134.58.47.133])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id eBHEaHe29997;
	Sun, 17 Dec 2000 15:36:17 +0100 (MET)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id NAA00910;
	Sun, 17 Dec 2000 13:51:19 +0100
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Sun, 17 Dec 2000 13:51:17 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Nicu Popovici <octavp@isratech.ro>, linux-mips@oss.sgi.com
Subject: Re: Little endian.
In-Reply-To: <20001216124539.A6896@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.10.10012171349500.682-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 16 Dec 2000, Ralf Baechle wrote:
> On Fri, Dec 15, 2000 at 07:28:15PM +0100, Kevin D. Kissell wrote:
> > If you want to run little-endian, you need to install
> > the little-endian binaries and libraries.  Since I needed
> > to "swing both ways", I put both a big-endian root and
> > a little-endian root partition on my Atlas disk, with user/data 
> > partitions that can be mounted on either one - fortunately, 
> > the Ext2FS metadata seems to be consistent regardless 
> > of endianness.
> 
> Ext2fs on-disk data structures are defined to be little endian.  Some very
> old ext2 filesystems which afaik where all created on Linux/M68K were big
> endian; for those e2fsck has the option to change the endianess of the
> filesystem during a fsck run; the current kernel will refuse to accept
> such big endian ext2 filesystems.

For correctness: early Linux/PPC used big-endian ext2 as well. IIRC we switched
to little-endian ext2 on m68k in late 1996, and on PPC in late 1997 / early
1998.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
