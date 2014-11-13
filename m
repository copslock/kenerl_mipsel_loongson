Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 23:34:53 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:59572 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009415AbaKMWevwFpXE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 23:34:51 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
        id 0MKv1o-1Xp2yO13fE-0006m5; Thu, 13 Nov 2014 23:34:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
        Rob Herring <robh@kernel.org>, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
Date:   Thu, 13 Nov 2014 23:34:39 +0100
Message-ID: <3857076.lzkrNkraM9@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAJiQ=7DoFk7ZSjHygaMWHyBTpxJFbQX4onh2xqixaqORQODsVg@mail.gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <4606459.kh8mb8TEgZ@wuerfel> <CAJiQ=7DoFk7ZSjHygaMWHyBTpxJFbQX4onh2xqixaqORQODsVg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:7vrma+VDbaTpMoomUZVKIohli5zaE1M8ocaAr7ybNm+
 tzWWJpRC7wPzMrskka70ly2QPer1ICzyPtd1V/J65+AgpRTzAw
 Dh0Nep9xesOW5q75wYWPGJ+ARI07tAd2ywh0JobbNP+v36I6MJ
 PnSi3TEMWzvjOE/d97GxKu20TY+gj25fzBtTYFS1wqbuxKK02F
 l85d320dQhc5CMmtDWMmFbRJ8T1QfQT9qAjsGYzO/psg8xxXPv
 Onxxm28fbV1DLCo8mPaY30u11YxutB43SpRSIiD23FoZOAIkEi
 ritgVaAwZW3f6JVxqVwygLLDDd+Zomk8nCvDVVuZkWYfS/LH7a
 bXAsK+Gla4l4DwJoeCv0=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thursday 13 November 2014 11:08:08 Kevin Cernekee wrote:
> On Thu, Nov 13, 2014 at 1:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > TTY naming is a mess today, and you seem to be caught in the middle
> > of it trying to work around the inherent problems. Extending the PXA
> > driver is an interesting approach since as you say it's a very nice
> > clean subset of the 8250 driver, but that doesn't mean that it's
> > a good long-term strategy, as we will likely have more chips with
> > 8250 variants.
> >
> > Some of the ways forward that I can see are:
> >
> > - (your approach) use and extend the pxa serial driver for new SoCs,
> >   possibly migrate some of the existing users of 8250 to use that
> >   and leave 8250 alone.
> >
> > - fix the problem you see in a different way, and get the 8250 driver
> >   to solve your problem. Possibly integrate the pxa driver back into
> >   8250 in eventually, as we did with the omap driver.
> 
> Do you think it might make sense to come up with a set of guidelines
> that ensure that SoCs using a non-serial8250 driver (like pxa) on
> 16550-compatible hardware can be easily moved back to serial8250
> someday?
> 
> e.g. maybe I should be adding a reg-shift property to my pxa DT entry.
> It isn't necessary for pxa.c, but if we ever move to serial8250 it
> will be necessary.

I'm not sure how many others exist that are 8250-like with different
drivers. I think it would be a good idea to have the properties in
there, but I'm not sure if I can come up with an exhaustive list
of requirements.

> > - Do a fresh start for a general-purpose soc-type 8250 driver, using
> >   tty_port instead of uart_port as the abstraction layer.
> 
> Hmm, does that mean we can't use the serial_core.c helpers?

Correct. IIRC the consensus among the tty maintainers has been
for some time that serial_core.c and uart_port doesn't actually do
that much good compared to the complexity it adds in other places.
I may misremember the exact argument.

> >   Use that for
> >   all new socs instead of extending the 8250 driver more, possibly
> >   migrating some of the existing 8250 users.
> 
> One nice thing about a brand new driver is that we can use dynamic
> major/minor numbers unconditionally without breaking existing users.
> If either pxa.c or bcm63xx_uart.c had used dynamic numbers, I could
> drop Tushar's original workaround.
> 
> Another advantage is that we can assume all users have DT, simplifying
> the probe function.
> 
> Would it be helpful to split parts of pxa.c and/or serial8250 into a
> "lib8250", similar to libahci, that can be called by many different
> implementations (some of which have special features like DMA
> support)?

That sounds like a very good idea, yes. I had actually worked on something
in this area years ago, but haven't followed up in some time. In particular,
I think it makes sense to split the specific I/O register access method into
a separate library from the code that knows about the 8250 register set,
and from the code that performs the probing.

	Arnd
