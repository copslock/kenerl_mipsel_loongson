Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 18:13:59 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:6885 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014930AbcBZRN5lOJ3d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 18:13:57 +0100
Received: from [10.14.4.125] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Fri, 26 Feb 2016
 10:13:49 -0700
Subject: Re: [PATCH v2 2/2] watchdog: pic32-dmt: Add PIC32 deadman timer
 driver
To:     Guenter Roeck <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>
References: <1456425056-24483-2-git-send-email-joshua.henderson@microchip.com>
 <56D05D2E.3040403@roeck-us.net>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56D087FD.9080208@microchip.com>
Date:   Fri, 26 Feb 2016 10:14:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <56D05D2E.3040403@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

On 02/26/2016 07:11 AM, Guenter Roeck wrote:
> On 02/25/2016 10:30 AM, Joshua Henderson wrote:
>> From: Purna Chandra Mandal <purna.mandal@microchip.com>
>>
>> Adds support for the deadman timer peripheral found on PIC32 class devices.
>>
>> The primary function of the deadman timer (DMT) is to reset the processor
>> in the event of a software malfunction. The DMT is a free-running
>> instruction fetch timer, which is clocked whenever an instruction fetch
>> occurs until a count match occurs. Instructions are not fetched when
>> the processor is in sleep mode.
>>
>> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> ---
>> Note: Please merge this patch series through the MIPS tree.
>>
>> Changes since v1:
>>     - Drop default y in Kconfig
>>     - Alphabetical include files
>>     - Use BIT() where appropriate
>>     - Replace cpu_relax() with nop() and comment why it's needed
>>     - Return bool on functions where appropriate
>>     - Add a way to break out of a tight loop
>>     - Remove static unused function
>>     - Remove redundant spinlock already covered by watchdog core
>>     - Remove unecessary error handling when enabling DMT
>>     - Drop implementation of .get_timeleft
>>     - Drop calculation of max_timeout
>>     - Cleanup dev_err() message contents
>>     - Fix race condition with watchdog device register
>>     - Unregister watchdog before disabling clock
>>     - Fix typo in driver name
>> ---
>>   drivers/watchdog/Kconfig     |   13 +++
>>   drivers/watchdog/Makefile    |    1 +
>>   drivers/watchdog/pic32-dmt.c |  260 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 274 insertions(+)
>>   create mode 100644 drivers/watchdog/pic32-dmt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 543fa81..53747e9 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1427,6 +1427,19 @@ config PIC32_WDT
>>         To compile this driver as a loadable module, choose M here.
>>         The module will be called pic32-wdt.
>>
>> +config PIC32_DMT
>> +    tristate "Microchip PIC32 Deadman Timer"
>> +    select WATCHDOG_CORE
>> +    depends on MACH_PIC32
>> +    help
>> +      Watchdog driver for PIC32 instruction fetch counting timer. This specific
>> +      timer is typically be used in misson critical and safety critical
>> +      applications, where any single failure of the software functionality
>> +      and sequencing must be detected.
>> +
>> +      To compile this driver as a loadable module, choose M here.
>> +      The module will be called pic32-dmt.
>> +
>>   # PARISC Architecture
>>
>>   # POWERPC Architecture
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 244ed80..d051c9c 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -154,6 +154,7 @@ obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
>>   obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
>>   obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
>>   obj-$(CONFIG_PIC32_WDT) += pic32-wdt.o
>> +obj-$(CONFIG_PIC32_DMT) += pic32-dmt.o
>>
>>   # PARISC Architecture
>>
>> diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
>> new file mode 100644
>> index 0000000..91801fa
>> --- /dev/null
>> +++ b/drivers/watchdog/pic32-dmt.c
>> @@ -0,0 +1,260 @@
>> +/*
>> + * PIC32 deadman timer driver
>> + *
>> + * Purna Chandra Mandal <purna.mandal@microchip.com>
>> + * Copyright (c) 2016, Microchip Technology Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
> 
> No pr_ function left, so this define can be removed.

Ack.

> 
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/watchdog.h>
>> +
>> +#include <asm/mach-pic32/pic32.h>
>> +
>> +/* Deadman Timer Regs */
>> +#define DMTCON_REG    0x00
>> +#define DMTPRECLR_REG    0x10
>> +#define DMTCLR_REG    0x20
>> +#define DMTSTAT_REG    0x30
>> +#define DMTCNT_REG    0x40
>> +#define DMTPSCNT_REG    0x60
>> +#define DMTPSINTV_REG    0x70
>> +
>> +/* Deadman Timer Regs fields */
>> +#define DMT_ON            BIT(15)
>> +#define DMT_STEP1_KEY        BIT(6)
>> +#define DMT_STEP2_KEY        BIT(3)
>> +#define DMTSTAT_WINOPN        BIT(0)
>> +#define DMTSTAT_EVENT        BIT(5)
>> +#define DMTSTAT_BAD2        BIT(6)
>> +#define DMTSTAT_BAD1        BIT(7)
>> +
>> +/* Reset Control Register fields for watchdog */
>> +#define RESETCON_DMT_TIMEOUT    BIT(5)
>> +
>> +struct pic32_dmt {
>> +    void __iomem    *regs;
>> +    struct clk    *clk;
>> +};
>> +
>> +static inline void dmt_enable(struct pic32_dmt *dmt)
>> +{
>> +    writel(DMT_ON, PIC32_SET(dmt->regs + DMTCON_REG));
>> +}
>> +
>> +static inline void dmt_disable(struct pic32_dmt *dmt)
>> +{
>> +    writel(DMT_ON, PIC32_CLR(dmt->regs + DMTCON_REG));
>> +    /*
>> +     * Cannot touch registers in the CPU cycle following clearing the
>> +     * ON bit.
>> +     */
>> +    nop();
>> +}
>> +
>> +static inline int dmt_bad_status(struct pic32_dmt *dmt)
>> +{
>> +    u32 val;
>> +
>> +    val = readl(dmt->regs + DMTSTAT_REG);
>> +    val &= (DMTSTAT_BAD1 | DMTSTAT_BAD2 | DMTSTAT_EVENT);
>> +    if (val)
>> +        return -EAGAIN;
>> +
>> +    return 0;
>> +}
>> +
>> +static inline int dmt_keepalive(struct pic32_dmt *dmt)
>> +{
>> +    u32 v;
>> +    u32 timeout = 500;
>> +
>> +    /* set pre-clear key */
>> +    writel(DMT_STEP1_KEY << 8, dmt->regs + DMTPRECLR_REG);
>> +
>> +    /* wait for DMT window to open */
>> +    while (--timeout) {
>> +        v = readl(dmt->regs + DMTSTAT_REG) & DMTSTAT_WINOPN;
>> +        if (v == DMTSTAT_WINOPN)
>> +            break;
>> +    }
>> +
>> +    /* apply key2 */
>> +    writel(DMT_STEP2_KEY, dmt->regs + DMTCLR_REG);
>> +
>> +    /* check whether keys are latched correctly */
>> +    return dmt_bad_status(dmt);
>> +}
>> +
>> +static inline u32 pic32_dmt_get_timeout_secs(struct pic32_dmt *dmt)
>> +{
>> +    unsigned long rate;
>> +
>> +    rate = clk_get_rate(dmt->clk);
>> +    if (rate)
>> +        return readl(dmt->regs + DMTPSCNT_REG) / rate;
>> +
>> +    return -EINVAL;
> 
> Return value is unsigned, and the caller checks for 0 to identify an error,
> so you need to return 0 here.
> 
> With that fixed, and the pr_fmt dropped, feel free to add
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> to the next revision of this patch.

Ack.

Thanks,
Josh
