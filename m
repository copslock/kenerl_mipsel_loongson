Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2009 01:45:35 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.179]:36892 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20808587AbZBZBpb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2009 01:45:31 +0000
Received: by wa-out-1112.google.com with SMTP id k40so150576wah.0
        for <multiple recipients>; Wed, 25 Feb 2009 17:45:28 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=R09TYdItmrhytikZSng/0gNe2kEUYZnJDKkn4IU3yUg=;
        b=vJJWJO0Y/GbZREps/fJgIp4CrBk2S5HvFD565nkerZpWI/eQobeNQK7Mzq7m95SC7Z
         NwJNJ40VFaroNBx7Ihvv/SK/xEz17cD937tndOo4Fo6SRKwhjLtrcqwvwWdJRhPuSkAi
         EdPvUfygMtgu9pzLCZn99oTMMf4h2MxnsQ9bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AWo+M3zeUScu+nfe0iInrhZrI63RHzq0G+xZmrJ9WIhHgL6obLyBPlpE137cT2Tzcn
         V1+vnjSJQ3KMdCCEd8aXUQbCalsIHEyE0nMKX+sXpJv/ZW6dr16Wy2hQk+FZItYFmGG+
         CnbaBRu8uyV2A9mHcI3gOr9xGZnHpZu3M7SEg=
MIME-Version: 1.0
Received: by 10.114.121.1 with SMTP id t1mr398473wac.183.1235612728538; Wed, 
	25 Feb 2009 17:45:28 -0800 (PST)
In-Reply-To: <1234538938-23479-1-git-send-email-anemo@mba.ocn.ne.jp>
References: <1234538938-23479-1-git-send-email-anemo@mba.ocn.ne.jp>
Date:	Wed, 25 Feb 2009 18:45:28 -0700
X-Google-Sender-Auth: 94c38c5ed00d7adc
Message-ID: <e9c3a7c20902251745t314c1e0cs114d2199ccc8cf36@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Dan Williams <dan.j.williams@intel.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dan.j.williams@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

Some comments and questions below.

I also added Haavard to the cc since he can more readily spot
interesting differences between this [1] and dw_dmac which you used as
a base.

Regards,
Dan

[1] Haavard, the original post is here:
http://marc.info/?l=linux-kernel&m=123453899907272&w=2

On Fri, Feb 13, 2009 at 8:28 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> This patch adds support for the integrated DMAC of the TXx9 family.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/include/asm/txx9/dmac.h |   40 +
>  drivers/dma/Kconfig               |    8 +
>  drivers/dma/Makefile              |    1 +
>  drivers/dma/txx9dmac.c            | 1605 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 1654 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/txx9/dmac.h
>  create mode 100644 drivers/dma/txx9dmac.c
>
[..]
> +struct txx9dmac_dev {
> +       struct dma_device       dma;
> +       struct dma_device       dma_memcpy;
> +       void __iomem            *regs;
> +#ifndef TXX9_DMA_HAVE_IRQ_PER_CHAN
> +       struct tasklet_struct   tasklet;
> +       int                     irq;
> +#endif
> +#ifdef TXX9_DMA_MAY_HAVE_64BIT_REGS
> +       bool                    have_64bit_regs;
> +#endif
> +       unsigned int            descsize;
> +       struct txx9dmac_chan    chan[TXX9_DMA_MAX_NR_CHANNELS];
> +       struct dma_chan         reserved_chan;
> +};
> +
> +static struct txx9dmac_chan *to_txx9dmac_chan(struct dma_chan *chan)
> +{
> +       return container_of(chan, struct txx9dmac_chan, chan);
> +}
> +
> +static struct txx9dmac_dev *to_txx9dmac_dev(struct dma_device *ddev)
> +{
> +       if (ddev->device_prep_dma_memcpy)
> +               return container_of(ddev, struct txx9dmac_dev, dma_memcpy);
> +       return container_of(ddev, struct txx9dmac_dev, dma);
> +}

Can you explain why you need two dma_devices per txx9dmac_dev?  My
initial reaction is that it should be a bug if callers to
to_txx9dmac_dev() don't know what type of channel they are holding.

[..]
> +
> +static struct txx9dmac_desc *txx9dmac_desc_alloc(struct txx9dmac_chan *dc,
> +                                                gfp_t flags)
> +{
> +       struct txx9dmac_dev *ddev = to_txx9dmac_dev(dc->chan.device);
> +       struct txx9dmac_desc *desc;
> +
> +       desc = kzalloc(sizeof(*desc), flags);
> +       if (!desc)
> +               return NULL;
> +       dma_async_tx_descriptor_init(&desc->txd, &dc->chan);
> +       desc->txd.tx_submit = txx9dmac_tx_submit;
> +       desc->txd.flags = DMA_CTRL_ACK;
> +       INIT_LIST_HEAD(&desc->txd.tx_list);
> +       desc->txd.phys = dma_map_single(chan2parent(&dc->chan), &desc->hwdesc,
> +                                       ddev->descsize, DMA_TO_DEVICE);
> +       return desc;
> +}

By setting DMA_CTRL_ACK by default this means that async_tx can never
attach attach a dependent operation to a txx9 descriptor.  This may
not be a problem in practice because async_tx will only do this to
satisfy inter-channel dependencies.  For example memcpy on chan-foo
followed by xor on chan-bar.  For future proofing the driver I would
rely on clients properly setting the ack bit when they call
->device_prep_dma_memcpy

[..]
> +static void
> +txx9dmac_descriptor_complete(struct txx9dmac_chan *dc,
> +                            struct txx9dmac_desc *desc)
> +{
> +       dma_async_tx_callback callback;
> +       void *param;
> +       struct dma_async_tx_descriptor *txd = &desc->txd;
> +       struct txx9dmac_slave *ds = dc->chan.private;
> +
> +       dev_vdbg(chan2dev(&dc->chan), "descriptor %u %p complete\n",
> +                txd->cookie, desc);
> +
> +       dc->completed = txd->cookie;
> +       callback = txd->callback;
> +       param = txd->callback_param;
> +
> +       txx9dmac_sync_desc_for_cpu(dc, desc);
> +       list_splice_init(&txd->tx_list, &dc->free_list);
> +       list_move(&desc->desc_node, &dc->free_list);
> +
> +       /*
> +        * We use dma_unmap_page() regardless of how the buffers were
> +        * mapped before they were submitted...
> +        */
> +       if (!ds) {
> +               dma_addr_t dmaaddr;
> +               if (!(txd->flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
> +                       dmaaddr = is_dmac64(dc) ?
> +                               desc->hwdesc.DAR : desc->hwdesc32.DAR;
> +                       dma_unmap_page(chan2parent(&dc->chan), dmaaddr,
> +                                      desc->len, DMA_FROM_DEVICE);
> +               }
> +               if (!(txd->flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
> +                       dmaaddr = is_dmac64(dc) ?
> +                               desc->hwdesc.SAR : desc->hwdesc32.SAR;
> +                       dma_unmap_page(chan2parent(&dc->chan), dmaaddr,
> +                                      desc->len, DMA_TO_DEVICE);
> +               }
> +       }
> +
> +       /*
> +        * The API requires that no submissions are done from a
> +        * callback, so we don't need to drop the lock here
> +        */
> +       if (callback)
> +               callback(param);
> +}

This completion needs a call to dma_run_dependencies() for the same
reason it needs to leave the ack bit clear by default.

[..]
> +static irqreturn_t txx9dmac_interrupt(int irq, void *dev_id)
> +{
> +#ifdef TXX9_DMA_HAVE_IRQ_PER_CHAN
> +       struct txx9dmac_chan *dc = dev_id;
> +
> +       dev_vdbg(chan2dev(&dc->chan), "interrupt: status=%#x\n",
> +                       channel_readl(dc, CSR));
> +
> +       tasklet_schedule(&dc->tasklet);
> +#else
> +       struct txx9dmac_dev *ddev = dev_id;
> +
> +       dev_vdbg(ddev->dma.dev, "interrupt: status=%#x\n",
> +                       dma_readl(ddev, MCR));
> +
> +       tasklet_schedule(&ddev->tasklet);
> +#endif
> +       /*
> +        * Just disable the interrupts. We'll turn them back on in the
> +        * softirq handler.
> +        */
> +       disable_irq_nosync(irq);
> +
> +       return IRQ_HANDLED;
> +}

Why do you need to disable interrupts here?

[..]
> +static int txx9dmac_alloc_chan_resources(struct dma_chan *chan)
> +{
> +       struct txx9dmac_chan *dc = to_txx9dmac_chan(chan);
> +       struct txx9dmac_dev *ddev = to_txx9dmac_dev(chan->device);
> +       struct txx9dmac_slave *ds = chan->private;
> +       struct txx9dmac_desc *desc;
> +       int i;
> +
> +       dev_vdbg(chan2dev(chan), "alloc_chan_resources\n");
> +
> +       if (chan == &ddev->reserved_chan) {
> +               /* reserved */
> +               return 0;
> +       }

Can you explain how reserved channels work?  It looks like you are
working around the generic dma channel allocator, maybe it requires
updating to meet your needs.
