Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2011 15:36:30 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37255 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1490991Ab1FXNg1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Jun 2011 15:36:27 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5ODaODP032661;
        Fri, 24 Jun 2011 14:36:24 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5ODaNmt032658;
        Fri, 24 Jun 2011 14:36:23 +0100
Date:   Fri, 24 Jun 2011 14:36:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] SOUND: Fix non-ISA_DMA_API build failure
Message-ID: <20110624133623.GA32018@linux-mips.org>
References: <20110623144750.GA10180@linux-mips.org>
 <201106241519.44425.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201106241519.44425.arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20328

On Fri, Jun 24, 2011 at 03:19:44PM +0200, Arnd Bergmann wrote:

> > The sole ISA sound driver that does not use the ISA DMA API is the Adlib
> > driver so replaced the dependency of SND_ISA on ISA_DMA_API and add it to
> > each of the drivers individually.
> 
> Do we really care all that much about the Adlib driver on platforms without
> ISA_DMA_API? Right now all of sound/isa/ is hidden behind ISA_DMA_API and
> I think that's acceptable

When looking into this build error I started untangling the mess from the
isa from the sounds end and found the media bits as the root cause after I
finished the sound bits.  I honestly don't care about the Adlib - until I
plug an Adlib into one of my SGI Indigo² and that's unlikely to happen :)

> > diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
> > index e4c97fd..0aeed28 100644
> > --- a/drivers/media/radio/Kconfig
> > +++ b/drivers/media/radio/Kconfig
> > @@ -168,7 +168,7 @@ config RADIO_MAXIRADIO
> >  
> >  config RADIO_MIROPCM20
> >         tristate "miroSOUND PCM20 radio"
> > -       depends on ISA && VIDEO_V4L2 && SND
> > +       depends on ISA && ISA_DMA_API && VIDEO_V4L2 && SND
> >         select SND_ISA
> >         select SND_MIRO
> >         ---help---
> 
> Then this hunk by itself would be enough to solve the compile
> errors, AFAICT.

It is, I've tested that.

  Ralf
