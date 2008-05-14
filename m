Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 08:34:04 +0100 (BST)
Received: from nelson.telenet-ops.be ([195.130.133.66]:57797 "EHLO
	nelson.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20026559AbYENHeB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 May 2008 08:34:01 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by nelson.telenet-ops.be (Postfix) with SMTP id B98875003D;
	Wed, 14 May 2008 09:33:59 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by nelson.telenet-ops.be (Postfix) with ESMTP id 93A885000A;
	Wed, 14 May 2008 09:33:59 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.2/8.14.2/Debian-4) with ESMTP id m4E7Xx1R011656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 May 2008 09:33:59 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.2/8.14.2/Submit) with ESMTP id m4E7XwXv011653;
	Wed, 14 May 2008 09:33:59 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 14 May 2008 09:33:58 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: is remap_pfn_range should align to 2(n) * (page size) ?
In-Reply-To: <50c9a2250805131819q41c6da0au1ae3ef9e833812a9@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0805140932410.5778@anakin>
References: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com>
 <20080509095605.GB14450@linux-mips.org> <50c9a2250805111918r16913139obfc2982220636b3@mail.gmail.com>
 <20080512112233.GA8843@linux-mips.org> <50c9a2250805130444u4218654bw66f6158ba10b2b92@mail.gmail.com>
 <20080513172300.GA9788@linux-mips.org> <50c9a2250805131819q41c6da0au1ae3ef9e833812a9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 May 2008, zhuzhenhua wrote:
> On Wed, May 14, 2008 at 1:23 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Tue, May 13, 2008 at 07:44:06PM +0800, zhuzhenhua wrote:
> > > thanks for your advice, i found in newest kernel version, in some arch ,
> > the
> > > dma_alloc_coherent will call split_page.
> > > because my kernel version is 2.6.14, so i first patch a split_page patch
> > as
> > > follow:
> > >
> > http://www.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/broken-out/mm-split-highorder.patch
> > >
> > > but it seemes that there is still no split_page in
> > > dma_alloc_coherent/dma_alloc_noncoherent
> > > so i copy from other arch code to arch/mips/mm/dma-noncoherent.c (attach
> > at
> > > the end of mail)
> > > and now my driver just use dma_alloc_coherent malloc 3M directly, and it
> > > seemes ok.
> > > i just wonder why mips arch dma_alloc_coherent/dma_alloc_nocoherent do
> > not
> > > call split_page while other arch calling.
> >
> > I have not identified the waste of memory as a big problem for typical
> > MIPS systems yet.
> >
> > The 3MB requirement of your device is sort of odd because it's not a power
> > of two.  Have you considered splitting the allocation into a 2MB and a 1MB
> > allocation or would that be undersirable?
> >
> 
> Thanks for your reply.
> Our board is for embedded system , It only have 32M sdram and we don't want
> to
>  waste 1M sdram.  My sensor driver need about 2.5xM memory to capture a
> picture
>  by DMA (our DMA controller do not support scatter/gather).
> 
> I also can use bootargs "mem=29M" to keep 3M sdram.  but it's not flexible
> as
> passing a param to driver module(calling dma_alloc_coherent). maybe my
> situation
> is not common for MIPS arch. so that's is no split_page in
> dma_alloc_coherent.
> and now after patch,it seemes ok for me.

One other issue is that bootargs "mem=29M" is guaranteed to give you 3
MiB for your device, while dma_alloc_coherent() may fail if memory is
too fragmented.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
