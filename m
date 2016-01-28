Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 01:25:18 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:6233 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007649AbcA1AZQKtwpv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 01:25:16 +0100
Received: from [10.14.4.125] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 27 Jan 2016
 17:25:08 -0700
Subject: Re: [PATCH v5 08/14] pinctrl: pinctrl-pic32: Add PIC32 pin control
 driver
To:     Linus Walleij <linus.walleij@linaro.org>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
 <1452734299-460-9-git-send-email-joshua.henderson@microchip.com>
 <CACRpkdaDC5LLcQx5_=vm=tjAV0z6RHvzgjzSFK6S+_1M7faMuA@mail.gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56A961CC.9030205@microchip.com>
Date:   Wed, 27 Jan 2016 17:33:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdaDC5LLcQx5_=vm=tjAV0z6RHvzgjzSFK6S+_1M7faMuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51499
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

Linus,

On 01/27/2016 06:49 AM, Linus Walleij wrote:
> On Thu, Jan 14, 2016 at 2:15 AM, Joshua Henderson
> <joshua.henderson@microchip.com> wrote:
> 
>> Add a driver for the pin controller present on the Microchip PIC32
>> including the specific variant PIC32MZDA. This driver provides pinmux
>> and pinconfig operations as well as GPIO and IRQ chips for the GPIO
>> banks.
>>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> ---
>> Changes since v4: None
> 
> Sorry for the delay. Fell between the cracks.
>
> Overall this looks nice. Small things that need to be fixed below.
> 
> Is it possible to merge this patch separately into the pinctrl tree?

Yes. That was not the original goal as it is part of a larger patch set for dependency reasons, but a couple in the series got left behind, including this one.

> 
> I was hoping there are no compile-time dependencies to the
> MIPS tree so I can just merge this. Else I can provide some
> kind of immutable branch to the MIPS maintainers.
> (Having dangling symbols in Kconfig is OK with me if I know
> they will come in from some other tree.)
> 

You have what you need in your pinctrl tree.  I see 4.5-rc1 pulled with MIPS PIC32 platform support.

>> +#include <linux/clk.h>
>> +#include <linux/gpio.h>
> 
> This include should not be needed, just the one below.
> 

Ack.

>> +#include <linux/gpio/driver.h>
> (...)
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pinctrl/pinconf.h>
>> +#include <linux/pinctrl/pinconf-generic.h>
>> +#include <linux/pinctrl/pinctrl.h>
>> +#include <linux/pinctrl/pinmux.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include <asm/mach-pic32/pic32.h>
> 
> Oh this is how you do things still? Is this necessary? :/

This is needed only for the PIC32_CLR()/PIC32_SET()/PIC32_INV() macros that are just providing register offsets. These macros are used by many (all?) of the PIC32 drivers and platform.  Explicitly labeling these offsets where used is valuable because it changes the meaning of "value" to writel().  If you can suggest a better place to put these I am all for it.

> Then I guess it has to be applied to the MIPS tree.
> 

Doesn't have to now.

>> +static inline u32 pctl_readl(struct pic32_pinctrl *pctl, u32 reg)
>> +{
>> +       return readl(pctl->reg_base + reg);
>> +}
>> +
>> +static inline void pctl_writel(struct pic32_pinctrl *pctl, u32 val, u32 reg)
>> +{
>> +       writel(val, pctl->reg_base + reg);
>> +}
> 
> This is a bit excess abstraction, I would just readl() and writel()
> directly in the code, adding the offset. Butr it's you pick.
> 

I'm in agreement.  It was nice for initial debug, but we are past that.  I'll yank the wrapper *_writel/*_readl functions.

>> +static inline struct pic32_gpio_bank *gc_to_bank(struct gpio_chip *gc)
>> +{
>> +       return container_of(gc, struct pic32_gpio_bank, gpio_chip);
>> +}
> 
> Don't do this anymore.
> 
> Se all the "use gpiochip data pointer" patches I merged last
> merge window.
> 

Those made it in with this patch outstanding.  I will double check against your pinctrl tree.

> Replace
> 
> = gc_to_bank(gc)
> with
> = gpiochip_get_data(gc);
> 
> everywhere and use
> 
> gpiochip_add_data(&gc, bank)
> 
> to make sure that gpipchip_get_data() returns what you want.
> 
>> +static inline struct pic32_gpio_bank *irqd_to_bank(struct irq_data *d)
>> +{
>> +       return gc_to_bank(irq_data_get_irq_chip_data(d));
>> +}
> 
> For example this becomes:
> return gpiochip_get_data(irq_data_get_irq_chip_data(d));
> 

Thanks for the explanation.  Consider it done.

>> +static inline u32 gpio_readl(struct pic32_gpio_bank *bank, u32 reg)
>> +{
>> +       return readl(bank->reg_base + reg);
>> +}
>> +
>> +static inline void gpio_writel(struct pic32_gpio_bank *bank, u32 val,
>> +                              u32 reg)
>> +{
>> +       writel(val, bank->reg_base + reg);
>> +}
> 
> Again excessive abstraction IMO.
> 

Ack.

>> +#define GPIO_BANK(_bank, _npins)                                       \
>> +       {                                                               \
>> +               .gpio_chip = {                                          \
>> +                       .label = "GPIO" #_bank,                         \
>> +                       .request = gpiochip_generic_request,            \
>> +                       .free = gpiochip_generic_free,                  \
>> +                       .get_direction = pic32_gpio_get_direction,      \
>> +                       .direction_input = pic32_gpio_direction_input,  \
>> +                       .direction_output = pic32_gpio_direction_output, \
>> +                       .get = pic32_gpio_get,                          \
>> +                       .set = pic32_gpio_set,                          \
>> +                       .ngpio = _npins,                                \
>> +                       .base = GPIO_BANK_START(_bank),                 \
>> +                       .owner = THIS_MODULE,                           \
>> +                       .can_sleep = 0,                                 \
>> +               },                                                      \
>> +               .irq_chip = {                                           \
>> +                       .name = "GPIO" #_bank,                          \
>> +                       .irq_startup = pic32_gpio_irq_startup,  \
>> +                       .irq_ack = pic32_gpio_irq_ack,          \
>> +                       .irq_mask = pic32_gpio_irq_mask,                \
>> +                       .irq_unmask = pic32_gpio_irq_unmask,            \
>> +                       .irq_set_type = pic32_gpio_irq_set_type,        \
>> +               },                                                      \
>> +       }
>> +
>> +static struct pic32_gpio_bank pic32_gpio_banks[] = {
>> +       GPIO_BANK(0, PINS_PER_BANK),
>> +       GPIO_BANK(1, PINS_PER_BANK),
>> +       GPIO_BANK(2, PINS_PER_BANK),
>> +       GPIO_BANK(3, PINS_PER_BANK),
>> +       GPIO_BANK(4, PINS_PER_BANK),
>> +       GPIO_BANK(5, PINS_PER_BANK),
>> +       GPIO_BANK(6, PINS_PER_BANK),
>> +       GPIO_BANK(7, PINS_PER_BANK),
>> +       GPIO_BANK(8, PINS_PER_BANK),
>> +       GPIO_BANK(9, PINS_PER_BANK),
>> +};
> 
> Ewwwww.... I guess it's OK though. I would have made it with
> some dynamic allocation and a for() loop in code.
> 

Let me look into this more and see if I can clean it up.

>> +       bank->gpio_chip.dev = &pdev->dev;
> 
> This is named .parent in the upstream kernel so you need to change it.

Ack.

> 
>> +       bank->gpio_chip.of_node = np;
>> +       ret = gpiochip_add(&bank->gpio_chip);
> 
> So use gpiochip_add_data()
> 
> Apart from this it looks pretty OK.
> 

I'll take what I can get.  Let me submit a patch in response to this feedback and you can take it at will.

Josh
