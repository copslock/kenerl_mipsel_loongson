Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2015 13:45:55 +0100 (CET)
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34950 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007262AbbLNMpwusvgs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Dec 2015 13:45:52 +0100
Received: by lfdl133 with SMTP id l133so117933199lfd.2;
        Mon, 14 Dec 2015 04:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qtCRF68v/0U3jV4eoGelectdFesZZ0nQk0PAi7X+vns=;
        b=MZOs5PadB6j2JKuoUqU5iWdQNCllIplLEjd8QcH7oR3DdTCuBKTjlzr/IrocWKEn2K
         nPzTR6SH9YRpV5vOSdp8/a+L4tO64cPu2LJ+Tiv5mYbWH4G/sSiWytunAogwJ1JdzKMk
         z2plKyNwYY9dEX82aCVWDFDp4KW3R0tnGk9co8otFMrcN2do3xkdIAqIBpPoKKJeTEcB
         y7aPFQdlkMOb7DKwGfphYPmhql5Y45lb5BGdUmQG9gCNBD+pBCeNPx/fGk1KG8gjzemW
         Wc4lou+b7DgCJoYasD08jsPeJ0JmjjUegvMuwhYIOZZAw83K9H2aYp58Sv95NHWcnoH9
         4JMg==
X-Received: by 10.25.206.132 with SMTP id e126mr10574634lfg.39.1450097147245;
        Mon, 14 Dec 2015 04:45:47 -0800 (PST)
Received: from xi.terra ([84.216.64.23])
        by smtp.gmail.com with ESMTPSA id d203sm5530810lfg.39.2015.12.14.04.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2015 04:45:46 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.85)
        (envelope-from <johan@kernel.org>)
        id 1a8SWI-00043M-61; Mon, 14 Dec 2015 13:46:26 +0100
Date:   Mon, 14 Dec 2015 13:46:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Sonic Zhang <sonic.zhang@analog.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Anatolij Gustschin <agust@denx.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
Message-ID: <20151214124626.GG23327@localhost>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
 <20151209134410.GH8644@n2100.arm.linux.org.uk>
 <CACRpkdZcz73vtgZsCKZCJ=G3nq-yCPiO8hws4ro5HVWd8AVRCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZcz73vtgZsCKZCJ=G3nq-yCPiO8hws4ro5HVWd8AVRCw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <jhovold@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johan@kernel.org
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

On Wed, Dec 09, 2015 at 03:46:00PM +0100, Linus Walleij wrote:
> On Wed, Dec 9, 2015 at 2:44 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:

> > On Wed, Dec 09, 2015 at 02:08:35PM +0100, Linus Walleij wrote:
> >> Because we want to have a proper userspace ABI for GPIO chips,
> >> which involves using a character device that the user opens
> >> and closes. While the character device is open, the underlying
> >> kernel objects must not go away.
> >
> > Okay, so you stop the gpio_chip struct from going away.
> 
> Actually I was going to create a new struct gpio_device, but yes.
> 
> > What
> > about the code which is called via gpio_chip - say, if userspace
> > keeps the chardev open, and someone rmmod's the driver providing
> > the GPIO driver.
> 
> The idea was that when what is today gpiochip_remove() is called by the
> gpiochip driver, the static data pointer to the vtable with all
> callbacks is set to NULL (in some safe way), and the code avoids
> calling these, so the device goes numb.
> 
> I think you give me the right solution to this "safe way" below,
> thanks!
> 
> > I'm not sure that splitting up objects in this way really solves
> > anything at all.  Yes, it divorses the driver's private data from
> > the subsystem data, but is that really an advantage?
> 
> I like the design pattern you describe below, and
> I have no strong opinion on it. If there is a precedent in the kernel
> to do it with a separate alloc_foo() function I can do that.
> 
> (Would like Greg's and/or Johan's opinion on this though.)

I'd prefer separating allocation and registration rather than using a
setup callback.

> > Things get a little more complex with gpio, because there's the
> > issue that some methods are spinlocked while others can take
> > semaphores, but it should be possible to come up with a solution
> > to that - maybe an atomic_t which is incremented whenever we're
> > in some operation provided it's >= 0 (otherwise it fails), and
> > decremented when the operation completes.  We can then control
> > in the unregistration path further GPIO accesses, and also
> > prevent new accesses occuring by setting the atomic_t to -1.
> > This shouldn't require any additional locking in any path.  It
> > does mean that the unregistration path needs careful thought to
> > ensure that when we set it to -1, we wait for it to be dropped
> > by the appropriate amount.
> 
> Yeah we will both in spinlocks/hotpath and
> semaphores/mutexes/slowpath in these ops for sure :/
> 
> The atomic hack should work: I understand that you mean
> we read it and set it to -1 and if it was 2 wait for it to
> become -3, then conclude unregistration with callbacks
> numbed.

Ok, but let's take a step back. So you have all this in place and a
consumer calls gpiod_get_value() that returns an errno because the device
is gone. Note that this wasn't even possible before e20538b82f1f ("gpio:
Propagate errors from chip->get()") that went into *v4.3*, and I assume
most drivers would need to be updated to even handle that that gpio
call, and all future calls, are now suddenly failing.

So this ties into the generic problem of inter-device dependencies. Does
it even make sense to keep the consumer around, now that its gpio
resources have gone away?  

If your current concern is a new gpio chardev interface, perhaps solving
only that use case in the way that Dimitry suggested elsewhere in this
thread is what you should be doing.

> Then there is a particular case that occurs with USB or similar
> pluggable buses, where there is a glitch or powercycle on the
> bus, and the same device goes away and comes back in
> a few milliseconds, and that means it should reattach to the
> character device that is already open.

No, that does not follow. A USB device being disconnected and
reconnected is considered to be a new device. All state is gone, and the
dangling character device will be unusable.

> Making that work is however non-trivial :(

Fortunately, you don't need to worry about that.

Johan
