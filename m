Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2010 10:28:30 +0100 (CET)
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:44863 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492023Ab0AMJ20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jan 2010 10:28:26 +0100
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
        id C7B14400C1; Wed, 13 Jan 2010 10:28:25 +0100 (CET)
Date:   Wed, 13 Jan 2010 10:28:25 +0100
From:   Andreas Mohr <andi@lisas.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andreas Mohr <andi@lisas.de>, alsa-devel@alsa-project.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH 0/5] PCM mmap (temporary) fixes for non-coherent
        architectures
Message-ID: <20100113092825.GA15394@rhlx01.hs-esslingen.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de> <20100101193130.GA21510@rhlx01.hs-esslingen.de> <s5haawj7qlv.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5haawj7qlv.wl%tiwai@suse.de>
X-Priority: none
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@lisas.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8359

Hi,

On Tue, Jan 12, 2010 at 08:02:36AM +0100, Takashi Iwai wrote:
> At Fri, 1 Jan 2010 20:31:30 +0100,
> Andreas Mohr wrote:
> > 
> > Hi,
> > 
> > I've tried this patch set (with the typo-corrected part 4) on my ASUS
> > WL-500gP v2 MIPSEL via a backport to 2.6.31.9, but all I get is a
> > small blip of the sound I wanted to play, and then the system is fubar
> > (I believe just the same thing as what happened without having this patch
> > applied).

Crap, you already managed to beat me to my own reply! ;)
(I'll try your patch in the other mail _ASAP_)

> As I mentioned in the previous followup, if your device is a
> USB-audio, the patch doesn't help because it's for devices with
> buffers using dma_alloc_coherent().  For USB-audio, it uses vmalloc
> for an intermediate buffer.  Maybe this should be changed to dma_*()
> stuff for such architectures.

I've been searching the mailing list postings up and down,
but I couldn't deduce anything to that effect from that content
(but I'm mailing list-externally - maybe I just really didn't find the
correct posting or there was a threading split)

> Nevertheless, I don't know whether the crash is related with the
> audio part...

Yes, I wasn't fully pointing at the crash being caused by insufficient
patches in that area either...
(but I haven't fully investigated these OOPSes yet)

Thanks a lot for your new test patch,

Andreas Mohr
