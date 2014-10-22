Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 15:06:36 +0200 (CEST)
Received: from mail-yh0-f54.google.com ([209.85.213.54]:40046 "EHLO
        mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012036AbaJVNGejEp-D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 15:06:34 +0200
Received: by mail-yh0-f54.google.com with SMTP id 29so3764376yhl.27
        for <multiple recipients>; Wed, 22 Oct 2014 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uxYWoWF5GdRPXVGP1OJrIuPdP56ylymCHgu/I5NeW2E=;
        b=YJsT4otD0TW5Ji0FjujkusnsRYmvc9pfmZZ+QCHDocUMB1XSfLXKLFZVOwVVzpYeZl
         CGz58bYsHaQdZrKfixEAiN+Okk0Z9bbWzC91QhqPRKKsK2/8HQumO6WV6cS+NIGZRFPz
         m88Q/eXvnkdFqdb5omZ/F/P+M+d3qmMD9H4MwDBw9tXuG8JE2+MyPUgpHBCa5dqoXmfc
         LvYAoUn/wOyvMDCQw6l/8iCdbHa3iKmu8b5lTv7Xl8GjEe+4Ghe9e1/VeAVbCu/DVVCm
         vwb/FQbwOzCtkG5TbeO/dVSD1DXI4Rqsuj9UQ6W+PxZTQuBNNsvURWCJN5un14B02LQC
         R/Cw==
X-Received: by 10.236.31.33 with SMTP id l21mr59231652yha.14.1413983188662;
 Wed, 22 Oct 2014 06:06:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Wed, 22 Oct 2014 06:06:08 -0700 (PDT)
In-Reply-To: <54476B7D.3030700@openwrt.org>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-2-git-send-email-ryazanov.s.a@gmail.com> <54476B7D.3030700@openwrt.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 22 Oct 2014 17:06:08 +0400
Message-ID: <CAHNKnsSp06s9uMC8_2=HprywzfS=oJnGwVNf5LOa+=pZqry+Fw@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] MIPS: ath25: add common parts
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-10-22 12:31 GMT+04:00 John Crispin <blogic@openwrt.org>:
> On 22/10/2014 01:03, Sergey Ryazanov wrote:
>> Add common code for Atheros AR5312 and Atheros AR2315 SoCs families.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> ---
>>
>> Changes since v1:
>>   - rename MIPS machine ar231x -> ath25
>>
>>  arch/mips/Kbuild.platforms                         |  1 +
>>  arch/mips/Kconfig                                  | 13 ++++
>>  arch/mips/ath25/Makefile                           | 11 ++++
>>  arch/mips/ath25/Platform                           |  6 ++
>>  arch/mips/ath25/board.c                            | 53 +++++++++++++++
>>  arch/mips/ath25/devices.c                          | 11 ++++
>>  arch/mips/ath25/devices.h                          | 16 +++++
>>  arch/mips/ath25/prom.c                             | 26 ++++++++
>>  arch/mips/include/asm/mach-ath25/ath25.h           | 29 +++++++++
>>  .../include/asm/mach-ath25/cpu-feature-overrides.h | 76 ++++++++++++++++++++++
>>  arch/mips/include/asm/mach-ath25/dma-coherence.h   | 64 ++++++++++++++++++
>>  arch/mips/include/asm/mach-ath25/gpio.h            | 16 +++++
>>  arch/mips/include/asm/mach-ath25/war.h             | 25 +++++++
>>  13 files changed, 347 insertions(+)
>>  create mode 100644 arch/mips/ath25/Makefile
>>  create mode 100644 arch/mips/ath25/Platform
>>  create mode 100644 arch/mips/ath25/board.c
>>  create mode 100644 arch/mips/ath25/devices.c
>>  create mode 100644 arch/mips/ath25/devices.h
>>  create mode 100644 arch/mips/ath25/prom.c
>>  create mode 100644 arch/mips/include/asm/mach-ath25/ath25.h
>>  create mode 100644 arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
>>  create mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h
>>  create mode 100644 arch/mips/include/asm/mach-ath25/gpio.h
>>  create mode 100644 arch/mips/include/asm/mach-ath25/war.h
>>
>> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
>> index f5e18bf..1780c74 100644
>> --- a/arch/mips/Kbuild.platforms
>> +++ b/arch/mips/Kbuild.platforms
>> @@ -2,6 +2,7 @@
>>
>>  platforms += alchemy
>>  platforms += ar7
>> +platforms += ath25
>>  platforms += ath79
>>  platforms += bcm47xx
>>  platforms += bcm63xx
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 652bd79..54abb9a 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -96,6 +96,19 @@ config AR7
>>         Support for the Texas Instruments AR7 System-on-a-Chip
>>         family: TNETD7100, 7200 and 7300.
>>
>> +config ATH25
>> +     bool "Atheros AR231x/AR531x SoC support"
>> +     select CEVT_R4K
>> +     select CSRC_R4K
>> +     select DMA_NONCOHERENT
>> +     select IRQ_CPU
>> +     select SYS_HAS_CPU_MIPS32_R1
>> +     select SYS_SUPPORTS_BIG_ENDIAN
>> +     select SYS_SUPPORTS_32BIT_KERNEL
>> +     select ARCH_REQUIRE_GPIOLIB
>> +     help
>> +       Support for Atheros AR231x and Atheros AR531x based boards
>> +
>>  config ATH79
>>       bool "Atheros AR71XX/AR724X/AR913X based boards"
>>       select ARCH_REQUIRE_GPIOLIB
>> diff --git a/arch/mips/ath25/Makefile b/arch/mips/ath25/Makefile
>> new file mode 100644
>> index 0000000..9199fa1
>> --- /dev/null
>> +++ b/arch/mips/ath25/Makefile
>> @@ -0,0 +1,11 @@
>> +#
>> +# This file is subject to the terms and conditions of the GNU General Public
>> +# License.  See the file "COPYING" in the main directory of this archive
>> +# for more details.
>> +#
>> +# Copyright (C) 2006 FON Technology, SL.
>> +# Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
>> +# Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
>> +#
>> +
>> +obj-y += board.o prom.o devices.o
>> diff --git a/arch/mips/ath25/Platform b/arch/mips/ath25/Platform
>> new file mode 100644
>> index 0000000..ef3f81f
>> --- /dev/null
>> +++ b/arch/mips/ath25/Platform
>> @@ -0,0 +1,6 @@
>> +#
>> +# Atheros AR531X/AR231X WiSoC
>> +#
>> +platform-$(CONFIG_ATH25)     += ath25/
>> +cflags-$(CONFIG_ATH25)               += -I$(srctree)/arch/mips/include/asm/mach-ath25
>> +load-$(CONFIG_ATH25)         += 0xffffffff80041000
>> diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
>> new file mode 100644
>> index 0000000..cbc6d7b
>> --- /dev/null
>> +++ b/arch/mips/ath25/board.c
>> @@ -0,0 +1,53 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
>> + * Copyright (C) 2006 FON Technology, SL.
>> + * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
>> + * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <asm/irq_cpu.h>
>> +#include <asm/reboot.h>
>> +#include <asm/bootinfo.h>
>> +#include <asm/time.h>
>> +
>> +static void ath25_halt(void)
>> +{
>> +     local_irq_disable();
>> +     while (1)
>> +             ;
>> +}
>> +
>> +void __init plat_mem_setup(void)
>> +{
>> +     _machine_halt = ath25_halt;
>> +     pm_power_off = ath25_halt;
>> +
>> +     /* Disable data watchpoints */
>> +     write_c0_watchlo0(0);
>> +}
>> +
>> +asmlinkage void plat_irq_dispatch(void)
>> +{
>> +}
>> +
>> +void __init plat_time_init(void)
>> +{
>> +}
>> +
>> +unsigned int __cpuinit get_c0_compare_int(void)
>> +{
>> +     return CP0_LEGACY_COMPARE_IRQ;
>> +}
>> +
>> +void __init arch_init_irq(void)
>> +{
>> +     clear_c0_status(ST0_IM);
>> +     mips_cpu_irq_init();
>> +}
>> +
>> diff --git a/arch/mips/ath25/devices.c b/arch/mips/ath25/devices.c
>> new file mode 100644
>> index 0000000..e30afbc
>> --- /dev/null
>> +++ b/arch/mips/ath25/devices.c
>> @@ -0,0 +1,11 @@
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <asm/bootinfo.h>
>> +
>> +#include "devices.h"
>> +
>> +const char *get_system_type(void)
>> +{
>> +     return "Atheros (unknown)";
>> +}
>> +
>> diff --git a/arch/mips/ath25/devices.h b/arch/mips/ath25/devices.h
>> new file mode 100644
>> index 0000000..edda636
>> --- /dev/null
>> +++ b/arch/mips/ath25/devices.h
>> @@ -0,0 +1,16 @@
>> +#ifndef __ATH25_DEVICES_H
>> +#define __ATH25_DEVICES_H
>> +
>> +#include <linux/cpu.h>
>> +
>> +static inline bool is_ar2315(void)
>> +{
>> +     return (current_cpu_data.cputype == CPU_4KEC);
>> +}
>> +
>> +static inline bool is_ar5312(void)
>> +{
>> +     return !is_ar2315();
>> +}
>> +
>> +#endif
>> diff --git a/arch/mips/ath25/prom.c b/arch/mips/ath25/prom.c
>> new file mode 100644
>> index 0000000..edf82be
>> --- /dev/null
>> +++ b/arch/mips/ath25/prom.c
>> @@ -0,0 +1,26 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright MontaVista Software Inc
>> + * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
>> + * Copyright (C) 2006 FON Technology, SL.
>> + * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
>> + * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
>> + */
>> +
>> +/*
>> + * Prom setup file for AR5312/AR231x SoCs
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <asm/bootinfo.h>
>> +
>> +void __init prom_init(void)
>> +{
>> +}
>> +
>> +void __init prom_free_prom_memory(void)
>> +{
>> +}
>> diff --git a/arch/mips/include/asm/mach-ath25/ath25.h b/arch/mips/include/asm/mach-ath25/ath25.h
>> new file mode 100644
>> index 0000000..bd66ce7
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-ath25/ath25.h
>> @@ -0,0 +1,29 @@
>> +#ifndef __ASM_MACH_ATH25_H
>> +#define __ASM_MACH_ATH25_H
>> +
>> +#include <linux/io.h>
>> +
>> +#define ATH25_REG_MS(_val, _field)   (((_val) & _field##_M) >> _field##_S)
>> +
>> +static inline u32 ath25_read_reg(u32 reg)
>> +{
>> +     return __raw_readl((void __iomem *)KSEG1ADDR(reg));
>> +}
>> +
>> +static inline void ath25_write_reg(u32 reg, u32 val)
>> +{
>> +     __raw_writel(val, (void __iomem *)KSEG1ADDR(reg));
>> +}
>> +
>
> using KSEG1ADDR is a bad idea. EVA will obselete these. please use
> ioremap() to get a void __iomem pointer and then use this as a
> register base. the current code will also lead to a addr cast with
> every call of the functions.
>
I will investigate that.

And BTW, what the EVA is?

-- 
BR,
Sergey
