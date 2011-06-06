Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 14:39:56 +0200 (CEST)
Received: from mail.academy.zt.ua ([82.207.120.245]:59284 "EHLO
        mail.academy.zt.ua" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490948Ab1FFMjx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 14:39:53 +0200
Received: from [10.0.2.42] by mail.academy.zt.ua (Cipher SSLv3:RC4-MD5:128) (MDaemon PRO v12.0.0)
        with ESMTP id md50000010001.msg
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 15:39:45 +0300
X-Authenticated-Sender: george@academy.zt.ua
X-HashCash: 1:20:110606:md50000010001::FAe2Ftu3KRnRi1gK:00001K9Y
X-Return-Path: prvs=1138417825=george@znau.edu.ua
X-Envelope-From: george@znau.edu.ua
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
From:   George Kashperko <george@znau.edu.ua>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Greg KH <greg@kroah.com>,
        linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com
In-Reply-To: <201106061332.51661.arnd@arndb.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
         <1307311658-15853-2-git-send-email-hauke@hauke-m.de>
         <BANLkTimAPHPcqKKJ+Rphef_+1RB0aHR4ug@mail.gmail.com>
         <201106061332.51661.arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Date:   Mon, 06 Jun 2011 15:29:59 +0300
Message-Id: <1307363399.28734.25.camel@dev.znau.edu.ua>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-19.el5) 
Content-Transfer-Encoding: 8bit
X-archive-position: 30256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: george@znau.edu.ua
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4212

Hi,

> On Monday 06 June 2011, Rafał Miłecki wrote:
> > Greg, Arnd: could you take a look at this patch, please?
> > 
> > With proposed patch we are going back to this ugly array and wrappers hacks.
> > 
> > I was really happy with our final solution, but it seems it's not
> > doable for embedded systems...? Is there something better we can do
> > about this?
> > 
> > 2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> > > When using bcma on a embedded device it is initialized very early at
> > > boot. We have to do so as the cpu and interrupt management and all
> > > other devices are attached to this bus and it has to be initialized so
> > > early. In that stage we can not allocate memory or sleep, just use the
> > > memory on the stack and in the text segment as the kernel is not
> > > initialized far enough. This patch removed the kzallocs from the scan
> > > code. Some earlier version of the bcma implementation and the normal
> > > ssb implementation are doing it like this.
> > > The __bcma_dev_wrapper struct is used as the container for the device
> > > struct as bcma_device will be too big if it includes struct device.
> > >
> > > Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> 
> If you rely on device scan to find your CPUs and interrupt controllers,
> you are screwed already, this won't work.
> 
> In that case, it's better to have a few "early" drivers, as few as
> possible, that don't go through the bus scan at all but have their
> own ways of bootstrapping themselves. I don't know what you mean by
> "CPU management", but I can only assume that it's not doing that much,
> and you can just put the register values into the device tree.
GPIOs, flash and UART could get initialized early without erom scanning
as Chipcommon seems always to be the #0 core on the amba interconnect.

> 
> For an interrupt controller, it should be ok to have it initialized
> late, as long as it's only responsible for the devices on the same
> bus and not for instance for IPI interrupts. Just make sure that you
> do the bus scan and the initialization of the IRQ driver before you
> initialize any drivers that rely in on the interrupts to be working.
Without proper timer init (which requires both the chipcommon and mips
cores knowledge) kernel will get hung somewhere inside calibrate_delay.
It could get addressed if get bus scan called in arch_init_irq or
plat_time_init - both are executed before calibrate_delay and with slab
available.

Have nice day,
George
