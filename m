Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 09:13:03 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55083 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491101Ab1ETHNA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2011 09:13:00 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4K7CvOv024724;
        Fri, 20 May 2011 08:12:57 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4K7CvuB024721;
        Fri, 20 May 2011 08:12:57 +0100
Date:   Fri, 20 May 2011 08:12:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-mips@linux-mips.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Namhyung Kim <namhyung@gmail.com>, lkml@linux-mips.org
Subject: Re: [RFC] Remove Alchemy OSS drivers?
Message-ID: <20110520071256.GA23902@linux-mips.org>
References: <20110519231911.GB10628@linux-mips.org>
 <s5hoc2x7tsr.wl%tiwai@suse.de>
 <BANLkTimV4Wg5ZChixp5+0cpu5knrZesSjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTimV4Wg5ZChixp5+0cpu5knrZesSjA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 20, 2011 at 08:51:37AM +0200, Manuel Lauss wrote:

> On Fri, May 20, 2011 at 8:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Fri, 20 May 2011 00:19:12 +0100,
> > Ralf Baechle wrote:
> >>
> >> OSS has very little if any useful life in it left for MIPS, at least from
> >> my perspective.  So I propose to remove the Au1550 driver - there is an
> >> ALSA replacement for it available.
> >
> > Even two variants available: one in ASoC driver and one in old ALSA
> > driver.
> 
> The current ASoC code can replace sound/oss/au1550_ac97.c,
> but sound/mips/au1x00.c is for different (earlier) chips.  I wrote an ASoC
> variant of this a long time ago, but I can't test it on real hardware.

My immediate interest is to kill off sounds/oss/ on MIPS because
sound/oss/soundcard.c is fairly ISA centric and does not build for some
some MIPS systems with only half-arsed ISA support, that is no DMA support.

Manuel, I got a DBAu1250 board here and maybe I can find a DBAu1500
Zinfandel board under some dusty hardware pile; would that be suitable for
testing your work?

  Ralf
