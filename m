Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 20:41:25 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:62380 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904113Ab1KWTlS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 20:41:18 +0100
Received: by bkat2 with SMTP id t2so2058018bka.36
        for <multiple recipients>; Wed, 23 Nov 2011 11:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=9GnRiseOvOod3NaKmDcwST9TlekI935a6c9rP9+e9Fg=;
        b=r09YaZxVlYpB11UJ8LlqX+wVcatPHGljHb7xHxau/oxvKN6C8lVZMBPs48Dve4x10i
         k888qSV/BTDpSh7AhJ2tnzvLynxNuOH++jdcUp08xPdvMOtt6suMTc7L3u0MvjGhJyEf
         nXD0HYtMS3LL3bTrsZbfc738K6jQT97NJagwk=
Received: by 10.204.154.201 with SMTP id p9mr26074919bkw.33.1322077273039;
        Wed, 23 Nov 2011 11:41:13 -0800 (PST)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id e20sm22959939fab.2.2011.11.23.11.41.09
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 11:41:10 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH spi-next] spi: add Broadcom BCM63xx SPI controller driver
Date:   Wed, 23 Nov 2011 20:41:18 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-1-amd64; KDE/4.6.5; x86_64; ; )
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>,
        spi-devel-general@lists.sourceforge.net, ralf@linux-mips.org,
        linux-mips@linux-mips.org
References: <1321906615-11392-1-git-send-email-florian@openwrt.org> <CAM=Q2cudxgW-B_TEDgBrdk4CFB9LgZqE9db6vDH+MJEgJeCQcg@mail.gmail.com>
In-Reply-To: <CAM=Q2cudxgW-B_TEDgBrdk4CFB9LgZqE9db6vDH+MJEgJeCQcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201111232041.18477.florian@openwrt.org>
X-archive-position: 31956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20250

Hi  Shubhrajyoti

Le mardi 22 novembre 2011 09:26:07, Shubhrajyoti Datta a écrit :
> Hi Florian,
> 
> On Tue, Nov 22, 2011 at 1:46 AM, Florian Fainelli <florian@openwrt.org> 
wrote:
[snip]
> > +       bs->irq = irq;
> > +       bs->clk = clk;
> > +       bs->fifo_size = pdata->fifo_size;
> > +
> > +       ret = request_irq(irq, bcm63xx_spi_interrupt, 0, pdev->name,
> > master); +       if (ret) {
> > +               dev_err(dev, "unable to request irq\n");
> > +               goto out_unmap;
> > +       }
> 
> Could this be a threaded irq ?

I see no reasons why it could not. Is this a requirement for accepting new 
drivers? I see no drivers doing this in Grant's spi/next branch.

> 
> > +
> > +       master->bus_num = pdata->bus_num;
> > +       master->num_chipselect = pdata->num_chipselect;
> > +       master->setup = bcm63xx_spi_setup;
> > +       master->transfer = bcm63xx_transfer;
> > +       bs->speed_hz = pdata->speed_hz;
> > +       bs->stopping = 0;
> > +       bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
> > +       bs->rx_io = (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DATA));
> > +       spin_lock_init(&bs->lock);
> > +
> > +       /* Initialize hardware */
> > +       clk_enable(bs->clk);
> > +       bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
> > +
> > +       /* register and we are done */
> > +       ret = spi_register_master(master);
> > +       if (ret) {
> > +               dev_err(dev, "spi register failed\n");
> > +               goto out_reset_hw;
> > +       }
> > +
> > +       dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d) v%s\n",
> > +                r->start, irq, bs->fifo_size, DRV_VER);
> > +
> > +       return 0;
> > +
> > +out_reset_hw:
> > +       clk_disable(clk);
> > +       free_irq(irq, master);
> > +out_unmap:
> > +       iounmap(bs->regs);
> > +out_put_master:
> > +       spi_master_put(master);
> > +out_free:
> > +       clk_put(clk);
> > +out:
> > +       return ret;
> > +}
> > +
> > +static int __exit bcm63xx_spi_remove(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +       struct bcm63xx_spi *bs = spi_master_get_devdata(master);
> > +       struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM,
> > 0); +
> > +       /* reset spi block */
> > +       bcm_spi_writeb(bs, 0, SPI_INT_MASK);
> > +       spin_lock(&bs->lock);
> > +       bs->stopping = 1;
> > +
> > +       /* HW shutdown */
> > +       clk_disable(bs->clk);
> > +       clk_put(bs->clk);
> > +
> > +       spin_unlock(&bs->lock);
> > +
> > +       free_irq(bs->irq, master);
> > +       iounmap(bs->regs);
> > +       release_mem_region(r->start, r->end - r->start);
> > +       platform_set_drvdata(pdev, 0);
> > +       spi_unregister_master(master);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int bcm63xx_spi_suspend(struct platform_device *pdev,
> > pm_message_t mesg) +{
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +       struct bcm63xx_spi *bs = spi_master_get_devdata(master);
> > +
> > +       clk_disable(bs->clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int bcm63xx_spi_resume(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +       struct bcm63xx_spi *bs = spi_master_get_devdata(master);
> > +
> > +       clk_enable(bs->clk);
> > +
> > +       return 0;
> > +}
> > +#else
> > +#define bcm63xx_spi_suspend    NULL
> > +#define bcm63xx_spi_resume     NULL
> > +#endif
> > +
> > +static struct platform_driver bcm63xx_spi_driver = {
> > +       .driver = {
> > +               .name   = "bcm63xx-spi",
> > +               .owner  = THIS_MODULE,
> > +       },
> > +       .probe          = bcm63xx_spi_probe,
> > +       .remove         = __exit_p(bcm63xx_spi_remove),
> > +       .suspend        = bcm63xx_spi_suspend,
> > +       .resume         = bcm63xx_spi_resume,
> 
> Could we move to dev pm ops?

Sure, I have fixed that in version 2 of the patch.

-- 
Florian
