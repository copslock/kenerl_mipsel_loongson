Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2017 23:14:41 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:35957
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992881AbdDQVOewufjN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2017 23:14:34 +0200
Received: by mail-wm0-x242.google.com with SMTP id q125so11165767wmd.3;
        Mon, 17 Apr 2017 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3sqQ3KKTsfIcPO9XNu43rDpWMbfXEjL6mLeRFdXwaM8=;
        b=WCzrfrBKbuNuYxl08xLcw8CgT6Kj8lq4vt+06FA6TQ6AKOpko7Yx7napmmtFnwmM4A
         L+8APgdFjtrYIYMz/0N25ngPbiLvtAh1VtUp2O7QkCm2pyhJKcb0FoeCOdMXBjqQ2y1h
         731j06Bgney161R8pI6LrK/pCbK4IJ11kdqbtNJ9X57ENooAnPHXYQcXH3L6FMbGSuO8
         xJJ49R5X9R2dQTeTFPJmFupZda4wbLPkm+brfkVst246VK5aC5ZmzeAeZjX2OqKDfY9V
         s5abFvw9LRiMwX8TXHqEj+ZivHB3vfykC6JqBsWcFDQbgWFOidr6NCvnMkS4zVNtXksL
         04+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3sqQ3KKTsfIcPO9XNu43rDpWMbfXEjL6mLeRFdXwaM8=;
        b=gL+oL3tgtfF9w6RWuM0/1pUiZC3fd25v+EL31XsUhdSMi051XGu7npq9rYRufp9H5/
         qXNWd9HZBVlW5Clez9NQobBVHmJYOOnSZR4augOQBIcxGkY1LhsKMRKIACwIyEwKoDCD
         JOs1HHRr1DCVQs8DjNG5wCh3YD1XWMnWv3Og5BqMLMDVJoPYvblu6+GLsO+gTLVhwGKv
         KK6V67dNspsGswCSyWSI2a1zYAsii9dxeBX6xi1LnMNW63h4Z+f6D2gWhVqJn7WzPdWY
         eFF2OSCKEAOWE05lHGFVWf34946+pP/y9Sihg/42QsLqMG6DoD9KA9S92qwMC/lbTzDE
         wbxQ==
X-Gm-Message-State: AN3rC/7s7RlH1f1p2L05zmV56mZouwxYskdhdv+4g+3cgVi62kkUDQou
        fk1j0Wu3ZAS7RMyjqhdFDYikxTCdew==
X-Received: by 10.28.27.72 with SMTP id b69mr10060842wmb.34.1492463668481;
 Mon, 17 Apr 2017 14:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.166.80 with HTTP; Mon, 17 Apr 2017 14:14:08 -0700 (PDT)
In-Reply-To: <20170417192942.32219-1-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 17 Apr 2017 23:14:08 +0200
Message-ID: <CAFBinCCTmOh17bAc-4LbiZJrAy+mKjtC5giS3rB5asw-T8PR2g@mail.gmail.com>
Subject: Re: [PATCH 00/13] MIPS: lantiq: handle RCU register by separate drivers
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

Hi Hauke,

On Mon, Apr 17, 2017 at 9:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> The RCU (Reset controller Unit) register block provides many different
> functionalities. Before they were handed by the code in arch/mips/lantiq
> /xway/reset.c, now there are separate drivers for the functionality.
> This block provides support for reset controller, GPHY firmware
> loading, USB PHY initialization and cross bar configuration.
>
> These changes are making the old device tree incompatible with the
> current kernel. The upstream Linux kernel supports loading the device
> tree blob from the boot loader since about one year, the latest
> released vendor kernel does not support loading the device tree from a
> bot loader.
great to see that you could use my work :-)

> I would prefer if this would go through the mips tree.
> There are more patches planed which would convert the Lantiq code
> to the common clock framework.
>
> Hauke Mehrtens (4):
>   mtd: lantiq-flash: drop check of boot select
>   mtd: spi-falcon: drop check of boot select
>   watchdog: lantiq: access boot cause register through regmap
>   MIPS: lantiq: remove old GPHY loader code
>
> Martin Blumenstingl (9):
>   MIPS: lantiq: Use of_platform_populate instead of __dt_register_buses
>   MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD
>   MIPS: lantiq: Convert the xbar driver to a platform_driver
>   MIPS: lantiq: remove ltq_reset_cause() and ltq_boot_select()
>   reset: Add a reset controller driver for the Lantiq XWAY based SoCs
>   MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd
>   phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module
>   Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
>   MIPS: lantiq: Remove the arch/mips/lantiq/xway/reset.c implementation
if anyone is wondering:
I started porting the lantiq target to the common clock framework
"some" time ago. unfortunately it turned out that some of the
"drivers" are tightly coupled and one cannot simply port the clock
handling to the common clock framework. so I started tackling more
drivers in arch/mips/lantiq/ until I had a huge pile of patches in my
tree but no time to improve them so they were ready to submit. so the
patches from Hauke are roughly based on the ideas of my patches (and
probably a few lines of code here and there).


>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  54 +++
>  .../devicetree/bindings/mips/lantiq/rcu.txt        |  82 +++++
>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 ++
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  59 ++++
>  .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  43 +++
>  MAINTAINERS                                        |   1 +
>  arch/mips/include/asm/mach-lantiq/lantiq.h         |   4 -
>  arch/mips/lantiq/Kconfig                           |   2 +
>  arch/mips/lantiq/falcon/reset.c                    |  22 --
>  arch/mips/lantiq/prom.c                            |   3 +-
>  arch/mips/lantiq/xway/Makefile                     |   4 +-
>  arch/mips/lantiq/xway/reset.c                      | 387 ---------------------
>  arch/mips/lantiq/xway/sysctrl.c                    |  69 +---
>  arch/mips/lantiq/xway/xrx200_phy_fw.c              | 113 ------
>  drivers/mtd/maps/lantiq-flash.c                    |   6 -
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 325 +++++++++++++++++
>  drivers/reset/Kconfig                              |   6 +
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-lantiq-rcu.c                   | 231 ++++++++++++
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/lantiq/Makefile                        |   2 +
>  drivers/soc/lantiq/gphy.c                          | 242 +++++++++++++
>  drivers/soc/lantiq/xbar.c                          | 100 ++++++
>  drivers/spi/spi-falcon.c                           |   5 -
>  drivers/watchdog/lantiq_wdt.c                      |  47 ++-
>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 +
>  28 files changed, 1255 insertions(+), 600 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>  delete mode 100644 arch/mips/lantiq/xway/reset.c
>  delete mode 100644 arch/mips/lantiq/xway/xrx200_phy_fw.c
>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>  create mode 100644 drivers/reset/reset-lantiq-rcu.c
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/gphy.c
>  create mode 100644 drivers/soc/lantiq/xbar.c
>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h
>
> --
> 2.11.0
>
