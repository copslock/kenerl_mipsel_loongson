Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jan 2011 17:05:15 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58323 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491142Ab1A3QFL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Jan 2011 17:05:11 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0UG4kh8031801;
        Sun, 30 Jan 2011 17:04:46 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0UG4ikx031799;
        Sun, 30 Jan 2011 17:04:44 +0100
Date:   Sun, 30 Jan 2011 17:04:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Subject: Re: mips allmodconfig
Message-ID: <20110130160444.GA2876@linux-mips.org>
References: <20110125143113.55aea198.akpm@linux-foundation.org>
 <s5hfwsdcwht.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hfwsdcwht.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 28, 2011 at 08:34:22AM +0100, Takashi Iwai wrote:

> > sound/oss/soundcard.c:69: error: `MAX_DMA_CHANNELS' undeclared here (not in a function)
> > sound/oss/soundcard.c:69: error: storage size of `dma_alloc_map' isn't known
> > sound/oss/soundcard.c:69: warning: 'dma_alloc_map' defined but not used         
> > 
> > In case you happen to be interested in oss drivers ;)
> 
> I took a quick look.  The only case where no MAX_DMA_CHANNELS is
> defined is only MIPS with CONFIG_GENERIC_ISA_DMA_SUPPORT_BROKEN.
> In arch/mips/include/asm/dma.h:
> 
> #ifndef CONFIG_GENERIC_ISA_DMA_SUPPORT_BROKEN
> #define MAX_DMA_CHANNELS	8
> #endif
> 
> What is the intention of this ifdef?

Uh...  It's a while, took a little headscratching until I remembered
again and I think the comment of aa414dff4f7bef29457592414551becdca72dd6b
is bogus ...

CONFIG_GENERIC_ISA_DMA enabled but MAX_DMA_CHANNELS disabled selects a
dummy version of the ISA DMA controller API.  Some drivers don't have
correct dependencies or ifdefs on CONFIG_GENERIC_ISA_DMA or don't
have correct fallback strategies in case of CONFIG_GENERIC_ISA_DMA=n.
In those cases just leaving MAX_DMA_CHANNELS undefined is useful.  This
is used on SGI Indigo² systems which have EISA slots but ISA DMA isn't
supported yet by Linux.

> Takashi  (not interested but just bored ;)

Very interested boredom ;-)

  Ralf
