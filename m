Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 17:46:21 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:60135 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S22753977AbYJ3RqR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Oct 2008 17:46:17 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id BF2F638C5FB6
	for <linux-mips@linux-mips.org>; Thu, 30 Oct 2008 18:46:08 +0100 (CET)
Date:	Thu, 30 Oct 2008 18:47:15 +0100
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] provide functions for gpio configuration
Message-ID: <20081030174715.GA10620@nuty>
Mail-Followup-To: Linux-Mips List <linux-mips@linux-mips.org>
References: <1225310409-4440-1-git-send-email-n0-1@freewrt.org> <200810292107.43818.florian@openwrt.org> <20081029211046.GC17108@nuty> <200810301813.05710.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200810301813.05710.florian@openwrt.org>
User-Agent: Mutt/1.5.11
Return-Path: <n0-1@freewrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, Oct 30, 2008 at 06:13:05PM +0100, Florian Fainelli wrote:
> Le Wednesday 29 October 2008 22:10:46 Phil Sutter, vous avez écrit :
> > Yes it does, but that's not part of gpiolib itself. Accessing them needs
> > a combination of gpio_to_chip() and container_of() to be used, which I
> > doubt makes sense on a device with a single, platform gpio chip.
> 
> Yes, that makes it unexportable the way it is done yet. What I suggest is not 
> overriding the struct rb532_gpio_chip with thoses callbacks, but do like you 
> suggested initially.
> 
> > I'm not sure if this is absolutely true. The original CompactFlash
> > driver e.g. clears interrupt level in cf_irq_handler() and sets it in
> > prepare_cf_irq(). The latter function is called more than once.
> 
> This should be moved the IRQ handler, where a specific check for the IRQ being 
> a GPIO one should set the interrupt status and level accordingly.

Sounds reasonable to me. So I'll prepare a patch which:
* removes the function pointers from rb532_gpio_chip
* exports getters and setters for interrupt status and level

The GPIO config and function registers should indeed only be accessed at
bootup, so the corresponding getters/setters will be only locally
accessible in arch/mips/rb532/gpio.c. Doing it this way also prevents
any driver from breaking others, as the complete GPIO configuration will
be done at a single place (i.e., inside gpio.c). IIRC pata-rb532-cf did
use them only at initialisation state and to prevent the described
situation.

I got the pata driver working by the way. I just wanted to get a
solution for the GPIO problem first, as it needs to access interrupt
level and status at least.

Greetings, Phil
