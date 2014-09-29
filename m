Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 22:15:26 +0200 (CEST)
Received: from mail-yh0-f53.google.com ([209.85.213.53]:52229 "EHLO
        mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010100AbaI2UPYU152L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 22:15:24 +0200
Received: by mail-yh0-f53.google.com with SMTP id b6so542690yha.26
        for <multiple recipients>; Mon, 29 Sep 2014 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AraSIhiAYb6inYv9EcaqiEg3V9xCPrcGYlTVNx7l0vk=;
        b=dgTOs+1h007WLM8TTGs02h6O48frwOa53cIJRB3ZbJmT4T9zfVvSlxb6I0nt2yaWaB
         kxEORsaCVtRNHsz9ZVSt4MYDlzZOr7qSu832oMFvKL0VEZ0JlsmOGy1g6t353voXvQ+z
         3e677Ub+Ng+DsS4vcLVILUzkkpIbZRT5IvLbJEoNAjWpN8NtQt2zK6fATCIm388+sGhy
         3M2j8U1QrgmklxjlcNV7nqYulVL1NAaIItBMk8AhTuYqGZanwG9qGb0QM9XK/PI1KGxH
         Dp2/3pEoPNX+5vwYHTfbh813MChoCRiTc+OHKtDDTVp0y3RWQRBSPWm2mqbpf16k+LoK
         hB1g==
X-Received: by 10.236.47.166 with SMTP id t26mr5691357yhb.104.1412021718288;
 Mon, 29 Sep 2014 13:15:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.135 with HTTP; Mon, 29 Sep 2014 13:14:58 -0700 (PDT)
In-Reply-To: <54287F13.3080509@roeck-us.net>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
 <1411929195-23775-13-git-send-email-ryazanov.s.a@gmail.com> <54287F13.3080509@roeck-us.net>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 30 Sep 2014 00:14:58 +0400
Message-ID: <CAHNKnsRCsz=m1bJX+LmAOh8CLUuuAvGmva8NpYvQSa4VK1L=PA@mail.gmail.com>
Subject: Re: [PATCH 12/16] watchdog: add Atheros AR2315 watchdog driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42888
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

2014-09-29 1:35 GMT+04:00 Guenter Roeck <linux@roeck-us.net>:
> On 09/28/2014 11:33 AM, Sergey Ryazanov wrote:
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: linux-watchdog@vger.kernel.org
>> ---
>>
>> Changes since RFC:
>>    - use watchdog infrastructure
>>    - remove deprecated IRQF_DISABLED flag
>>    - move device registration to separate patch
>>
>>   drivers/watchdog/Kconfig      |   8 ++
>>   drivers/watchdog/Makefile     |   1 +
>>   drivers/watchdog/ar2315-wtd.c | 167
>> ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 176 insertions(+)
>>   create mode 100644 drivers/watchdog/ar2315-wtd.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index f57312f..dbace99 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1186,6 +1186,14 @@ config RALINK_WDT
>>         help
>>           Hardware driver for the Ralink SoC Watchdog Timer.
>>
>> +config AR2315_WDT
>> +       tristate "Atheros AR2315+ WiSoCs Watchdog Timer"
>> +       select WATCHDOG_CORE
>> +       depends on SOC_AR2315
>> +       help
>> +         Hardware driver for the built-in watchdog timer on the Atheros
>> +         AR2315/AR2316 WiSoCs.
>> +
>>   # PARISC Architecture
>>
>>   # POWERPC Architecture
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 468c320..ef7f83b 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -133,6 +133,7 @@ obj-$(CONFIG_WDT_MTX1) += mtx-1_wdt.o
>>   obj-$(CONFIG_PNX833X_WDT) += pnx833x_wdt.o
>>   obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
>>   obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
>> +obj-$(CONFIG_AR2315_WDT) += ar2315-wtd.o
>>   obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>>   obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>>   octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
>> diff --git a/drivers/watchdog/ar2315-wtd.c b/drivers/watchdog/ar2315-wtd.c
>> new file mode 100644
>> index 0000000..4fd34d2
>> --- /dev/null
>> +++ b/drivers/watchdog/ar2315-wtd.c
>> @@ -0,0 +1,167 @@
>> +/*
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + *
>> + * Copyright (C) 2008 John Crispin <blogic@openwrt.org>
>> + * Based on EP93xx and ifxmips wdt driver
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/watchdog.h>
>> +#include <linux/reboot.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +
>> +#define DRIVER_NAME    "ar2315-wdt"
>> +
>> +#define CLOCK_RATE 40000000
>> +
>> +#define WDT_REG_TIMER          0x00
>> +#define WDT_REG_CTRL           0x04
>> +
>> +#define WDT_CTRL_ACT_NONE      0x00000000      /* No action */
>> +#define WDT_CTRL_ACT_NMI       0x00000001      /* NMI on watchdog */
>> +#define WDT_CTRL_ACT_RESET     0x00000002      /* reset on watchdog */
>> +
>
> What are those defines for ? They don't seem to be used.
>
This defines for reference. There no documentation for this chips, so
I left this defines as some kind of documentation.

> If the watchdog can result in an immediate restart, as
> this define suggests, why don't you use it but rely on
> the interrupt handler instead ?
>
AFAIK some of chips have a HW bug in restarting unit, so chip specific
restart routine (in arch code) use a lot of hacks to reset chip. So we
use interrupt to call reset function, which should reliably reset
chip.

> This means the watchdog won't really fire if it times out, but depend
> on the interrupt handler to work. Which it won't if there is a real
> problem and interrupts are disabled (or if the system hangs entirely).
>
Sure. But without reset function call from the interrupt handler we
can not reliable reset chip (see above).

>> +static int started;
>> +static void __iomem *wdt_base;
>> +
>> +static inline void ar2315_wdt_wr(unsigned reg, u32 val)
>> +{
>> +       iowrite32(val, wdt_base + reg);
>> +}
>> +
>> +static void ar2315_wdt_enable(struct watchdog_device *wdd)
>> +{
>> +       ar2315_wdt_wr(WDT_REG_TIMER, wdd->timeout * CLOCK_RATE);
>> +}
>> +
>> +static int ar2315_wdt_start(struct watchdog_device *wdd)
>> +{
>> +       ar2315_wdt_enable(wdd);
>> +       started = 1;
>
>
> I don't really see why you would need this variable.
>
To protect against spurious interrupts, since the watchdog timer could
be started by bootloader.

>
>> +       return 0;
>> +}
>> +
>> +static int ar2315_wdt_stop(struct watchdog_device *wdd)
>> +{
>> +       return 0;
>> +}
>> +
>> +static int ar2315_wdt_ping(struct watchdog_device *wdd)
>> +{
>> +       ar2315_wdt_enable(wdd);
>> +       return 0;
>> +}
>> +
>> +static int ar2315_wdt_set_timeout(struct watchdog_device *wdd, unsigned
>> val)
>> +{
>> +       wdd->timeout = val;
>> +       return 0;
>> +}
>> +
>> +static irqreturn_t ar2315_wdt_interrupt(int irq, void *dev)
>> +{
>> +       struct platform_device *pdev = (struct platform_device *)dev;
>> +
>> +       if (started) {
>> +               dev_crit(&pdev->dev, "watchdog expired, rebooting
>> system\n");
>> +               emergency_restart();
>> +       } else {
>> +               ar2315_wdt_wr(WDT_REG_CTRL, 0);
>> +               ar2315_wdt_wr(WDT_REG_TIMER, 0);
>> +       }
>
>
> This is quite unusual.
> Why not stop the watchdog in the stop function ? Quite apparently
> it can be stopped, or at least this is what it looks like.
>
The started variable is set to true inside the watchdog start routine,
but it never reset to false. This code only disable the watchdog when
it was started by bootloader.

> When do you expect this function to be called in the first place
> with started == 1 ?
>
> If the idea is to stop the watchdog if it was already enabled
> when probing the driver, why don't you stop it there ?
>
Sure, I will try to do that.

>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static const struct watchdog_info ar2315_wdt_info = {
>> +       .identity = "ar2315 Watchdog",
>> +       .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>> +};
>> +
>> +static const struct watchdog_ops ar2315_wdt_ops = {
>> +       .owner = THIS_MODULE,
>> +       .start = ar2315_wdt_start,
>> +       .stop = ar2315_wdt_stop,
>> +       .ping = ar2315_wdt_ping,
>> +       .set_timeout = ar2315_wdt_set_timeout,
>> +};
>> +
>> +static struct watchdog_device ar2315_wdt_dev = {
>> +       .info = &ar2315_wdt_info,
>> +       .ops = &ar2315_wdt_ops,
>> +       .min_timeout = 1,
>> +       .max_timeout = 90,
>> +       .timeout = 20,
>> +};
>> +
>> +static int ar2315_wdt_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct resource *res;
>> +       int ret = 0;
>> +
>> +       if (wdt_base)
>> +               return -EBUSY;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       wdt_base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(wdt_base))
>> +               return PTR_ERR(wdt_base);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> +       if (!res) {
>> +               dev_err(dev, "no IRQ resource\n");
>> +               return -ENOENT;
>> +       }
>> +
>> +       ret = devm_request_irq(dev, res->start, ar2315_wdt_interrupt, 0,
>> +                              DRIVER_NAME, pdev);
>> +       if (ret) {
>> +               dev_err(dev, "failed to register inetrrupt\n");
>> +               return ret;
>> +       }
>> +
>> +       ar2315_wdt_dev.parent = dev;
>> +       ret = watchdog_register_device(&ar2315_wdt_dev);
>> +       if (ret) {
>> +               dev_err(dev, "failed to register watchdog device\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int ar2315_wdt_remove(struct platform_device *pdev)
>> +{
>> +       watchdog_unregister_device(&ar2315_wdt_dev);
>
>
> Why don't you stop the watchdog on remove ?
>
While the watchdog is running, the watchdog core prevents the module
unloading, so this routine could not be called while the watchdog is
running. Isn't it?

>
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver ar2315_wdt_driver = {
>> +       .probe = ar2315_wdt_probe,
>> +       .remove = ar2315_wdt_remove,
>> +       .driver = {
>> +               .name = DRIVER_NAME,
>> +               .owner = THIS_MODULE,
>> +       },
>> +};
>> +
>> +module_platform_driver(ar2315_wdt_driver);
>> +
>> +MODULE_DESCRIPTION("Atheros AR2315 hardware watchdog driver");
>> +MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>>
>

-- 
BR,
Sergey
