Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:44:44 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:58144 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007162AbbLINonOC0k9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:44:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=BNpnW+KSCDRqHuLGVrsDDUJ0YyrkQrcJvaHBZfUVNBc=;
        b=GSlBrSmx8nHB1cTSFfGVcidPzqCefdc3g8IKTqVg2oE9nX8bl4QXveqNyn8RuE06RgwJmn3gmesAuR27rl2FWb7eOIcwBQbafcggUjlWufZJXu/rNXHQexwBpLuNPtuXAD9PvNNm6UX21e3+1butpK+HhnWosxR9XxkDGML1+2Q=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42144)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1a6f2W-0003tQ-U0; Wed, 09 Dec 2015 13:44:17 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1a6f2S-00088p-7E; Wed, 09 Dec 2015 13:44:13 +0000
Date:   Wed, 9 Dec 2015 13:44:11 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
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
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
Message-ID: <20151209134410.GH8644@n2100.arm.linux.org.uk>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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
> Because we want to have a proper userspace ABI for GPIO chips,
> which involves using a character device that the user opens
> and closes. While the character device is open, the underlying
> kernel objects must not go away.

Okay, so you stop the gpio_chip struct from going away.  What
about the code which is called via gpio_chip - say, if userspace
keep shte chardev open, and someone rmmod's the driver providing
the GPIO driver.

I'm not sure that splitting up objects in this way really solves
anything at all.  Yes, it divorses the driver's private data from
the subsystem data, but is that really an advantage?

Network drivers have a similar issue, and the way this problem is
solved there is that alloc_netdev() is always used to allocate the
subsystem data structure and any driver private data structure as
one allocation, and the lifetime of both objects remains under the
control of the subsystem.

The allocated memory is only freed when the last user goes away,
and net has protection to prevent an unregistered driver from
being called (via locks on every path into the layer.)

Things get a little more complex with gpio, because there's the
issue that some methods are spinlocked while others can take
semaphores, but it should be possible to come up with a solution
to that - maybe an atomic_t which is incremented whenever we're
in some operation provided it's >= 0 (otherwise it fails), and
decremented when the operation completes.  We can then control
in the unregistration path further GPIO accesses, and also
prevent new accesses occuring by setting the atomic_t to -1.
This shouldn't require any additional locking in any path.  It
does mean that the unregistration path needs careful thought to
ensure that when we set it to -1, we wait for it to be dropped
by the appropriate amount.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
