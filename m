Received:  by oss.sgi.com id <S42425AbQJAK1q>;
	Sun, 1 Oct 2000 03:27:46 -0700
Received: from u-196.karlsruhe.ipdial.viaginterkom.de ([62.180.19.196]:38924
        "EHLO u-196.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42232AbQJAK1d>; Sun, 1 Oct 2000 03:27:33 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869606AbQJAK1K>;
        Sun, 1 Oct 2000 12:27:10 +0200
Date:   Sun, 1 Oct 2000 12:27:10 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Florian Lohoff <flo@rfc822.org>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20001001122710.A12972@bacchus.dhis.org>
References: <20000929220103.A396@paradigm.rfc822.org> <Pine.LNX.4.10.10010011140080.377-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10010011140080.377-100000@cassiopeia.home>; from geert@linux-m68k.org on Sun, Oct 01, 2000 at 11:40:41AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Oct 01, 2000 at 11:40:41AM +0200, Geert Uytterhoeven wrote:

> On Fri, 29 Sep 2000, Florian Lohoff wrote:
> > tty00 at 0xbf900001 (irq = 4) is a Z85C30 SCC
> > tty01 at 0xbf900009 (irq = 4) is a Z85C30 SCC
> > tty02 at 0xbf980001 (irq = 4) is a Z85C30 SCC
> > tty03 at 0xbf980009 (irq = 4) is a Z85C30 SCC
> 
> Shouldn't these be reported as ttyS0[0-3]?

Search for tty% in the serial drivers - it's actually a widespread mistake ...

  Ralf
