Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 18:42:58 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:51093 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006877AbaHZQm5P84F8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Aug 2014 18:42:57 +0200
Received: by mail-ig0-f182.google.com with SMTP id c1so4775951igq.3
        for <linux-mips@linux-mips.org>; Tue, 26 Aug 2014 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=qZfOZxNSDmXmHdePSdBE2xJk5dxrcw160+76YATY8z8=;
        b=RVYh9uEMAPiygxbBz4BwtK8JYg6o0/yOrcxNx+QX1VTEZpmZslpTKkvn4seHiocmOl
         9eDNfTpQ1Nv7LnLea4a6lgDjFQHP86KP9oq2SlIKCDcZqxQYrnXC2HEBXdI/kBJ5bQoO
         F6yhyPDI5boyerP/TskxBQ6IiaYF7DalHmCD3KCiLRChjtIQjnqWBEjnRp6uG3e9TVRD
         7JLtZOPQTh0bE/borZVUzj5JTKCVez+0R25Ea9+j2dWgTZq43UYIaTgbyoOov56no/Di
         CstVl+4dUo5zF9bl0wy50p29PBQBRc9cckdnkldPfAf3X4NLOJKV30PVELeTVFNJJwYG
         1T9Q==
MIME-Version: 1.0
X-Received: by 10.42.107.145 with SMTP id d17mr8725807icp.61.1409071371102;
 Tue, 26 Aug 2014 09:42:51 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Tue, 26 Aug 2014 09:42:51 -0700 (PDT)
Date:   Tue, 26 Aug 2014 18:42:51 +0200
Message-ID: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
Subject: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

[cross-list: linux-mips@ and linux-wireless@]

We're working on another Broadcom platform, SoC with an ARM CPU,
platform called bcm53xx. It shares many things with the older (MIPS
based) bcm47xx, so we need to figure out how to modify some of the
drivers.

Hauke recently proposed sharing code for NVRAM support as a separated
driver. In his RFC patch it was added as a new platform driver. I
liked this idea (I'd simply prefer to modify existing code instead of
duplicating it), so I played with it a bit today.

My plan was to modify bcm47xx code to make nvram.c a separated driver
and update bcm47xx/bcma to use it. Well, it didn't work out. The
problem is that we need access to the NVRAM pretty early. Please take
a look at my description of bcm47xx booting process (it's simply a
summary of start_kernel and bcm47xx code):

1) prom_init / plat_mem_setup
These two functions are called in pretty much the same phase from the
setup_arch (arch/mips/kernel/setup.c).
Task: detect & register memory
Requires: CPU type, maybe Broadcom chip ID (highmem support)
Available: CPU type
Not available: kmalloc, device_add (kobject)

2) arch_init_irq
Called from the arch specific init_IRQ (arch/mips/kernel/irq.c)
Task: setup bcma's MIPS core
Requires: bcma bus MIPS core
Available: kmalloc
Not available: device_add (kobject)

3) plat_time_init
Called from the arch specific time_init (arch/mips/kernel/time.c)
Task: set frequency
Requires: bcma bus ChipCommon core, nvram
Available: kmalloc
Not available: device_add (kobject)

4) At some point we need to register bcma devices, device_initcall can
be used for that

As you can see, we need access to the NVRAM quite early (step 3,
plat_time_init, or even earlier), but device_add (platform
devices/drivers) is not available then yet. So I'm afraid we won't be
able to use this common way to write NVRAM driver.


So there I want to present my plan for the NVRAM improvements. If you
don't agree with any part of it, or you can see any better solution,
please speak up!

1) I won't make nvram.c a platform driver. Instead I would like to
make it less bcm47xx specific. I don't want to touch bcm47xx_bus in
this file. Instead I want to add a generic function that will accept
address and size of memory where NVRAM should be found. Then I'd like
to move this file out of "mips" arch (drivers/misc/?
drivers/bcma/nvram/?) and allow using it for bcm53xx.

2) I was also thinking about cleaning bcm47xx init. Right now we do a
lot of hacks in plat_mem_setup & bcma to register the bus and scan its
cores. It's so early (before mm_init) that we can't alloc memory!
Doing all this stuff slightly later (e.g. arch_init_irq) would allow
us to simply use "kmalloc" and drop all current hacks in bcma.

3) Above change (point 2) would require some small change in bcma. We
would need 2-stages init: detecting (with kmalloc!) bus cores,
registering cores. This is required, because we can't register cores
too early, device_add (and the underlying kobject) would oops/WARN in
kobject_get.

-- 
Rafał
