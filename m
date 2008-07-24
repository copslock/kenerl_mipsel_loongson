Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2008 19:49:32 +0100 (BST)
Received: from winston.telenet-ops.be ([195.130.137.75]:16066 "EHLO
	winston.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28594281AbYGXSta (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Jul 2008 19:49:30 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by winston.telenet-ops.be (Postfix) with SMTP id 62245A001D;
	Thu, 24 Jul 2008 20:49:29 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by winston.telenet-ops.be (Postfix) with ESMTP id 158B9A0037;
	Thu, 24 Jul 2008 20:49:28 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m6OInSbS001131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Jul 2008 20:49:28 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m6OInRcl001128;
	Thu, 24 Jul 2008 20:49:28 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Thu, 24 Jul 2008 20:49:27 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	linux-arch@vger.kernel.org
Subject: Re: [patch 29/29] initrd: Fix virtual/physical mix-up in overwrite
 test
In-Reply-To: <20080725.003526.39154055.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0807242032430.701@anakin>
References: <20080717191607.955742542@mail.of.borg> <20080717191758.556975996@mail.of.borg>
 <20080725.003526.39154055.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi Nemoto-san,

On Fri, 25 Jul 2008, Atsushi Nemoto wrote:
> On Thu, 17 Jul 2008 21:16:36 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >  	if (initrd_start && !initrd_below_start_ok &&
> > -			initrd_start < min_low_pfn << PAGE_SHIFT) {
> > +	    page_to_pfn(virt_to_page(initrd_start)) < min_low_pfn) {
> >  		printk(KERN_CRIT "initrd overwritten (0x%08lx < 0x%08lx) - "
> > -		    "disabling it.\n",initrd_start,min_low_pfn << PAGE_SHIFT);
> > +		    "disabling it.\n",
> > +		    page_to_pfn(virt_to_page(initrd_start)), min_low_pfn);
> >  		initrd_start = 0;
> >  	}
> 
> This patch causes warnings on mips:
> 
> linux/init/main.c: In function 'start_kernel':
> linux/init/main.c:633: warning: passing argument 1 of 'virt_to_phys' makes pointer from integer without a cast
> linux/init/main.c:636: warning: passing argument 1 of 'virt_to_phys' makes pointer from integer without a cast
> 
> Because an argument of mips virt_to_phys() is an pointer and
> initrd_start is unsigned long.  It seems most (all?) arch's
> virt_to_phys() casts its argument to unsigned long internally.  Should
> mips follow?

Alternatively, as initrd_start is really a virtual kernel address,
perhaps it should be changed from unsigned long to void * instead?

It's cast to `void *' in several place. arch/xtensa/kernel/setup.c even
has `extern void *initrd_start' to fool around this?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
