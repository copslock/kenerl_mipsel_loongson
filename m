Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jun 2004 17:19:33 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:10701 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225479AbUFVQT1>;
	Tue, 22 Jun 2004 17:19:27 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i5MGJNXK005806;
	Tue, 22 Jun 2004 18:19:23 +0200 (MEST)
Date: Tue, 22 Jun 2004 18:19:23 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] vr41xx: remove Eagle support
In-Reply-To: <20040623010534.23c7ab45.yuasa@hh.iij4u.or.jp>
Message-ID: <Pine.GSO.4.58.0406221818340.29076@waterleaf.sonytel.be>
References: <20040622013322.0273fadb.yuasa@hh.iij4u.or.jp>
 <20040622153252.GA6504@linux-mips.org> <20040623010534.23c7ab45.yuasa@hh.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 23 Jun 2004, Yoichi Yuasa wrote:
> On Tue, 22 Jun 2004 17:32:52 +0200
> Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Tue, Jun 22, 2004 at 01:33:22AM +0900, Yoichi Yuasa wrote:
> > > NEC Eagle is obsolete hardware.
> > > We have Victor MP-C30x as similar hardware,
> > > I'm going to continue support of Victor MP-C30x and I decided to drop NEC Eagle.
> > >
> > > Please apply this patch to v2.6 CVS tree.
> >
> > Nobody who wants to raise a veto and take over maintenance?
>
> As far as I know, NEC Eagle was sold only in Japan.

Which doesn't mean all boards are currently located in Japan... (Yes, we have
one at work in Brussels ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
