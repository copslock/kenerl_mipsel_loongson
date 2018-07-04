Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2018 18:28:31 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:36529
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994653AbeGDQ2W5PQ-t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jul 2018 18:28:22 +0200
Received: by mail-pf0-x241.google.com with SMTP id u16-v6so3045380pfh.3;
        Wed, 04 Jul 2018 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S7Y3YgfryNM+k8fvUdmVQ7FtrRa8j4XdS3Vf+0ChyU4=;
        b=cpbMvR/sPszHW3p7rwFi3+DM2XC97r5ikG2ZUVJdoxfHb2nTqInFJyoDpXhW5UdAHg
         pPEVq1z5BqKb4aK3VO6obxPtLwptKLGa3BMT7SSWJMOJN5hwKkO+xYpf3BURolo0ft0z
         HpTmSrlVL2PjqL5l0+QzMBAkmFbY4//2oVZnslt6t3HFrssB9jUJLEzSPREwHdNN9JgM
         8fl8Tnk1G+M9N8DpTPshyEEvzffuTei9cCpZdtInX3KgT4N5feJ0J9abAk3aZDh0DqGO
         CjXRDoGY/2byBeNq0dz2VVgyijuuskSQDeuBDOm1Z34V07NbcO9xaCGczWg2GqHhn5fe
         C3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S7Y3YgfryNM+k8fvUdmVQ7FtrRa8j4XdS3Vf+0ChyU4=;
        b=TExhRa1vnnkCZCarFawTcHP4ES/E6KNSNQrK7Mi0pViYlRXFT5+gBBNueXKvSETUvI
         q3o0ZwbdifOIAHsF1Yn97l4vB4iL8bvkVU39ZNfJ6XPY2seMIeMkEG2OvFJ7trkytcqy
         UToGRIeSxfQyPg1KDlm5T9jCQ5KJQEWN8FVTS2SESZrTn+UUVKlGcULK8D4QHwZGU1rn
         ow/sEC6O06S/zYwuTVcpFhW6zuIsfFNUhoLpLPAK0KtJEFbQZhKh8csiQB7qoYJrYVYc
         169dt2Xyvbsw7XU/dbyB7q6hvodP/JnjZq97LGWwDmuYvC040dfgxTRCKRQOh+plVdMA
         9tjA==
X-Gm-Message-State: APt69E113T8+C6BZsINXhN/Zooe9f7EDFQFt1saIbXrlpHronNFlhQLR
        YRvJsymdcCWALceVG4KOAR3krd9tdexYCpyZbEY=
X-Google-Smtp-Source: AAOMgpeAnMLQfQRGhkA4ta1AvU9UACK6EBfxjdLzlc/ged2wfa+gU+7GWoxG1v3v7UDRct+dmZoLKWg03ZKTwBjY/0g=
X-Received: by 2002:a63:a1a:: with SMTP id 26-v6mr2528179pgk.221.1530721696063;
 Wed, 04 Jul 2018 09:28:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:28:15
 -0700 (PDT)
In-Reply-To: <20180703123214.23090-2-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-2-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 4 Jul 2018 21:58:15 +0530
Message-ID: <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of channels
To:     Paul Cercueil <paul@crapouillou.net>
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
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Paul,

On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
> As part of the work to support various other Ingenic JZ47xx SoC versions,
> which don't feature the same number of DMA channels per core, we now
> deduce the number of DMA channels available from the devicetree
> compatible string.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-jz4780.c | 53 +++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 85820a2d69d4..b40f491f0367 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -16,6 +16,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_dma.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -23,8 +24,6 @@
>  #include "dmaengine.h"
>  #include "virt-dma.h"
>
> -#define JZ_DMA_NR_CHANNELS     32
> -
>  /* Global registers. */
>  #define JZ_DMA_REG_DMAC                0x1000
>  #define JZ_DMA_REG_DIRQP       0x1004
> @@ -135,14 +134,20 @@ struct jz4780_dma_chan {
>         unsigned int curr_hwdesc;
>  };
>
> +enum jz_version {
> +       ID_JZ4780,
> +};
> +
>  struct jz4780_dma_dev {
>         struct dma_device dma_device;
>         void __iomem *base;
>         struct clk *clk;
>         unsigned int irq;
> +       unsigned int nb_channels;
> +       enum jz_version version;
>
>         uint32_t chan_reserved;
> -       struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
> +       struct jz4780_dma_chan chan[];

Looks like a variable length array in struct. I think there is some
effort to remove the usage of VLA. Can you revisit this? I may be
wrong, please feel free to correct.

>  };
>
>  struct jz4780_dma_filter_data {
> @@ -648,7 +653,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
>
>         pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
>
> -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
> +       for (i = 0; i < jzdma->nb_channels; i++) {
>                 if (!(pending & (1<<i)))
>                         continue;
>
> @@ -728,7 +733,7 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>         data.channel = dma_spec->args[1];
>
>         if (data.channel > -1) {
> -               if (data.channel >= JZ_DMA_NR_CHANNELS) {
> +               if (data.channel >= jzdma->nb_channels) {
>                         dev_err(jzdma->dma_device.dev,
>                                 "device requested non-existent channel %u\n",
>                                 data.channel);
> @@ -752,19 +757,45 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>         }
>  }
>
> +static const unsigned int jz4780_dma_nb_channels[] = {
> +       [ID_JZ4780] = 32,
> +};
> +
> +static const struct of_device_id jz4780_dma_dt_match[] = {
> +       { .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
> +
>  static int jz4780_dma_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> +       const struct of_device_id *of_id = of_match_device(
> +                       jz4780_dma_dt_match, dev);
>         struct jz4780_dma_dev *jzdma;
>         struct jz4780_dma_chan *jzchan;
>         struct dma_device *dd;
>         struct resource *res;
> +       enum jz_version version;
> +       unsigned int nb_channels;
>         int i, ret;
>
> -       jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
> +       if (of_id)
> +               version = (enum jz_version)of_id->data;
> +       else
> +               version = ID_JZ4780; /* Default when not probed from DT */
> +
> +       nb_channels = jz4780_dma_nb_channels[version];
> +
> +       jzdma = devm_kzalloc(dev, sizeof(*jzdma)
> +                               + sizeof(*jzdma->chan) * nb_channels,
> +                               GFP_KERNEL);
>         if (!jzdma)
>                 return -ENOMEM;
>
> +       jzdma->nb_channels = nb_channels;
> +       jzdma->version = version;
> +
>         platform_set_drvdata(pdev, jzdma);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -839,7 +870,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>
>         INIT_LIST_HEAD(&dd->channels);
>
> -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
> +       for (i = 0; i < jzdma->nb_channels; i++) {
>                 jzchan = &jzdma->chan[i];
>                 jzchan->id = i;
>
> @@ -884,19 +915,13 @@ static int jz4780_dma_remove(struct platform_device *pdev)
>
>         free_irq(jzdma->irq, jzdma);
>
> -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
> +       for (i = 0; i < jzdma->nb_channels; i++)
>                 tasklet_kill(&jzdma->chan[i].vchan.task);
>
>         dma_async_device_unregister(&jzdma->dma_device);
>         return 0;
>  }
>
> -static const struct of_device_id jz4780_dma_dt_match[] = {
> -       { .compatible = "ingenic,jz4780-dma", .data = NULL },
> -       {},
> -};
> -MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
> -
>  static struct platform_driver jz4780_dma_driver = {
>         .probe          = jz4780_dma_probe,
>         .remove         = jz4780_dma_remove,
> --
> 2.18.0
>
>
