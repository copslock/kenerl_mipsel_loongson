Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 15:46:09 +0100 (CET)
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33548 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007854AbbLIOqHHufH5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 15:46:07 +0100
Received: by oixx65 with SMTP id x65so27609797oix.0
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 06:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jqc65s6iUGmruADSm7+OQRNFYwpUZPUwR5OSLWqMhzs=;
        b=KFQ6tEk8hbXBbIXCJNhs1Gd7CZGzihhp99fUGEdLiKm/FNMXw+6YYc5MgoQKi2t/Ws
         IxIR8ceIz/nKa+RdK0I78PJQPwFnanXwJjQmoUoCsWfrPzIt7PTrwt8pD7D+2UhXX/qA
         hSbbEbDuqPNl39wH3Z3tYK/YIpttbivTi3XQsxu/pFJgI70wDilyzvZ4/HHUAdrZ8P3/
         WBk5Zod4uqmluhxVLFmCx4BSue+fmgKdJdoRKGX8MG9lK7N/BaBFPltUsC8xvlk/hTCR
         O/g8GFIL5I/d15711lgYMLIr2AhDGU9i2GSSJTBKelYMZu27MxZr5eXPuWXBnsFydDUz
         QoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jqc65s6iUGmruADSm7+OQRNFYwpUZPUwR5OSLWqMhzs=;
        b=XCXLQJ2hzJ0HsDvpaFhKw/O5/GJIZg4S9FvJU6+S4pJFGQCH3ZjhVprB5ciayXWbRB
         n6hW0PBdVMj7pNtakHtjib6z+QSxsezEosMNY/vSpclZRVb9zwK1TaFlFv+JxsITW86S
         Ukczx7Get/+KKEnJGXKlbgx8YAbgO8+2ZA88wtu4YeiZmBLWsj1TCaS4qJ8KyOrXVyjQ
         mYKNkUpIyyoxHuoNIxOyyVf6x8s3K+6McUyRzf8AEjZLz5fb/Gb0ox5D22ufQP9yEUtC
         kkiMYcZDKwTW5JTEvHyftIc15wtubvxrBc8nXjb5MuywgU/j3rtm9gAihU/CZBzamfdc
         ATyA==
X-Gm-Message-State: ALoCoQnqQ8YAecz54mQc0LcFP3E3907B/z9Gf76yEkpJggRt8aKU/uKH81EXR/odtF9W4xCZ+5CSsh68u1EYLEP+UIZxJ2CLfmZmZEN6EDla5HOuuSzK8dE=
MIME-Version: 1.0
X-Received: by 10.202.195.202 with SMTP id t193mr4308189oif.94.1449672360899;
 Wed, 09 Dec 2015 06:46:00 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Wed, 9 Dec 2015 06:46:00 -0800 (PST)
In-Reply-To: <20151209134410.GH8644@n2100.arm.linux.org.uk>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
        <20151209134410.GH8644@n2100.arm.linux.org.uk>
Date:   Wed, 9 Dec 2015 15:46:00 +0100
Message-ID: <CACRpkdZcz73vtgZsCKZCJ=G3nq-yCPiO8hws4ro5HVWd8AVRCw@mail.gmail.com>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
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
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Wed, Dec 9, 2015 at 2:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

Thanks Russell, I think you speed up the design and shorten the
development time by providing these ideas, so it is much, much
appreciated.

> On Wed, Dec 09, 2015 at 02:08:35PM +0100, Linus Walleij wrote:
>> Because we want to have a proper userspace ABI for GPIO chips,
>> which involves using a character device that the user opens
>> and closes. While the character device is open, the underlying
>> kernel objects must not go away.
>
> Okay, so you stop the gpio_chip struct from going away.

Actually I was going to create a new struct gpio_device, but yes.

> What
> about the code which is called via gpio_chip - say, if userspace
> keeps the chardev open, and someone rmmod's the driver providing
> the GPIO driver.

The idea was that when what is today gpiochip_remove() is called by the
gpiochip driver, the static data pointer to the vtable with all
callbacks is set to NULL (in some safe way), and the code avoids
calling these, so the device goes numb.

I think you give me the right solution to this "safe way" below,
thanks!

> I'm not sure that splitting up objects in this way really solves
> anything at all.  Yes, it divorses the driver's private data from
> the subsystem data, but is that really an advantage?

I like the design pattern you describe below, and
I have no strong opinion on it. If there is a precedent in the kernel
to do it with a separate alloc_foo() function I can do that.

(Would like Greg's and/or Johan's opinion on this though.)

> Network drivers have a similar issue, and the way this problem is
> solved there is that alloc_netdev() is always used to allocate the
> subsystem data structure and any driver private data structure as
> one allocation, and the lifetime of both objects remains under the
> control of the subsystem.
>
> The allocated memory is only freed when the last user goes away,
> and net has protection to prevent an unregistered driver from
> being called (via locks on every path into the layer.)

That's a viable way to solve this.

The refactoring would be bigger in size and different. The current
patch set would still be needed though, as the drivers will
still not be able to use the container_of() design pattern with this
design either, as the gpiolib core handles allocation of its
own struct and then some more.

With what I had in mind it would be something like:

struct foo_gpio {
      struct gpio_device *gd;
};

const struct gpio_ops foo_ops = {
     .set = ...
     .get = ...
};

foo = devm_kzalloc(dev, ...);
foo->gd = gpio_add_device(&foo_ops, ...);
...
gpio_remove_device(foo->gd);


But with the alloc_gpiodev() pattern we get this:

struct foo_gpio {
....
};

static void setup(struct gpio_device *gd)
{
   gd->set = ...;
   gd->get = ...;
}

foo = gpio_alloc_device(sizeof(foo), name, setup);
struct gpio_device *gd = gpio_add_device(foo);
...
gpio_remove_device(gd);

The setup call is clever to use also with GPIO because we
can use that to setup mmio-gpio drivers and easier refactor
those drivers that assign members to gpio_chip dynamically.

Also I think this case would involve getting rid of all static
vtables and only use that setup call to assign function
pointers akin to what we have for gpio_chip. Lots of work,
but I like it.

We can do allocation in early boot these days even if
the gpiochip is added with an early initcall right?

> Things get a little more complex with gpio, because there's the
> issue that some methods are spinlocked while others can take
> semaphores, but it should be possible to come up with a solution
> to that - maybe an atomic_t which is incremented whenever we're
> in some operation provided it's >= 0 (otherwise it fails), and
> decremented when the operation completes.  We can then control
> in the unregistration path further GPIO accesses, and also
> prevent new accesses occuring by setting the atomic_t to -1.
> This shouldn't require any additional locking in any path.  It
> does mean that the unregistration path needs careful thought to
> ensure that when we set it to -1, we wait for it to be dropped
> by the appropriate amount.

Yeah we will both in spinlocks/hotpath and
semaphores/mutexes/slowpath in these ops for sure :/

The atomic hack should work: I understand that you mean
we read it and set it to -1 and if it was 2 wait for it to
become -3, then conclude unregistration with callbacks
numbed.

Then there is a particular case that occurs with USB or similar
pluggable buses, where there is a glitch or powercycle on the
bus, and the same device goes away and comes back in
a few milliseconds, and that means it should reattach to the
character device that is already open.

Making that work is however non-trivial :(

Yours,
Linus Walleij
