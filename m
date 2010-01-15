Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2010 07:51:11 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:52433 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491192Ab0AOGvH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jan 2010 07:51:07 +0100
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o0F6ooMT030152;
        Fri, 15 Jan 2010 00:50:51 -0600
Subject: Re: [PATCH 0/5] PCM mmap (temporary) fixes for non-coherent
 architectures
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andreas Mohr <andi@lisas.de>, alsa-devel@alsa-project.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <s5hvdf3lvfi.wl%tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
         <20100101193130.GA21510@rhlx01.hs-esslingen.de>
         <s5haawj7qlv.wl%tiwai@suse.de> <s5hljg24bl7.wl%tiwai@suse.de>
         <1263526082.724.395.camel@pasglop>  <s5hvdf3lvfi.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 15 Jan 2010 17:50:49 +1100
Message-ID: <1263538249.724.405.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10013

On Fri, 2010-01-15 at 07:43 +0100, Takashi Iwai wrote:
> 
> > It -might- be worth looking at adding code to the USB stack to
> propagate
> > the parent device dma_ops down to USB devices... hard to tell.
> 
> Or we may simply need to drop the mmap support on such
> architectures...

Nah, that would suck since that includes x86 nowadays :-)

I think you probably need to separate the struct device * used for DMA
(it could be default be the same as the "main" struct device tho or it
could default to NULL which means no mmap support).

USB could (if not already) provide an accessor to obtain the HC's struct
device for such mappings. We'll have to discuss that with Alan Stern I
suppose.

The USB Audio or similar drivers could then use that accessors to fill
up Alsa's dma_device field to replace the "default".

Cheers,
Ben.
