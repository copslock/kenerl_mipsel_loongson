Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2011 16:47:32 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42217 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491043Ab1GZOr3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jul 2011 16:47:29 +0200
Received: from rakim.wolfsonmicro.main (unknown [87.246.78.26])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 81459750055;
        Tue, 26 Jul 2011 15:47:23 +0100 (BST)
Received: by rakim.wolfsonmicro.main (Postfix, from userid 1000)
        id EB479878B92C; Tue, 26 Jul 2011 15:47:18 +0100 (BST)
Date:   Tue, 26 Jul 2011 15:47:18 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     alsa-devel@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 1/3] ASoC: Alchemy AC97C/I2SC audio support
Message-ID: <20110726144718.GJ7285@opensource.wolfsonmicro.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
 <1311594287-31576-2-git-send-email-manuel.lauss@googlemail.com>
 <20110726143112.GF7285@opensource.wolfsonmicro.com>
 <CAOLZvyFzHFGFvFrWigLi_oHpdQBp1ZCsRBEU8tF-62X8VaCd_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLZvyFzHFGFvFrWigLi_oHpdQBp1ZCsRBEU8tF-62X8VaCd_Q@mail.gmail.com>
X-Cookie: Save energy: be apathetic.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18666

On Tue, Jul 26, 2011 at 04:43:16PM +0200, Manuel Lauss wrote:
> On Tue, Jul 26, 2011 at 4:31 PM, Mark Brown

> >> +     case (~DMA_D0 & ~DMA_D1):
> >> +             pr_debug("DMA %d empty irq.\n", stream->dma);

> > This case should return IRQ_NONE really since it didn't handle an
> > interrupt...

> If that last case ever happens the DMA engine is broken, as it shouldn't
> issue interrupts when no transfer is in progress.  The errata sheets don't
> mention anything (yet).

In that case this should be an error rather than debug level print and
I'd say the IRQ_NONE thing definitely applies.
