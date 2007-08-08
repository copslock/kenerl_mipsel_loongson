Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 13:40:53 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3080 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20026883AbXHHMku (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 13:40:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 19510E1EB7;
	Wed,  8 Aug 2007 14:40:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yjbeOaqKw7TK; Wed,  8 Aug 2007 14:40:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A238DE1DA3;
	Wed,  8 Aug 2007 14:40:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l78CfCVk003644;
	Wed, 8 Aug 2007 14:41:12 +0200
Date:	Wed, 8 Aug 2007 13:40:51 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Takashi Iwai <tiwai@suse.de>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	jiankemeng@gmail.com, tiansm@lemote.com, linux-mips@linux-mips.org,
	alsa-devel@alsa-project.org, greg@kroah.com
Subject: Re: ALSA on MIPS platform
In-Reply-To: <20070808115852.GA6700@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0708081302350.25542@blysk.ds.pg.gda.pl>
References: <46B332AC.8020403@lemote.com> <5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com>
 <5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com>
 <20070807.230157.59463765.anemo@mba.ocn.ne.jp> <20070807175402.GA24731@linux-mips.org>
 <s5hlkcnmbll.wl%tiwai@suse.de> <20070808115852.GA6700@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3891/Wed Aug  8 02:11:58 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 8 Aug 2007, Ralf Baechle wrote:

> > Yep, but OTOH, the arch code doesn't provide a proper standard way to
> > mmap the pages allocated via dma_alloc_coherent().  That's the missing
> > piece, especially on mips and sparc.  ARM has already one.
> > 
> > My wish is implementing dma_mmap_coherent() on all architectures, so
> > that the driver can use it safely without messy ifdefs.
> 
> Adding dma_mmap_coherent has been proposed in 2004 but the discussion for
> some reason went nowhere because it apparently isn't implementable on
> PARISC due to cache synonyms - on MIPS we'd solve those issues where they
> exist by using uncached or writethrough mappings, as apropriate.

 Hmm, why should everybody suffer from some limitation of some peculiar 
architecture?  I would suggest to let them find an architecture-specific 
way of addressing the problem -- they surely have a good control over 
their own code and can implement a workaround that would not impede all 
the others.

 Ralf, do you have an idea about what their issue exactly is?

  Maciej
