Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 12:59:11 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59020 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026885AbXHHL7J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 12:59:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l78Bwtf1012503;
	Wed, 8 Aug 2007 12:58:56 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l78Bwqnp012502;
	Wed, 8 Aug 2007 12:58:52 +0100
Date:	Wed, 8 Aug 2007 12:58:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Takashi Iwai <tiwai@suse.de>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, jiankemeng@gmail.com,
	tiansm@lemote.com, linux-mips@linux-mips.org,
	alsa-devel@alsa-project.org, greg@kroah.com
Subject: Re: ALSA on MIPS platform
Message-ID: <20070808115852.GA6700@linux-mips.org>
References: <46B332AC.8020403@lemote.com> <5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com> <5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com> <20070807.230157.59463765.anemo@mba.ocn.ne.jp> <20070807175402.GA24731@linux-mips.org> <s5hlkcnmbll.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlkcnmbll.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 07, 2007 at 08:41:10PM +0200, Takashi Iwai wrote:

> > It's ALSA that is doing funny things here so there is no point in fixing
> > the arch code to work for ALSA.
> 
> Yep, but OTOH, the arch code doesn't provide a proper standard way to
> mmap the pages allocated via dma_alloc_coherent().  That's the missing
> piece, especially on mips and sparc.  ARM has already one.
> 
> My wish is implementing dma_mmap_coherent() on all architectures, so
> that the driver can use it safely without messy ifdefs.

Adding dma_mmap_coherent has been proposed in 2004 but the discussion for
some reason went nowhere because it apparently isn't implementable on
PARISC due to cache synonyms - on MIPS we'd solve those issues where they
exist by using uncached or writethrough mappings, as apropriate.

  Ralf
