Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 21:38:33 +0100 (BST)
Received: from adicia.telenet-ops.be ([195.130.132.56]:13492 "EHLO
	adicia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20021765AbXEWUib (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 21:38:31 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id 7EEA62300C6;
	Wed, 23 May 2007 22:38:31 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 00604230109;
	Wed, 23 May 2007 22:38:27 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l4NKcRcf004287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 May 2007 22:38:27 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l4NKcLDH004174;
	Wed, 23 May 2007 22:38:21 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 23 May 2007 22:38:21 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Roman Zippel <zippel@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	akpm@osdl.org, rmk@arm.linux.kernel.org, spyro@f2s.com,
	starvik@axis.com, ysato@users.sourceforge.jp,
	"Luck, Tony" <tony.luck@intel.com>, takata@linux-m32r.org,
	chris@zankel.net, uclinux-v850@lsi.nec.co.jp,
	kyle@parisc-linux.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] m68k: Enable arbitary speed tty support
In-Reply-To: <20070523205645.07b03581@the-village.bc.nu>
Message-ID: <Pine.LNX.4.64.0705232233360.10610@anakin>
References: <20070523174446.37abfa7a@the-village.bc.nu>
 <Pine.LNX.4.64.0705232117260.10610@anakin> <20070523205645.07b03581@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 23 May 2007, Alan Cox wrote:
> > > +#define TCSETS2		_IOW('T',0x2B, struct termios2)
> > > +#define TCSETSW2	_IOW('T',0x2C, struct termios2)
> > > +#define TCSETSF2	_IOW('T',0x2D, struct termios2)
> > 
> > Where is `struct termios2' defined? Right now it doesn't compile because
> > of that.
> > 
> 
> Sorry, shortage of qualified gnomes: One of them forgot to post this diff first
> 
> Add the termios2 structure ready for enabling on most platforms. One or two like
> Sparc are plain weird so have been left alone. Most can use the same structure as
> ktermios for termios2 (ie the newer ioctl uses the structure matching the current
> kernel structure)

Why not `#define termios2 ktermios' (or vice versa) on platforms where
they are the same?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
