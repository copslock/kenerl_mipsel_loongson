Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2016 18:16:07 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34896 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041038AbcEaQQBDThg2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 May 2016 18:16:01 +0200
Received: by mail-oi0-f66.google.com with SMTP id h125so31331435oib.2
        for <linux-mips@linux-mips.org>; Tue, 31 May 2016 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=SztkOmKfs/wvEGDZIJI0/Uux03AB1J6JaD7CvgNAcgs=;
        b=NXNrrD/GwIGPMDelJkDEVNnuMrZdUjZihQcCUGbbZAytFYUH82oToz4DLboieZJa4T
         lyLIjmeZHy45ApMZgjMjJggJAKVdCVKMdLDBcUe0J8GLqQgD6DXw7GnUOUweXleYPoNY
         dBxTHstZl4ne7tykpEXUGU7AEO9nk3ARargxXvortjpvtHz1oJKj51YnXEpqeDFs/DcT
         miqCUTOXCph1+qn1Uqs+uj6JiMgQoJgLixyGbHxxWDdGLFxquyx4YWtEuUPM6hVypI7R
         nl1E9xUrIM5bDxnPoTsnOPWrPodqp0Ov0yeDNdUdf2Ssdwbe3m5fCaDWHv2bkhYabwAU
         st1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=SztkOmKfs/wvEGDZIJI0/Uux03AB1J6JaD7CvgNAcgs=;
        b=KXhzhWlzlO5XpBIkrnjBdKXT+00VxzP+zrB2yHx7plvoqSzIF/3i8wG42EUWZYKZjo
         iR+pxhEV9vE9b7EHnQivDtxBC75hGXbHdgCtd5RaKA0pZmlDYWMib0f54+XhAoP7/OCV
         E8ANgkhMdRyprTWCEejbvf7DOWKy+yz5Vq2HPskAEhP811Yy+KOsLbZ4W42Vie2yhnXo
         WUSMUj9o9zA1y1QIEWg+FiDnTxBQiHBvYqXLavMUpEtQbN4sJBOzdwjXoGx1f32qhkjm
         UQ5hSZgYnHGyYS+BOKMdsk/ZU76z85NKKAGY5cTxwglOoMbrrFbO1euJ+vpgRuS9liUu
         Q6pw==
X-Gm-Message-State: ALyK8tJLdWk107pz1wp6drTQJvh5iYr0jVMgBgF1fmYagSesudhxNnqE7F0H46qOHqYLhSA7RL2NiEBHhocjAw==
MIME-Version: 1.0
X-Received: by 10.202.192.196 with SMTP id q187mr21569644oif.126.1464711354713;
 Tue, 31 May 2016 09:15:54 -0700 (PDT)
Received: by 10.202.172.133 with HTTP; Tue, 31 May 2016 09:15:54 -0700 (PDT)
In-Reply-To: <1464428833-27517-1-git-send-email-keguang.zhang@gmail.com>
References: <1464428833-27517-1-git-send-email-keguang.zhang@gmail.com>
Date:   Tue, 31 May 2016 19:15:54 +0300
Message-ID: <CAHp75Ve_6htAQsR5wMMGTjtjyYk=3oftrdSqB+aH7sxHCXLc7A@mail.gmail.com>
Subject: Re: [PATCH V3] dmaengine: Loongson1: add Loongson1 dmaengine driver
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine <dmaengine@vger.kernel.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Sat, May 28, 2016 at 12:47 PM, Keguang Zhang <keguang.zhang@gmail.com> wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
>
> This patch adds DMA Engine driver for Loongson1B.
>
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

> +++ b/drivers/dma/loongson1-dma.c

> +#include <dma.h>
> +
> +#include "dmaengine.h"
> +#include "virt-dma.h"
> +
> +/* Loongson 1 DMA Register Definitions */
> +#define DMA_CTRL               0x0
> +
> +/* DMA Control Register Bits */
> +#define DMA_STOP               BIT(4)
> +#define DMA_START              BIT(3)
> +#define ASK_VALID              BIT(2)
> +
> +#define DMA_ADDR_MASK          (0xffffffc0)

GENMASK() ?

Btw, didn't notice
#include <linux/bitops.h>

> +
> +/* DMA H/W Descriptor Bits */
> +#define NEXT_EN                        BIT(0)
> +
> +/* DMA Command Register Bits */
> +#define DMA_RAM2DEV            BIT(12)
> +#define DMA_TRANS_OVER         BIT(3)
> +#define DMA_SINGLE_TRANS_OVER  BIT(2)
> +#define DMA_INT                        BIT(1)

> +#define DMA_INT_MASK           BIT(0)

GENMASK() ?

> +
> +struct ls1x_dma_hwdesc {
> +       u32 next;               /* next descriptor address */
> +       u32 saddr;              /* memory DMA address */
> +       u32 daddr;              /* device DMA address */
> +       u32 length;
> +       u32 stride;
> +       u32 cycles;
> +       u32 cmd;
> +       u32 phys;               /* used by driver */
> +} __aligned(64);
> +
> +struct ls1x_dma_desc {
> +       struct virt_dma_desc vdesc;
> +       struct ls1x_dma_chan *chan;
> +
> +       enum dma_transfer_direction dir;
> +       enum dma_transaction_type type;
> +
> +       unsigned int nr_descs;  /* number of descriptors */
> +       unsigned int nr_done;   /* number of completed descriptors */
> +       struct ls1x_dma_hwdesc *desc[0];        /* DMA coherent descriptors */
> +};

> +/* macros for registers read/write */
> +#define chan_writel(chan, off, val)    \
> +       __raw_writel((val), (chan)->reg_base + (off))
> +
> +#define chan_readl(chan, off)          \
> +       __raw_readl((chan)->reg_base + (off))
> +

Hmm... Needs a comment why __raw_*() variants are in use.

> +bool ls1x_dma_filter(struct dma_chan *chan, void *param)
> +{
> +       struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
> +       unsigned int chan_id = *(unsigned int *)param;
> +

> +       if (chan_id == dma_chan->id)
> +               return true;
> +       else
> +               return false;

return chan_id == dma_chan->id;

> +}

> +static int ls1x_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +       struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
> +

> +       if (dma_chan->desc_pool)
> +               return 0;

It shouldn't be called more than once. Why do you have this check?

> +
> +       dma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
> +                                             chan->device->dev,
> +                                             sizeof(struct ls1x_dma_hwdesc),
> +                                             __alignof__(struct
> +                                                         ls1x_dma_hwdesc), 0);
> +       if (!dma_chan->desc_pool) {
> +               dev_err(&chan->dev->device,
> +                       "failed to allocate descriptor pool\n");
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}

> +
> +static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
> +{
> +       struct ls1x_dma_desc *dma_desc = to_ls1x_dma_desc(vdesc);
> +       int i;
> +
> +       for (i = 0; i < dma_desc->nr_descs; i++)
> +               dma_pool_free(dma_desc->chan->desc_pool, dma_desc->desc[i],
> +                             dma_desc->desc[i]->phys);
> +       kfree(dma_desc);
> +}
> +
> +static struct ls1x_dma_desc *ls1x_dma_alloc_desc(struct ls1x_dma_chan *dma_chan,
> +                                                int sg_len)
> +{

> +err:

err_free:

> +       dev_err(&chan->dev->device, "failed to allocate H/W DMA descriptor\n");
> +

> +       while (--i >= 0)
> +               dma_pool_free(dma_chan->desc_pool, dma_desc->desc[i],
> +                             dma_desc->desc[i]->phys);
> +       kfree(dma_desc);

I'm pretty sure you might reuse ls1x_dma_free_desc() here.

> +
> +       return NULL;
> +}

> +static struct dma_async_tx_descriptor *
> +ls1x_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +                      unsigned int sg_len,
> +                      enum dma_transfer_direction direction,
> +                      unsigned long flags, void *context)
> +{
> +       struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
> +       struct dma_slave_config *config = &dma_chan->config;
> +       struct ls1x_dma_desc *dma_desc;
> +       struct scatterlist *sg;
> +       unsigned int dev_addr, bus_width, cmd, i;
> +

> +       dev_dbg(&chan->dev->device, "sg_len=%d, dir=%s, flags=0x%lx\n", sg_len,
> +               direction == DMA_MEM_TO_DEV ? "to device" : "from device",
> +               flags);

Btw, you may use dev_vdbg() in some cases. We have two DEBUG options
for DMAengine.
I would suggest to revisit all debugging prints in your driver and
choose suitable level.

> +
> +       switch (direction) {
> +       case DMA_MEM_TO_DEV:
> +               dev_addr = config->dst_addr;
> +               bus_width = config->dst_addr_width;
> +               cmd = DMA_RAM2DEV | DMA_INT;
> +               break;
> +       case DMA_DEV_TO_MEM:
> +               dev_addr = config->src_addr;
> +               bus_width = config->src_addr_width;
> +               cmd = DMA_INT;
> +               break;

> +       default:
> +               dev_err(&chan->dev->device,
> +                       "unsupported DMA transfer mode: %d\n", direction);
> +               return NULL;

Shouldn't happen here.

> +       }
> +
> +       /* allocate DMA descriptors */
> +       dma_desc = ls1x_dma_alloc_desc(dma_chan, sg_len);
> +       if (!dma_desc)
> +               return NULL;
> +       dma_desc->dir = direction;
> +       dma_desc->type = DMA_SLAVE;
> +
> +       /* config DMA descriptors */
> +       for_each_sg(sgl, sg, sg_len, i) {
> +               dma_addr_t buf_addr = sg_dma_address(sg);
> +               size_t buf_len = sg_dma_len(sg);
> +
> +               if (!IS_ALIGNED(buf_addr, 4 * bus_width)) {

> +                       dev_err(&chan->dev->device,
> +                               "buf_addr is not aligned on %d-byte boundary\n",
> +                               4 * bus_width);

Shouldn't we use
 .copy_align = DMAENGINE_ALIGN_4_BYTES;
during the probe?

> +                       ls1x_dma_free_desc(&dma_desc->vdesc);
> +                       return NULL;
> +               }
> +
> +               if (!IS_ALIGNED(buf_len, bus_width))
> +                       dev_warn(&chan->dev->device,
> +                                "buf_len is not aligned on %d-byte boundary\n",
> +                                bus_width);
> +
> +               dma_desc->desc[i]->saddr = buf_addr;
> +               dma_desc->desc[i]->daddr = dev_addr;
> +               dma_desc->desc[i]->length = buf_len / bus_width;
> +               dma_desc->desc[i]->stride = 0;
> +               dma_desc->desc[i]->cycles = 1;
> +               dma_desc->desc[i]->cmd = cmd;
> +               dma_desc->desc[i]->next =
> +                   sg_is_last(sg) ? 0 : dma_desc->desc[i + 1]->phys;
> +
> +               dev_dbg(&chan->dev->device,
> +                       "desc=%p, saddr=%08x, daddr=%08x, length=%u\n",
> +                       &dma_desc->desc[i], buf_addr, dev_addr, buf_len);
> +       }
> +
> +       return vchan_tx_prep(&dma_chan->vchan, &dma_desc->vdesc, flags);
> +}
> +

> +static int ls1x_dma_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct plat_ls1x_dma *pdata = dev_get_platdata(dev);
> +       struct dma_device *dma_dev;
> +       struct ls1x_dma *dma;
> +       struct ls1x_dma_chan *dma_chan;
> +       struct resource *res;
> +       int i, ret;
> +
> +       /* initialize DMA device */
> +       dma =
> +           devm_kzalloc(dev,
> +                        sizeof(struct ls1x_dma) +
> +                        pdata->nr_channels * sizeof(struct ls1x_dma_chan),
> +                        GFP_KERNEL);
> +       if (!dma)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +       if (!res) {
> +               dev_err(dev, "failed to get I/O memory\n");
> +               return -EINVAL;
> +       }

Redundant LOCs since below call does it for you.

> +
> +       dma->reg_base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(dma->reg_base))
> +               return PTR_ERR(dma->reg_base);

> +       /* initialize DMA channels */
> +       for (i = 0; i < pdata->nr_channels; i++) {
> +               dma_chan = &dma->dma_chan[i];
> +               dma_chan->id = i;
> +               dma_chan->reg_base = dma->reg_base;
> +
> +               dma_chan->irq = platform_get_irq(pdev, i);
> +               if (dma_chan->irq < 0) {
> +                       dev_err(dev, "failed to get IRQ: %d\n", dma_chan->irq);
> +                       return -EINVAL;
> +               }
> +
> +               ret =
> +                   devm_request_irq(dev, dma_chan->irq, ls1x_dma_irq_handler,
> +                                    IRQF_SHARED, dev_name(dev), dma_chan);
> +               if (ret) {
> +                       dev_err(dev, "failed to request IRQ %u!\n",
> +                               dma_chan->irq);
> +                       return -EINVAL;
> +               }
> +
> +               dma_chan->vchan.desc_free = ls1x_dma_free_desc;
> +               vchan_init(&dma_chan->vchan, dma_dev);
> +       }

> +       dma->nr_dma_chans = i;

You can't get here when i != nr_channels, so, what's the point to use
counter variable?

> +
> +       dma->clk = devm_clk_get(dev, pdev->name);
> +       if (IS_ERR(dma->clk)) {
> +               dev_err(dev, "failed to get %s clock\n", pdev->name);
> +               return PTR_ERR(dma->clk);
> +       }
> +       clk_prepare_enable(dma->clk);
> +
> +       ret = dma_async_device_register(dma_dev);
> +       if (ret) {
> +               dev_err(dev, "failed to register DMA device\n");
> +               clk_disable_unprepare(dma->clk);
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, dma);
> +       dev_info(dev, "Loongson1 DMA driver registered\n");
> +       for (i = 0; i < pdata->nr_channels; i++) {
> +               dma_chan = &dma->dma_chan[i];

> +               dev = &dma_chan->vchan.chan.dev->device;

 I wouldn't shadow the actual dev pointer.

> +               dev_info(dev, "channel %d at 0x%p (irq %d)\n", dma_chan->id,
> +                        dma_chan->reg_base, dma_chan->irq);
> +       }
> +
> +       return 0;
> +}

> +static struct platform_driver ls1x_dma_driver = {
> +       .probe  = ls1x_dma_probe,
> +       .remove = ls1x_dma_remove,
> +       .driver = {
> +               .name   = "ls1x-dma",

PM ?

> +       },
> +};

-- 
With Best Regards,
Andy Shevchenko
