Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2011 15:08:26 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47710 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491832Ab1FXNIX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Jun 2011 15:08:23 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5OD8Jrf029980;
        Fri, 24 Jun 2011 14:08:19 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5OD8I8U029973;
        Fri, 24 Jun 2011 14:08:18 +0100
Date:   Fri, 24 Jun 2011 14:08:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] SOUND: Fix non-ISA_DMA_API build failure
Message-ID: <20110624130818.GC6327@linux-mips.org>
References: <20110623144750.GA10180@linux-mips.org>
 <s5hzkl7zlcq.wl%tiwai@suse.de>
 <20110624111608.GA6327@linux-mips.org>
 <s5hzkl72zce.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzkl72zce.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20299

On Fri, Jun 24, 2011 at 02:22:41PM +0200, Takashi Iwai wrote:

> >  o The drivers/media/radio/Kconfig part should be applied for 3.0 and
> >    maybe -stable.
> 
> Yes, this will be good.

I just tested that segment only and it works as expected.  Will repost in
a minute.

> >  o The sound/isa/Kconfig part is basically only fixing the dependency for
> >    the Adlib driver allowing it to be built on non-ISA_DMA_API system and
> >    is material for the next release after 3.0.
> 
> Any serious reason that snd-adlib must be built even with ISA=n?

Definately not.

> As the device is really present only for ISA, it doesn't make much
> sense to build this even though the driver itself doesn't need
> ISA_DMA_API.

I'm not aware of any systems that could use the Adlib in a ISA=n
environment.  That's why my patch left the dependency on ISA untouched.

  Ralf
