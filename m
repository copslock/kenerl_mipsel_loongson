Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 20:30:45 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34805 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008244AbbLITan6yRIF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 20:30:43 +0100
Received: by pacwq6 with SMTP id wq6so34194655pac.1;
        Wed, 09 Dec 2015 11:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=id7MAjuBuj1qnl/iyFN+YpcXDmByV62UHpM1B1fnpaQ=;
        b=eznPoBA7nGvKm+YhxmDMjbKP8xL+B6OUm4cjIKgLmy/+qsNRdBGY7kks1pndCpqFHi
         8ffFGuNjnfaRuaoONIShy77fDDda7BxVWgSMeSsRUtp1KgnJCzGx/AjhRWo/4BmA7JZl
         Si8QCd40nbibgsOyEHVL0YETGnH1qsMx7FmNZ2pJzp3ushlkw65ZLLY8BWAkHdfTL6mh
         rMpNwJ2auzmkIQW/To4cND+BKQvCYJLrI2NtynyQ3ruyEO/AhNUxYlkaLISJwQlXU/5p
         Dpc12xF3Nl76CQb0YQep3vKovvCyfBMG+UK8WJacIZvY24iIAWTGSU7OFNelL5cJCrcS
         5kBQ==
X-Received: by 10.66.229.2 with SMTP id sm2mr10498948pac.28.1449689437766;
        Wed, 09 Dec 2015 11:30:37 -0800 (PST)
Received: from dtor-ws ([2620:0:1000:1301:876:ee4f:b0a1:d043])
        by smtp.gmail.com with ESMTPSA id 9sm13375107pfn.51.2015.12.09.11.30.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 09 Dec 2015 11:30:36 -0800 (PST)
Date:   Wed, 9 Dec 2015 11:30:34 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, arm@kernel.org,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Sonic Zhang <sonic.zhang@analog.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Anatolij Gustschin <agust@denx.de>,
        linux-wireless@vger.kernel.org, linux-input@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
Message-ID: <20151209193034.GE27131@dtor-ws>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Wed, Dec 09, 2015 at 02:08:35PM +0100, Linus Walleij wrote:
> This removes the use of container_of() constructions from *all*
> GPIO drivers in the kernel. It is done by instead adding an
> optional void *data pointer to the struct gpio_chip and an
> accessor function, gpiochip_get_data() to get it from a driver.
> 
> WHY?
> 
> Because we want to have a proper userspace ABI for GPIO chips,
> which involves using a character device that the user opens
> and closes. While the character device is open, the underlying
> kernel objects must not go away.
> 
> Currently the GPIO drivers keep their state in the struct
> gpio_chip, and that is often allocated by the drivers, very
> often as a part of a containing per-instance state container
> struct for the driver:
> 
> struct foo_state {
>    struct gpio_chip chip;  <- OMG my state is there
> };
> 
> Drivers cannot allocate and manage this state: if a user has the
> character device open, the objects allocated must stay around
> even if the driver goes away. Instead drivers need to pass a
> descriptor to the GPIO core, and then the core should allocate
> and manage the lifecycle of things related to the device, such
> as the chardev itself or the struct device related to the GPIO
> device.

Yes, but it does not mean that the object that is being maintained by
the subsystem and that us attached to character device needs to be
gpio_chip itself. You can have something like

struct gpio_chip_chardev {
	struct cdev chardev;
	struct gpio_chip *chip;
	bool dead;
};

struct gpio_chip {
	...
	struct gpio_chip_chardev *chardev;
	...
};

You alloctae the new structure when you register/export gpio chip in
gpio subsystem core and leave all the individual drivers alone.

Thanks.

-- 
Dmitry
