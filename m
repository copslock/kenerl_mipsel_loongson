Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 15:13:13 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58692 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493090AbZH1NNG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Aug 2009 15:13:06 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7SDE7ZH005635;
	Fri, 28 Aug 2009 14:14:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7SDE6ZA005610;
	Fri, 28 Aug 2009 14:14:06 +0100
Date:	Fri, 28 Aug 2009 14:14:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: MTX build failure
Message-ID: <20090828131406.GC24330@linux-mips.org>
References: <20090828074709.GA11637@linux-mips.org> <4A979B0E.106@gmail.com> <4A97A2E2.2090108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A97A2E2.2090108@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 28, 2009 at 11:26:58AM +0200, Manuel Lauss wrote:

> I wrote:
> > Ralf Baechle wrote:
> >>   CC      drivers/input/keyboard/gpio_keys.o
> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c: In function ‘gpio_keys_probe’:
> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:123: error: implicit declaration of function ‘gpio_request’
> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:135: error: implicit declaration of function ‘gpio_free’
> >> make[5]: *** [drivers/input/keyboard/gpio_keys.o] Error 1
> >> make[4]: *** [drivers/input/keyboard] Error 2
> >> make[3]: *** [drivers/input] Error 2
> >> make[2]: *** [drivers] Error 2
> >> make[1]: *** [sub-make] Error 2
> > 
> > Either something like the patch below, or adding stubs for
> > gpio_request/gpio_free to asm/mach-au1x00/gpio-au1000.h in the
> > CONFIG_GPIOLIB=n case should fix it.
> 
> Florian, Ralf, I prefer the latter approach;  saves everyone from
> having to add #ifdef CONFIG_GPIOLIB around gpio_request() calls.
> 
> Here's an untested patch.  What do you think?  If it works for you, please
> add it to your patchqueue!

Thanks, this 2nd one looks good.  Applied.

  Ralf
