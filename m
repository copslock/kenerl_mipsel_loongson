Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2011 03:44:17 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33078 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491757Ab1AKCoN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jan 2011 03:44:13 +0100
Received: by fxm19 with SMTP id 19so18899870fxm.36
        for <multiple recipients>; Mon, 10 Jan 2011 18:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2u0SHAv+sQu1Gj2LvqEeVOICJ4LXMgir301C60Bi874=;
        b=e1q9q3jTNnlB8Wk0N+UMV6ky2/yH1irKY4Wmnm1EG62I+vjXG0EK1lxCtOUT/sYXiZ
         1pZwi5cAmZ8ejmpk8I9IXVGHqK6ekB8LNYNhhJIRvrGG+1MpJWMgagPivPKyFn6Qrfp8
         Td4qBeHthJYPaWJ/lU5kJ07hh0OGtmZ3e7/bM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=CMT2EP363u6haBqrXQbKi7vm+at+fb9MftD/ZqQb42kwvJbvwgJoJg0m30FElb9kKm
         +qO683sLEn5dAj1WGmh3Je+88vG8WS5dnOXbCN/MsvWHy9erZVU/MB5+XGc4Lo1GkMcb
         uMKqWv+rf01wqvR77toHXSCjd8PLHSGnv3BS8=
Received: by 10.223.98.200 with SMTP id r8mr149865fan.30.1294713847181;
        Mon, 10 Jan 2011 18:44:07 -0800 (PST)
Received: from [192.168.100.100] (dslb-088-073-242-094.pools.arcor-ip.net [88.73.242.94])
        by mx.google.com with ESMTPS id 17sm7213461far.43.2011.01.10.18.44.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 18:44:06 -0800 (PST)
Message-ID: <4D2BC3F7.3080006@gmail.com>
Date:   Tue, 11 Jan 2011 03:44:07 +0100
From:   Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 00/10] MIPS: add support for Lantiq SoCs
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1294257379-417-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.schwierzeck@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi John,

after the 2.6.36 release i've started the same upstream project. I'm 
hacking software for CPE's with Danube and VRX SoC's thus I have full 
access to hardware manuals and latest BSP's. Maybe we should merge our 
code somehow ;)

Daniel

On 01/05/2011 08:56 PM, John Crispin wrote:
> This series will add support for the Lantiq/XWAY family of SoCs.
>
> Cc: Ralph Hempel<ralph.hempel@lantiq.com>
> Cc: linux-mips@linux-mips.org
>
> John Crispin (10):
>    MIPS: lantiq: add initial support for Lantiq SoCs
>    MIPS: lantiq: add SoC specific code for XWAY family
>    MIPS: lantiq: add PCI controller support.
>    MIPS: lantiq: add serial port support
>    MIPS: lantiq: add watchdog support
>    MIPS: lantiq: add NOR flash support
>    MIPS: lantiq: add NOR flash CFI address swizzle
>    MIPS: lantiq: add platform device support
>    MIPS: lantiq: add mips_machine support
>    MIPS: lantiq: add machtypes for lantiq eval kits
>
>   arch/mips/Kbuild.platforms                         |    1 +
>   arch/mips/Kconfig                                  |   18 +
>   arch/mips/include/asm/mach-lantiq/lantiq.h         |   48 ++
>   .../mips/include/asm/mach-lantiq/lantiq_platform.h |   25 +
>   arch/mips/include/asm/mach-lantiq/war.h            |   24 +
>   arch/mips/include/asm/mach-lantiq/xway/irq.h       |   18 +
>   .../mips/include/asm/mach-lantiq/xway/lantiq_irq.h |   62 ++
>   .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |  119 +++
>   arch/mips/lantiq/Kconfig                           |   23 +
>   arch/mips/lantiq/Makefile                          |   11 +
>   arch/mips/lantiq/Platform                          |    8 +
>   arch/mips/lantiq/clk.c                             |  129 ++++
>   arch/mips/lantiq/clk.h                             |   18 +
>   arch/mips/lantiq/devices.c                         |  127 ++++
>   arch/mips/lantiq/devices.h                         |   20 +
>   arch/mips/lantiq/early_printk.c                    |   47 ++
>   arch/mips/lantiq/irq.c                             |  209 ++++++
>   arch/mips/lantiq/machtypes.h                       |   20 +
>   arch/mips/lantiq/prom.c                            |   84 +++
>   arch/mips/lantiq/prom.h                            |   26 +
>   arch/mips/lantiq/setup.c                           |   70 ++
>   arch/mips/lantiq/xway/Kconfig                      |   25 +
>   arch/mips/lantiq/xway/Makefile                     |    7 +
>   arch/mips/lantiq/xway/clk-ase.c                    |   53 ++
>   arch/mips/lantiq/xway/clk-xway.c                   |  221 ++++++
>   arch/mips/lantiq/xway/devices.c                    |   55 ++
>   arch/mips/lantiq/xway/devices.h                    |   16 +
>   arch/mips/lantiq/xway/gpio.c                       |  205 ++++++
>   arch/mips/lantiq/xway/mach-easy50601.c             |   70 ++
>   arch/mips/lantiq/xway/mach-easy50712.c             |   70 ++
>   arch/mips/lantiq/xway/pmu.c                        |   36 +
>   arch/mips/lantiq/xway/prom-ase.c                   |   41 +
>   arch/mips/lantiq/xway/prom-xway.c                  |   56 ++
>   arch/mips/lantiq/xway/reset.c                      |   53 ++
>   arch/mips/pci/Makefile                             |    1 +
>   arch/mips/pci/ops-lantiq.c                         |  118 +++
>   arch/mips/pci/pci-lantiq.c                         |  286 ++++++++
>   arch/mips/pci/pci-lantiq.h                         |   18 +
>   drivers/mtd/chips/Kconfig                          |    9 +
>   drivers/mtd/chips/cfi_cmdset_0002.c                |    8 +
>   drivers/mtd/maps/Kconfig                           |    7 +
>   drivers/mtd/maps/Makefile                          |    1 +
>   drivers/mtd/maps/lantiq.c                          |  169 +++++
>   drivers/serial/Kconfig                             |    8 +
>   drivers/serial/Makefile                            |    1 +
>   drivers/serial/lantiq.c                            |  774 ++++++++++++++++++++
>   drivers/watchdog/Kconfig                           |    6 +
>   drivers/watchdog/Makefile                          |    1 +
>   drivers/watchdog/lantiq_wdt.c                      |  208 ++++++
>   49 files changed, 3630 insertions(+), 0 deletions(-)
>   create mode 100644 arch/mips/include/asm/mach-lantiq/lantiq.h
>   create mode 100644 arch/mips/include/asm/mach-lantiq/lantiq_platform.h
>   create mode 100644 arch/mips/include/asm/mach-lantiq/war.h
>   create mode 100644 arch/mips/include/asm/mach-lantiq/xway/irq.h
>   create mode 100644 arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
>   create mode 100644 arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
>   create mode 100644 arch/mips/lantiq/Kconfig
>   create mode 100644 arch/mips/lantiq/Makefile
>   create mode 100644 arch/mips/lantiq/Platform
>   create mode 100644 arch/mips/lantiq/clk.c
>   create mode 100644 arch/mips/lantiq/clk.h
>   create mode 100644 arch/mips/lantiq/devices.c
>   create mode 100644 arch/mips/lantiq/devices.h
>   create mode 100644 arch/mips/lantiq/early_printk.c
>   create mode 100644 arch/mips/lantiq/irq.c
>   create mode 100644 arch/mips/lantiq/machtypes.h
>   create mode 100644 arch/mips/lantiq/prom.c
>   create mode 100644 arch/mips/lantiq/prom.h
>   create mode 100644 arch/mips/lantiq/setup.c
>   create mode 100644 arch/mips/lantiq/xway/Kconfig
>   create mode 100644 arch/mips/lantiq/xway/Makefile
>   create mode 100644 arch/mips/lantiq/xway/clk-ase.c
>   create mode 100644 arch/mips/lantiq/xway/clk-xway.c
>   create mode 100644 arch/mips/lantiq/xway/devices.c
>   create mode 100644 arch/mips/lantiq/xway/devices.h
>   create mode 100644 arch/mips/lantiq/xway/gpio.c
>   create mode 100644 arch/mips/lantiq/xway/mach-easy50601.c
>   create mode 100644 arch/mips/lantiq/xway/mach-easy50712.c
>   create mode 100644 arch/mips/lantiq/xway/pmu.c
>   create mode 100644 arch/mips/lantiq/xway/prom-ase.c
>   create mode 100644 arch/mips/lantiq/xway/prom-xway.c
>   create mode 100644 arch/mips/lantiq/xway/reset.c
>   create mode 100644 arch/mips/pci/ops-lantiq.c
>   create mode 100644 arch/mips/pci/pci-lantiq.c
>   create mode 100644 arch/mips/pci/pci-lantiq.h
>   create mode 100644 drivers/mtd/maps/lantiq.c
>   create mode 100644 drivers/serial/lantiq.c
>   create mode 100644 drivers/watchdog/lantiq_wdt.c
>
