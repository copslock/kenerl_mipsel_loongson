Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2018 17:28:11 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:54656 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992375AbeKVQ05grJXv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2018 17:26:57 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 03/10] mmc: jz4740: Use GPIO descriptor for power
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 22 Nov 2018 17:26:55 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
Subject: 
In-Reply-To: <CAPDyKFqVHYCBZUO273rS70veKRtuNy3iROkeAkdB_QSkzxcpPQ@mail.gmail.com>
References: <20181112141239.19646-1-linus.walleij@linaro.org>
 <20181112141239.19646-4-linus.walleij@linaro.org>
 <CAPDyKFqVHYCBZUO273rS70veKRtuNy3iROkeAkdB_QSkzxcpPQ@mail.gmail.com>
Message-ID: <cb5ddbe663345981fc4039264e139733@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Le 2018-11-20 10:30, Ulf Hansson a écrit :
> On 12 November 2018 at 15:12, Linus Walleij <linus.walleij@linaro.org> 
> wrote:
>> The power GPIO line is passed with inversion flags and all from
>> the platform data. Switch to using an optional GPIO descriptor and
>> use this to switch the power.
>> 
>> Augment the only boardfile to pass in the proper "power" descriptor
>> in the GPIO descriptor machine table instead.
>> 
>> As the GPIO handling is now much simpler, we can cut down on some
>> overhead code.
>> 
>> Cc: Paul Cercueil <paul@crapouillou.net>
>> Cc: linux-mips@linux-mips.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Applied for next, thanks!
> 
> Kind regards
> Uffe

Sorry for being late to the party. I would have NACK'd this :(

I think the driver should just call mmc_regulator_get_supply() in the 
probe function,
and then call mmc_regulator_set_ocr() to power ON or OFF the card. The 
board file would
then provide the power regulator that triggers the GPIO line.

-Paul

>> ---
>>  .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  2 -
>>  arch/mips/jz4740/board-qi_lb60.c              |  6 +-
>>  drivers/mmc/host/jz4740_mmc.c                 | 65 
>> +++++--------------
>>  3 files changed, 18 insertions(+), 55 deletions(-)
>> 
>> diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h 
>> b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
>> index ff50aeb1a933..9a7de47c7c79 100644
>> --- a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
>> +++ b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
>> @@ -3,10 +3,8 @@
>>  #define __LINUX_MMC_JZ4740_MMC
>> 
>>  struct jz4740_mmc_platform_data {
>> -       int gpio_power;
>>         unsigned card_detect_active_low:1;
>>         unsigned read_only_active_low:1;
>> -       unsigned power_active_low:1;
>> 
>>         unsigned data_1bit:1;
>>  };
>> diff --git a/arch/mips/jz4740/board-qi_lb60.c 
>> b/arch/mips/jz4740/board-qi_lb60.c
>> index 705593d40d12..6718efb400f4 100644
>> --- a/arch/mips/jz4740/board-qi_lb60.c
>> +++ b/arch/mips/jz4740/board-qi_lb60.c
>> @@ -43,8 +43,6 @@
>>  #include "clock.h"
>> 
>>  /* GPIOs */
>> -#define QI_LB60_GPIO_SD_VCC_EN_N       JZ_GPIO_PORTD(2)
>> -
>>  #define QI_LB60_GPIO_KEYOUT(x)         (JZ_GPIO_PORTC(10) + (x))
>>  #define QI_LB60_GPIO_KEYIN(x)          (JZ_GPIO_PORTD(18) + (x))
>>  #define QI_LB60_GPIO_KEYIN8            JZ_GPIO_PORTD(26)
>> @@ -385,14 +383,14 @@ static struct platform_device qi_lb60_gpio_keys 
>> = {
>>  };
>> 
>>  static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
>> -       .gpio_power             = QI_LB60_GPIO_SD_VCC_EN_N,
>> -       .power_active_low       = 1,
>> +       /* Intentionally left blank */
>>  };
>> 
>>  static struct gpiod_lookup_table qi_lb60_mmc_gpio_table = {
>>         .dev_id = "jz4740-mmc.0",
>>         .table = {
>>                 GPIO_LOOKUP("GPIOD", 0, "cd", GPIO_ACTIVE_HIGH),
>> +               GPIO_LOOKUP("GPIOD", 2, "power", GPIO_ACTIVE_LOW),
>>                 { },
>>         },
>>  };
>> diff --git a/drivers/mmc/host/jz4740_mmc.c 
>> b/drivers/mmc/host/jz4740_mmc.c
>> index 44ea452add8e..6f7a99e54af0 100644
>> --- a/drivers/mmc/host/jz4740_mmc.c
>> +++ b/drivers/mmc/host/jz4740_mmc.c
>> @@ -21,7 +21,7 @@
>>  #include <linux/dmaengine.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/err.h>
>> -#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>>  #include <linux/irq.h>
>> @@ -136,6 +136,7 @@ struct jz4740_mmc_host {
>>         struct platform_device *pdev;
>>         struct jz4740_mmc_platform_data *pdata;
>>         struct clk *clk;
>> +       struct gpio_desc *power;
>> 
>>         enum jz4740_mmc_version version;
>> 
>> @@ -903,18 +904,16 @@ static void jz4740_mmc_set_ios(struct mmc_host 
>> *mmc, struct mmc_ios *ios)
>>         switch (ios->power_mode) {
>>         case MMC_POWER_UP:
>>                 jz4740_mmc_reset(host);
>> -               if (host->pdata && 
>> gpio_is_valid(host->pdata->gpio_power))
>> -                       gpio_set_value(host->pdata->gpio_power,
>> -                                       
>> !host->pdata->power_active_low);
>> +               if (host->power)
>> +                       gpiod_set_value(host->power, 1);
>>                 host->cmdat |= JZ_MMC_CMDAT_INIT;
>>                 clk_prepare_enable(host->clk);
>>                 break;
>>         case MMC_POWER_ON:
>>                 break;
>>         default:
>> -               if (host->pdata && 
>> gpio_is_valid(host->pdata->gpio_power))
>> -                       gpio_set_value(host->pdata->gpio_power,
>> -                                       
>> host->pdata->power_active_low);
>> +               if (host->power)
>> +                       gpiod_set_value(host->power, 0);
>>                 clk_disable_unprepare(host->clk);
>>                 break;
>>         }
>> @@ -947,30 +946,9 @@ static const struct mmc_host_ops jz4740_mmc_ops = 
>> {
>>         .enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
>>  };
>> 
>> -static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
>> -       const char *name, bool output, int value)
>> -{
>> -       int ret;
>> -
>> -       if (!gpio_is_valid(gpio))
>> -               return 0;
>> -
>> -       ret = gpio_request(gpio, name);
>> -       if (ret) {
>> -               dev_err(dev, "Failed to request %s gpio: %d\n", name, 
>> ret);
>> -               return ret;
>> -       }
>> -
>> -       if (output)
>> -               gpio_direction_output(gpio, value);
>> -       else
>> -               gpio_direction_input(gpio);
>> -
>> -       return 0;
>> -}
>> -
>> -static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
>> -       struct platform_device *pdev)
>> +static int jz4740_mmc_request_gpios(struct jz4740_mmc_host *host,
>> +                                   struct mmc_host *mmc,
>> +                                   struct platform_device *pdev)
>>  {
>>         struct jz4740_mmc_platform_data *pdata = 
>> dev_get_platdata(&pdev->dev);
>>         int ret = 0;
>> @@ -995,19 +973,12 @@ static int jz4740_mmc_request_gpios(struct 
>> mmc_host *mmc,
>>         if (ret == -EPROBE_DEFER)
>>                 return ret;
>> 
>> -       return jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
>> -                       "MMC read only", true, 
>> pdata->power_active_low);
>> -}
>> -
>> -static void jz4740_mmc_free_gpios(struct platform_device *pdev)
>> -{
>> -       struct jz4740_mmc_platform_data *pdata = 
>> dev_get_platdata(&pdev->dev);
>> -
>> -       if (!pdata)
>> -               return;
>> +       host->power = devm_gpiod_get_optional(&pdev->dev, "power",
>> +                                             GPIOD_OUT_HIGH);
>> +       if (IS_ERR(host->power))
>> +               return PTR_ERR(host->power);
>> 
>> -       if (gpio_is_valid(pdata->gpio_power))
>> -               gpio_free(pdata->gpio_power);
>> +       return 0;
>>  }
>> 
>>  static const struct of_device_id jz4740_mmc_of_match[] = {
>> @@ -1053,7 +1024,7 @@ static int jz4740_mmc_probe(struct 
>> platform_device* pdev)
>>                 mmc->caps |= MMC_CAP_SDIO_IRQ;
>>                 if (!(pdata && pdata->data_1bit))
>>                         mmc->caps |= MMC_CAP_4_BIT_DATA;
>> -               ret = jz4740_mmc_request_gpios(mmc, pdev);
>> +               ret = jz4740_mmc_request_gpios(host, mmc, pdev);
>>                 if (ret)
>>                         goto err_free_host;
>>         }
>> @@ -1104,7 +1075,7 @@ static int jz4740_mmc_probe(struct 
>> platform_device* pdev)
>>                         dev_name(&pdev->dev), host);
>>         if (ret) {
>>                 dev_err(&pdev->dev, "Failed to request irq: %d\n", 
>> ret);
>> -               goto err_free_gpios;
>> +               goto err_free_host;
>>         }
>> 
>>         jz4740_mmc_clock_disable(host);
>> @@ -1135,8 +1106,6 @@ static int jz4740_mmc_probe(struct 
>> platform_device* pdev)
>>                 jz4740_mmc_release_dma_channels(host);
>>  err_free_irq:
>>         free_irq(host->irq, host);
>> -err_free_gpios:
>> -       jz4740_mmc_free_gpios(pdev);
>>  err_free_host:
>>         mmc_free_host(mmc);
>> 
>> @@ -1155,8 +1124,6 @@ static int jz4740_mmc_remove(struct 
>> platform_device *pdev)
>> 
>>         free_irq(host->irq, host);
>> 
>> -       jz4740_mmc_free_gpios(pdev);
>> -
>>         if (host->use_dma)
>>                 jz4740_mmc_release_dma_channels(host);
>> 
>> --
>> 2.17.2
>> 
