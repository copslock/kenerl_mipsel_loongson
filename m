Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 17:56:04 +0100 (BST)
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:44440 "EHLO
	hoboe1bl1.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20021607AbXJJQzz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 17:55:55 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe1bl1.telenet-ops.be (Postfix) with SMTP id 7331AD401B;
	Wed, 10 Oct 2007 18:55:54 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe1bl1.telenet-ops.be (Postfix) with ESMTP id 34AE8D402B;
	Wed, 10 Oct 2007 18:55:52 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9AGtn8I024229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Oct 2007 18:55:50 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9AGtkIh024216;
	Wed, 10 Oct 2007 18:55:46 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 10 Oct 2007 18:55:45 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Franck Bui-Huu <fbuihuu@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] tlbex.c: Remove relocs[] and labels[] from the
 init.data section
In-Reply-To: <20071010164236.GB10243@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0710101854260.23818@anakin>
References: <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org>
 <470BE58A.9070709@gmail.com> <470BE61F.5020108@gmail.com>
 <20071010142755.GA9325@linux-mips.org> <Pine.LNX.4.64N.0710101715380.9821@blysk.ds.pg.gda.pl>
 <20071010164236.GB10243@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 10 Oct 2007, Ralf Baechle wrote:
> On Wed, Oct 10, 2007 at 05:17:24PM +0100, Maciej W. Rozycki wrote:
> > > > It increases the stack pressure a lot (more than 2500 bytes) but
> > > > at this stage in the boot process, it shouldn't matter.
> > > 
> > > Even more for 64-bit kernel - and I would really like to keep reduce
> > > the kernel stack for 64-bit kernels, THREAD_SIZE_ORDER 2 is already
> > > slightly painful when memory becomes fragmented.
> > 
> >  I think the right fix is to implement "__initbss" along the lines of 
> > "__initdata".

Or e.g. static struct label labels[128] __initdata = { 0, };
Cfr. the old rule `always initialize initdata, even if it must be 0'.

> Indeed.  Doesn't even look so hard and would likely generally be welcome.

That's a valid alternative, of course...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
