Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2008 19:33:39 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:17611 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23974180AbYK1Td3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Nov 2008 19:33:29 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id D103C386DBBE;
	Fri, 28 Nov 2008 20:33:22 +0100 (CET)
Date:	Fri, 28 Nov 2008 20:35:57 +0100
From:	Phil Sutter <n0-1@freewrt.org>
To:	David Brownell <david-b@pacbell.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: MIPS: RB532: Provide functions for gpio configuration
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <200811202002.16178.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200811202002.16178.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Message-Id: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Return-Path: <n0-1@freewrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Hi!

I fullquote here because of the lists and people added to Cc.

On Thu, Nov 20, 2008 at 08:02:15PM -0800, David Brownell wrote:
> I just noticed:
> 
> > commit 2e373952cc893207a8b47a5e68c2f5155f912449
> > Author: Phil Sutter <n0-1@freewrt.org>
> > Date:   Sat Nov 1 15:13:21 2008 +0100
> >
> >     MIPS: RB532: Provide functions for gpio configuration
> >
> >     As gpiolib doesn't support pin multiplexing, it provides no way to
> >     access the GPIOFUNC register. Also there is no support for setting
> >     interrupt status and level. These functions provide access to them and
> >     are needed by the CompactFlash driver.
> >
> >     Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> >     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> The conventional way to do most of that is through the irq_chip
> associated with that block of IRQ-capable GPIOs.
> 
> 
> So ...
> 
> > -       /* Set the interrupt status and level for the CF pin */
> > -       rb532_gpio_set_int_level(&rb532_gpio_chip->chip, CF_GPIO_NUM, 1);
> > -       rb532_gpio_set_int_status(&rb532_gpio_chip->chip, CF_GPIO_NUM, 0);
> > +       /* configure CF_GPIO_NUM as CFRDY IRQ source */
> > +       rb532_gpio_set_func(0, CF_GPIO_NUM);
> 
> ... the pinmux would indeed be a SOC-specific mechanism, kicked in
> only for boards that use that GPIO in that way, but ...
> 
> 
> > +       rb532_gpio_direction_input(&rb532_gpio_chip->chip, CF_GPIO_NUM);
> 
> ... normal gpio_request() + gpio_direction_input() would set the pin up, and ...
> 
> 
> > +       rb532_gpio_set_ilevel(1, CF_GPIO_NUM);
> > +       rb532_gpio_set_istat(0, CF_GPIO_NUM);
> 
> 	status = request_irq(gpio_to_irq(CF_GPIO_NUM), ... )
> 
> with appropriate IRQF_TRIGGER_* flags should solve that problem.
> Or even just set_irq_type().  (At least for one of the two
> registers updated there ... I can't guess what "istat" would be.)
> 
> Just FYI at this point.  Maybe you have a reason not to fit into
> the genirq framework.
> 
> - Dave

Thanks for your hints, Dave. I already had a patch flying around adding
a set_type() function to the irq_chip (merely a dummy to shut up
warnings in the boot log). After extending it to cover the needs of the
mapped GPIO pins and some other work, I could drop that CompactFlash
initialisation code in gpio.c completely.

As a side effect, many of my changes to pata-rb532-cf got unnecessary
which I consider a very good sign.

I'll reply to this mail with the relevant patches for each list and
maintainer. 

Greetings, Phil
