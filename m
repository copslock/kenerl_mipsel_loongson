Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 19:16:57 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:46167 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492096Ab0KWSQx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 19:16:53 +0100
Received: by pzk30 with SMTP id 30so172766pzk.36
        for <multiple recipients>; Tue, 23 Nov 2010 10:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cbEqD6tWpt7OHei3GR/PlE+lPtfW/20p2X7n86d4cAM=;
        b=bdOt8rpue28iBpOAEX+ak467Oh4OslPVgVsJwY2JVY034xRbctLKG39QWly6hCe+y2
         fDr0wo3KC+YdogKlRFWlKTp2UyHT5LBxRY1HfPulRz2OuG7EPDkIl0ox8E7YlPD84fbw
         3Orehd2YZhwXbvO7dN6z4pwmUNiBx2e9hoH5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BPcxCV5G4EwTWCKKVGgx17m9v4On+xejRAM+yfuGB6PcAJq96hBTyCJ+kPcPHltTWT
         zT3a0ZyDoY8oF5PbhKeLmQn0S1sQCIrZEr9d8CsN4Z8oamm6bJ+WkTPZuZg3XgCl3ton
         1xiALjUgSFqjBjOodM80GOKavJ1lUNU71gie4=
MIME-Version: 1.0
Received: by 10.229.184.8 with SMTP id ci8mr6616642qcb.72.1290536204938; Tue,
 23 Nov 2010 10:16:44 -0800 (PST)
Received: by 10.229.182.3 with HTTP; Tue, 23 Nov 2010 10:16:44 -0800 (PST)
In-Reply-To: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
Date:   Tue, 23 Nov 2010 13:16:44 -0500
Message-ID: <AANLkTi=qvMHZu7xZz8Rjr2TcKZj0rNKsKZz6D8Re0_0T@mail.gmail.com>
Subject: Re: [PATCH 00/18] MIPS: initial support for the Atheros
 AR71XX/AR724X/AR913X SoCs
From:   Arnaud Lacombe <lacombar@gmail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <lacombar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lacombar@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> This patch set contains initial support for the
> Atheros AR71XX/AR724X/AR913X SoCs.
>
Could you maybe describe what changed between the first submission and
this serie ? AFAIK, there has been private review/discussions going
on, so this would give a hit of the evolution.

Thanks,
 - Arnaud

> Gabor Juhos (18):
>  MIPS: add initial support for the Atheros AR71XX/AR724X/AR931X SoCs
>  MIPS: ath79: add GPIOLIB support
>  MIPS: add generic support for multiple machines within a single
>    kernel
>  MIPS: ath79: utilize the MIPS multi-machine support
>  MIPS: ath79: add initial support for the Atheros PB44 reference board
>  MIPS: ath79: add common GPIO LEDs device
>  watchdog: add driver for the Atheros AR71XX/AR724X/AR913X SoCs
>  MIPS: ath79: add common watchdog device
>  input: add input driver for polled GPIO buttons
>  MIPS: ath79: add common GPIO buttons device
>  spi: add SPI controller driver for the Atheros AR71XX/AR724X/AR913X
>    SoCs
>  MIPS: ath79: add common SPI controller device
>  USB: ehci: add workaround for Synopsys HC bug
>  USB: ehci: add bus glue for the Atheros AR71XX/AR724X/AR913X SoCs
>  USB: ohci: add bus glue for the Atheros AR71XX/AR7240 SoCs
>  MIPS: ath79: add common USB Host Controller device
>  MIPS: ath79: add initial support for the Atheros AP81 reference board
>  MIPS: ath79: add common WMAC device for AR913X based boards
>
>  arch/mips/Kbuild.platforms                         |    1 +
>  arch/mips/Kconfig                                  |   20 ++
>  arch/mips/ath79/Kconfig                            |   60 ++++
>  arch/mips/ath79/Makefile                           |   29 ++
>  arch/mips/ath79/Platform                           |    7 +
>  arch/mips/ath79/common.c                           |  113 ++++++++
>  arch/mips/ath79/common.h                           |   67 +++++
>  arch/mips/ath79/dev-ar913x-wmac.c                  |   60 ++++
>  arch/mips/ath79/dev-ar913x-wmac.h                  |   17 ++
>  arch/mips/ath79/dev-common.c                       |   69 +++++
>  arch/mips/ath79/dev-common.h                       |   18 ++
>  arch/mips/ath79/dev-gpio-buttons.c                 |   58 ++++
>  arch/mips/ath79/dev-gpio-buttons.h                 |   23 ++
>  arch/mips/ath79/dev-leds-gpio.c                    |   56 ++++
>  arch/mips/ath79/dev-leds-gpio.h                    |   21 ++
>  arch/mips/ath79/dev-spi.c                          |   38 +++
>  arch/mips/ath79/dev-spi.h                          |   22 ++
>  arch/mips/ath79/dev-usb.c                          |  192 +++++++++++++
>  arch/mips/ath79/dev-usb.h                          |   17 ++
>  arch/mips/ath79/early_printk.c                     |   36 +++
>  arch/mips/ath79/gpio.c                             |  196 +++++++++++++
>  arch/mips/ath79/irq.c                              |  187 +++++++++++++
>  arch/mips/ath79/mach-ap81.c                        |   98 +++++++
>  arch/mips/ath79/mach-pb44.c                        |  119 ++++++++
>  arch/mips/ath79/machtypes.h                        |   23 ++
>  arch/mips/ath79/prom.c                             |   57 ++++
>  arch/mips/ath79/setup.c                            |  279 +++++++++++++++++++
>  arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |  248 +++++++++++++++++
>  arch/mips/include/asm/mach-ath79/ath79.h           |   50 ++++
>  .../include/asm/mach-ath79/ath79_ehci_platform.h   |   18 ++
>  .../include/asm/mach-ath79/ath79_spi_platform.h    |   19 ++
>  .../include/asm/mach-ath79/cpu-feature-overrides.h |   56 ++++
>  arch/mips/include/asm/mach-ath79/gpio.h            |   26 ++
>  arch/mips/include/asm/mach-ath79/irq.h             |   36 +++
>  .../include/asm/mach-ath79/kernel-entry-init.h     |   32 +++
>  arch/mips/include/asm/mach-ath79/war.h             |   25 ++
>  arch/mips/include/asm/mips_machine.h               |   54 ++++
>  arch/mips/kernel/Makefile                          |    1 +
>  arch/mips/kernel/mips_machine.c                    |   86 ++++++
>  arch/mips/kernel/proc.c                            |    7 +-
>  arch/mips/kernel/vmlinux.lds.S                     |    7 +
>  drivers/input/misc/Kconfig                         |   16 +
>  drivers/input/misc/Makefile                        |    1 +
>  drivers/input/misc/gpio_buttons.c                  |  232 ++++++++++++++++
>  drivers/spi/Kconfig                                |    8 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/ath79_spi.c                            |  290 +++++++++++++++++++
>  drivers/usb/host/Kconfig                           |   16 +
>  drivers/usb/host/ehci-ath79.c                      |  176 ++++++++++++
>  drivers/usb/host/ehci-hcd.c                        |    5 +
>  drivers/usb/host/ehci-q.c                          |    3 +
>  drivers/usb/host/ehci.h                            |    1 +
>  drivers/usb/host/ohci-ath79.c                      |  162 +++++++++++
>  drivers/usb/host/ohci-hcd.c                        |    5 +
>  drivers/watchdog/Kconfig                           |    8 +
>  drivers/watchdog/Makefile                          |    1 +
>  drivers/watchdog/ath79_wdt.c                       |  293 ++++++++++++++++++++
>  include/linux/gpio_buttons.h                       |   33 +++
>  58 files changed, 3798 insertions(+), 1 deletions(-)
>  create mode 100644 arch/mips/ath79/Kconfig
>  create mode 100644 arch/mips/ath79/Makefile
>  create mode 100644 arch/mips/ath79/Platform
>  create mode 100644 arch/mips/ath79/common.c
>  create mode 100644 arch/mips/ath79/common.h
>  create mode 100644 arch/mips/ath79/dev-ar913x-wmac.c
>  create mode 100644 arch/mips/ath79/dev-ar913x-wmac.h
>  create mode 100644 arch/mips/ath79/dev-common.c
>  create mode 100644 arch/mips/ath79/dev-common.h
>  create mode 100644 arch/mips/ath79/dev-gpio-buttons.c
>  create mode 100644 arch/mips/ath79/dev-gpio-buttons.h
>  create mode 100644 arch/mips/ath79/dev-leds-gpio.c
>  create mode 100644 arch/mips/ath79/dev-leds-gpio.h
>  create mode 100644 arch/mips/ath79/dev-spi.c
>  create mode 100644 arch/mips/ath79/dev-spi.h
>  create mode 100644 arch/mips/ath79/dev-usb.c
>  create mode 100644 arch/mips/ath79/dev-usb.h
>  create mode 100644 arch/mips/ath79/early_printk.c
>  create mode 100644 arch/mips/ath79/gpio.c
>  create mode 100644 arch/mips/ath79/irq.c
>  create mode 100644 arch/mips/ath79/mach-ap81.c
>  create mode 100644 arch/mips/ath79/mach-pb44.c
>  create mode 100644 arch/mips/ath79/machtypes.h
>  create mode 100644 arch/mips/ath79/prom.c
>  create mode 100644 arch/mips/ath79/setup.c
>  create mode 100644 arch/mips/include/asm/mach-ath79/ar71xx_regs.h
>  create mode 100644 arch/mips/include/asm/mach-ath79/ath79.h
>  create mode 100644 arch/mips/include/asm/mach-ath79/ath79_ehci_platform.h
>  create mode 100644 arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
>  create mode 100644 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
>  create mode 100644 arch/mips/include/asm/mach-ath79/gpio.h
>  create mode 100644 arch/mips/include/asm/mach-ath79/irq.h
>  create mode 100644 arch/mips/include/asm/mach-ath79/kernel-entry-init.h
>  create mode 100644 arch/mips/include/asm/mach-ath79/war.h
>  create mode 100644 arch/mips/include/asm/mips_machine.h
>  create mode 100644 arch/mips/kernel/mips_machine.c
>  create mode 100644 drivers/input/misc/gpio_buttons.c
>  create mode 100644 drivers/spi/ath79_spi.c
>  create mode 100644 drivers/usb/host/ehci-ath79.c
>  create mode 100644 drivers/usb/host/ohci-ath79.c
>  create mode 100644 drivers/watchdog/ath79_wdt.c
>  create mode 100644 include/linux/gpio_buttons.h
>
> --
> 1.7.2.1
>
>
