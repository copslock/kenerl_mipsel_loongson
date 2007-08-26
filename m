Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Aug 2007 12:06:46 +0100 (BST)
Received: from asia.telenet-ops.be ([195.130.137.74]:63137 "EHLO
	asia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20026238AbXHZLGh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Aug 2007 12:06:37 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by asia.telenet-ops.be (Postfix) with SMTP id 51228D418A;
	Sun, 26 Aug 2007 13:06:37 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by asia.telenet-ops.be (Postfix) with ESMTP id DFCA0D41A2;
	Sun, 26 Aug 2007 13:06:35 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-8) with ESMTP id l7QB6ZWA014831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 26 Aug 2007 13:06:35 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l7QB6VWK014828;
	Sun, 26 Aug 2007 13:06:31 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sun, 26 Aug 2007 13:06:31 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Mike Frysinger <vapier.adi@gmail.com>
Cc:	Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
	blinux-list@redhat.com, cluster-devel@redhat.com,
	discuss@x86-64.org, jffs-dev@axis.com, linux-acpi@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
	linux-mm@kvack.org, linux-mtd@lists.infradead.org,
	linux-scsi@vger.kernel.org, mpt_linux_developer@lsi.com,
	netdev@vger.kernel.org, osst-users@lists.sourceforge.net,
	parisc-linux@parisc-linux.org, tpmdd-devel@lists.sourceforge.net,
	uclinux-dist-devel@blackfin.uclinux.org
Subject: Re: [PATCH] Prefix each line of multiline printk(KERN_<level>
 "foo\nbar") with KERN_<level>
In-Reply-To: <8bd0f97a0708260354xb4c8546od0cc19a590820f32@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0708261305020.31149@anakin>
References: <1187999098.32738.179.camel@localhost> <Pine.LNX.4.64.0708261028120.31149@anakin>
 <8bd0f97a0708260354xb4c8546od0cc19a590820f32@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 26 Aug 2007, Mike Frysinger wrote:
> On 8/26/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, 24 Aug 2007, Joe Perches wrote:
> > > Corrected printk calls with multiple output lines which
> > > did not correctly preface each line with KERN_<level>
> > >
> > > Fixed uses of some single lines with too many KERN_<level>
> >
> > > --- a/arch/arm/kernel/ecard.c
> > > +++ b/arch/arm/kernel/ecard.c
> > > @@ -547,7 +547,8 @@ static void ecard_check_lockup(struct irq_desc *desc)
> > >       if (last == jiffies) {
> > >               lockup += 1;
> > >               if (lockup > 1000000) {
> > > -                     printk(KERN_ERR "\nInterrupt lockup detected - "
> > > +                     printk(KERN_ERR "\n"
> > > +                            KERN_ERR "Interrupt lockup detected - "
> > >                              "disabling all expansion card interrupts\n");
> > >
> > >                       desc->chip->mask(IRQ_EXPANSIONCARD);
> >
> > What's the purpose of having lines printed with e.g. `KERN_ERR "\n"' only?
> > Shouldn't these just be removed?
> >
> > Usually lines starting with `\n' are continuations, but given some other
> > module may call printk() in between, there's no guarantee continuations
> > appear on the same line.
> 
> erm, i thought the prink lock was grabbed per-buffer, not per-line ...
> so yes, if the function calls were like printk(KERN_ERR "\n");
> printk(KERN_ERR "..."); things could be broken up, but this is on
> function call, so it shouldnt ...

Yes it is.

What I mean is that probably there used to be a printk() call starting with
`\n'. Then someone added a `KERN_ERR' in front of it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
