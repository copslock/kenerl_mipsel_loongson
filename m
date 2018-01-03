Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 17:15:13 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:38599
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990415AbeACQPGGksFg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jan 2018 17:15:06 +0100
Received: by mail-qk0-x244.google.com with SMTP id l19so2128455qke.5;
        Wed, 03 Jan 2018 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=oF1Dvsn6T9aQ43p6FtHzXNZdEVZ4JbUxCppQHO2d5tE=;
        b=lqGAP1MeVstOlXSiLUxV9zu1w/w3143EqXCWShrspO+6YMIfku9Xe0FX5P/a5mb8la
         QIvNFhPmCc6AlUo0A9nJxG1/lsOOgWXMV+UAMpg0XLFb/YQoMiL1a6Jzc8IG01voRl1E
         HlzkxaNaqSB5ipRdx1KptmFAnQIrJ/b3aU2SIVn4L9EunQaLY0agK5s57Ccm/imuV7Kt
         MjoHQ6+7BKnd3KT0VeJLUmxR/6e/WuTFiITBZqtMc/OfJO+agaOGC2UzUJEl8/oGhbha
         nttyAK1lsN7Rpt+6ErSsvpMg/hemdcqhUuESLug0g//5+AaQ/h4zv1o/bwWG/PGNynOj
         SuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=oF1Dvsn6T9aQ43p6FtHzXNZdEVZ4JbUxCppQHO2d5tE=;
        b=IJe15i45ZS7NwYUqFnLu/Hhfl0a0l5Hc5fBocO/Ok00D00bAIMHoZG/m1we5xTX9z6
         U3O3wzjPqDatopszQYAlmuHjlKfAdbs29r5H2t1e+5bjhZyJdgEdN4KPdgfZERgZx7cz
         1uwZQdgdAp9lDkOJP0bDWtIpPMOqQbtZomXhzG1LS7BWv1/yY2Vs5YAqDHZnwqqXQSx5
         tWwswIv76oPKW6dgmZFoZggbNOFHbgMAjyiRr9OkGsr8cPmZn91Mtum+LQDy3BNjLr3L
         EkgADCKVTHk7L+l9YGc56s9k2Wzxqd5VeCjArWFubIG38UZweJnr0Lc0+LbFSy6tg/WL
         V91g==
X-Gm-Message-State: AKGB3mJH/pPCBMnNIZvR/hMVyt1kOcn15t/JNz6fZFRLdZo7qlnQRvtp
        3f9QVGz0ZRucygslwtjDD9KdAOhqifWEOX/IrnM=
X-Google-Smtp-Source: ACJfBoupAtRFw2rD5glxWgL9Im39cR1N7T1/74BN/cKEPsWW0Uvp+JffvGNB+wwd5HQyLl2Uy9nGKE0ReoQC61bJApo=
X-Received: by 10.55.212.204 with SMTP id s73mr2274151qks.142.1514996099668;
 Wed, 03 Jan 2018 08:14:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.33.208 with HTTP; Wed, 3 Jan 2018 08:14:59 -0800 (PST)
In-Reply-To: <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com> <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
 <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jan 2018 17:14:59 +0100
X-Google-Sender-Auth: XmZbrjTGIM5ekE0HLckVzGksStI
Message-ID: <CAK8P3a3i0bKvG56ha9_hzO=z80sVxCQhaeFn6QW3AwbwZs3HPg@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
To:     christophe leroy <christophe.leroy@c-s.fr>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ysxie@foxmail.com, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        alsa-devel@alsa-project.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        industrypack-devel@lists.sourceforge.net, wg@grandegger.com,
        mkl@pengutronix.de, linux-can@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        devel@driverdev.osuosl.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Miller <davem@davemloft.net>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        Networking <netdev@vger.kernel.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61890
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

On Sun, Dec 24, 2017 at 9:55 AM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
> Le 23/12/2017 à 16:57, Guenter Roeck a écrit :
>>
>> On 12/23/2017 05:48 AM, Greg KH wrote:
>>>
>>> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>>>>
>>>> Hi all,
>>>>
>>>> When I tried to use devm_ioremap function and review related code, I
>>>> found
>>>> devm_ioremap and devm_ioremap_nocache is almost the same with each
>>>> other,
>>>> except one use ioremap while the other use ioremap_nocache.
>>>
>>>
>>> For all arches?  Really?  Look at MIPS, and x86, they have different
>>> functions.
>>>
>>
>> Both mips and x86 end up mapping the same function, but other arches
>> don't.
>> mn10300 is one where ioremap and ioremap_nocache are definitely different.
>
>
> alpha: identical
> arc: identical
> arm: identical
> arm64: identical
> cris: different        <==
> frv: identical
> hexagone: identical
> ia64: different        <==
> m32r: identical
> m68k: identical
> metag: identical
> microblaze: identical
> mips: identical
> mn10300: different     <==
> nios: identical
> openrisc: different    <==
> parisc: identical
> riscv: identical
> s390: identical
> sh: identical
> sparc: identical
> tile: identical
> um: rely on asm/generic
> unicore32: identical
> x86: identical
> asm/generic (no mmu): identical
>
> So 4 among all arches seems to have ioremap() and ioremap_nocache() being
> different.
>
> Could we have a define set by the 4 arches on which ioremap() and
> ioremap_nocache() are different, something like
> HAVE_DIFFERENT_IOREMAP_NOCACHE ?

I wonder if those are actually correct or not. What I found looking at
those architectures:

- openrisc only has one driver using ioremap (drivers/net/ethernet/ethoc.c)
  and that calls ioremap_nocache(). Presumably the authors went with the
  implementation for ioremap that made sense (using default attributes)
  rather than the one that actually works (using uncached).

- On ia64, ioremap() checks the attributes for the physical
  address based on firmware tables and then picks either cached
  or uncached mappings. ioremap_nocache() does the same but
  returns NULL instead of a cached mapping for anything that is
  not an MMIO address. Presumably it would just work to always
  call ioremap().

- mn10300 appears to be wrong, broken by David Howells in
  commit 83c2dc15ce82 ("MN10300: Handle cacheable PCI regions
  in pci_iomap()") for any driver calling ioremap() by to get uncached
  memory, if I understand the comment for commit 34f1bdee1910
   ("mn10300: switch to GENERIC_PCI_IOMAP") correctly: it
  seems that PCI addresses include the 'uncached' bit by default
  to get the right behavior, but dropping that bit breaks it.

- cris seems similar to mn10300 in hardware, using an phys address
  bit for uncached access. There are two callers in arch code that
  appear to rely on the cachable output of ioremap()
arch/cris/arch-v32/kernel/signal.c:
__ioremap_prot(virt_to_phys(data), PAGE_SIZE, PAGE_SIGNAL_TRAMPOLINE);
arch/cris/arch-v32/mm/intmem.c:         intmem_virtual =
ioremap(MEM_INTMEM_START + RESERVED_SIZE,
  It's unclear whether ioremap_nocache() actually has any users
  on cris, or whether it was only added for compile-time testing,
  and calling plain ioremap() would always work too (assuming we
  pass the phys address with the uncached-bit set).

       Arnd
