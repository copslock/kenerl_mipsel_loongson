Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 21:09:57 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:49337 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S22681562AbYJ2VJt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 21:09:49 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 03E003891A92
	for <linux-mips@linux-mips.org>; Wed, 29 Oct 2008 22:09:42 +0100 (CET)
Date:	Wed, 29 Oct 2008 22:10:46 +0100
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] provide functions for gpio configuration
Message-ID: <20081029211046.GC17108@nuty>
Mail-Followup-To: Linux-Mips List <linux-mips@linux-mips.org>
References: <1225310409-4440-1-git-send-email-n0-1@freewrt.org> <200810292107.43818.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200810292107.43818.florian@openwrt.org>
User-Agent: Mutt/1.5.11
Return-Path: <n0-1@freewrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Hi Florian,

On Wed, Oct 29, 2008 at 09:07:42PM +0100, Florian Fainelli wrote:
> Le Wednesday 29 October 2008 21:00:09 Phil Sutter, vous avez écrit :
> > As gpiolib doesn't support pin multiplexing, it provides no way to
> > access the GPIOFUNC register. Also there is no support for setting
> > interrupt status and level. These functions provide access to them and
> > are needed by the CompactFlash driver.
> 
> Right, but we do have interrupt level and status fuctions, registered as 
> callbacks to an extended gpiochip structure. These two functions can remain 
> static to the gpio.c file since we should perform interrupt status and level 
> initialisation at gpiochip init time. Not sure which code you based your work 
> on, but linux-queue tree at linux-mips.org has such code.

Yes it does, but that's not part of gpiolib itself. Accessing them needs
a combination of gpio_to_chip() and container_of() to be used, which I
doubt makes sense on a device with a single, platform gpio chip.

> - GPIO initialisation should be done right after gpiochip registering

I'm not sure if this is absolutely true. The original CompactFlash
driver e.g. clears interrupt level in cf_irq_handler() and sets it in
prepare_cf_irq(). The latter function is called more than once.

> I would be rather in favor of adding the other missing callbacks to the 
> rb532_gpio_chip and make them look like the standard get/set functions. Just 
> like what was done with the interrupt level and status functions.

That could be a solution. Having both methods accessing the same data is
no choice anyway. I'll prepare a patch when I have time to.

Greetings, Phil
