Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 20:26:55 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:36136 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993041AbeGES0qkoKGs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2018 20:26:46 +0200
Date:   Thu, 05 Jul 2018 20:26:38 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of
 channels
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Message-Id: <1530815198.6642.1@smtp.crapouillou.net>
In-Reply-To: <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-2-paul@crapouillou.net>
        <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530815203; bh=HLmy3EXSLh/2z2u+ZTpztzI8v43ggPFSeQ6BOeVuZzs=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type; b=nCs/XSUp0t2I8Hj8fUyjuBx9ZyOBO7enXaYgfNfNnT3UgLOowDjSvRoPOiA8K5wPSBZMIYU/r3SlBIBMHrfiUj4RnPg1qKYDtzO2Y1D1NkaX3HQpWnBIOKq6aaVLbfMEP6BbCkQrq4f1BH18RuvuBzWBvrB04Y/j0yKdFtgV4oM=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64697
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

Hi PrasannaKumar,

> Hi Paul,
> 
> On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
>>  As part of the work to support various other Ingenic JZ47xx SoC 
>> versions,
>>  which don't feature the same number of DMA channels per core, we now
>>  deduce the number of DMA channels available from the devicetree
>>  compatible string.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/dma/dma-jz4780.c | 53 
>> +++++++++++++++++++++++++++++-----------
>>   1 file changed, 39 insertions(+), 14 deletions(-)
>> 
>>  diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
>>  index 85820a2d69d4..b40f491f0367 100644
>>  --- a/drivers/dma/dma-jz4780.c
>>  +++ b/drivers/dma/dma-jz4780.c
>>  @@ -16,6 +16,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>  +#include <linux/of_device.h>
>>   #include <linux/of_dma.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>  @@ -23,8 +24,6 @@
>>   #include "dmaengine.h"
>>   #include "virt-dma.h"
>> 
>>  -#define JZ_DMA_NR_CHANNELS     32
>>  -
>>   /* Global registers. */
>>   #define JZ_DMA_REG_DMAC                0x1000
>>   #define JZ_DMA_REG_DIRQP       0x1004
>>  @@ -135,14 +134,20 @@ struct jz4780_dma_chan {
>>          unsigned int curr_hwdesc;
>>   };
>> 
>>  +enum jz_version {
>>  +       ID_JZ4780,
>>  +};
>>  +
>>   struct jz4780_dma_dev {
>>          struct dma_device dma_device;
>>          void __iomem *base;
>>          struct clk *clk;
>>          unsigned int irq;
>>  +       unsigned int nb_channels;
>>  +       enum jz_version version;
>> 
>>          uint32_t chan_reserved;
>>  -       struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
>>  +       struct jz4780_dma_chan chan[];
> 
> Looks like a variable length array in struct. I think there is some
> effort to remove the usage of VLA. Can you revisit this? I may be
> wrong, please feel free to correct.

Are you sure? It's the first time I hear about it.
Could anybody confirm?

>>   };
>> 
>>   struct jz4780_dma_filter_data {
>>  @@ -648,7 +653,7 @@ static irqreturn_t jz4780_dma_irq_handler(int 
>> irq, void *data)
>> 
>>          pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
>> 
>>  -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
>>  +       for (i = 0; i < jzdma->nb_channels; i++) {
>>                  if (!(pending & (1<<i)))
>>                          continue;
>> 
>>  @@ -728,7 +733,7 @@ static struct dma_chan 
>> *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>>          data.channel = dma_spec->args[1];
>> 
>>          if (data.channel > -1) {
>>  -               if (data.channel >= JZ_DMA_NR_CHANNELS) {
>>  +               if (data.channel >= jzdma->nb_channels) {
>>                          dev_err(jzdma->dma_device.dev,
>>                                  "device requested non-existent 
>> channel %u\n",
>>                                  data.channel);
>>  @@ -752,19 +757,45 @@ static struct dma_chan 
>> *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>>          }
>>   }
>> 
>>  +static const unsigned int jz4780_dma_nb_channels[] = {
>>  +       [ID_JZ4780] = 32,
>>  +};
>>  +
>>  +static const struct of_device_id jz4780_dma_dt_match[] = {
>>  +       { .compatible = "ingenic,jz4780-dma", .data = (void 
>> *)ID_JZ4780 },
>>  +       {},
>>  +};
>>  +MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
>>  +
>>   static int jz4780_dma_probe(struct platform_device *pdev)
>>   {
>>          struct device *dev = &pdev->dev;
>>  +       const struct of_device_id *of_id = of_match_device(
>>  +                       jz4780_dma_dt_match, dev);
>>          struct jz4780_dma_dev *jzdma;
>>          struct jz4780_dma_chan *jzchan;
>>          struct dma_device *dd;
>>          struct resource *res;
>>  +       enum jz_version version;
>>  +       unsigned int nb_channels;
>>          int i, ret;
>> 
>>  -       jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
>>  +       if (of_id)
>>  +               version = (enum jz_version)of_id->data;
>>  +       else
>>  +               version = ID_JZ4780; /* Default when not probed 
>> from DT */
>>  +
>>  +       nb_channels = jz4780_dma_nb_channels[version];
>>  +
>>  +       jzdma = devm_kzalloc(dev, sizeof(*jzdma)
>>  +                               + sizeof(*jzdma->chan) * 
>> nb_channels,
>>  +                               GFP_KERNEL);
>>          if (!jzdma)
>>                  return -ENOMEM;
>> 
>>  +       jzdma->nb_channels = nb_channels;
>>  +       jzdma->version = version;
>>  +
>>          platform_set_drvdata(pdev, jzdma);
>> 
>>          res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>  @@ -839,7 +870,7 @@ static int jz4780_dma_probe(struct 
>> platform_device *pdev)
>> 
>>          INIT_LIST_HEAD(&dd->channels);
>> 
>>  -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
>>  +       for (i = 0; i < jzdma->nb_channels; i++) {
>>                  jzchan = &jzdma->chan[i];
>>                  jzchan->id = i;
>> 
>>  @@ -884,19 +915,13 @@ static int jz4780_dma_remove(struct 
>> platform_device *pdev)
>> 
>>          free_irq(jzdma->irq, jzdma);
>> 
>>  -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
>>  +       for (i = 0; i < jzdma->nb_channels; i++)
>>                  tasklet_kill(&jzdma->chan[i].vchan.task);
>> 
>>          dma_async_device_unregister(&jzdma->dma_device);
>>          return 0;
>>   }
>> 
>>  -static const struct of_device_id jz4780_dma_dt_match[] = {
>>  -       { .compatible = "ingenic,jz4780-dma", .data = NULL },
>>  -       {},
>>  -};
>>  -MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
>>  -
>>   static struct platform_driver jz4780_dma_driver = {
>>          .probe          = jz4780_dma_probe,
>>          .remove         = jz4780_dma_remove,
>>  --
>>  2.18.0
>> 
>> 
