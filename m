Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2015 11:48:27 +0100 (CET)
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36266 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014017AbbLPKsWGC89L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Dec 2015 11:48:22 +0100
Received: by mail-qk0-f170.google.com with SMTP id t125so56986948qkh.3
        for <linux-mips@linux-mips.org>; Wed, 16 Dec 2015 02:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IvL7jS7AsnEpENjR37jxcyfdNMtBu3dfxoL4kqXt59A=;
        b=ji6+uszhRakgY0x1Iqbnt62mGoYhY+4EKd5NV/ADAzmV1OBnC6y+OwdltO8b2dRJeH
         0M/0ZbX6OgCydz9krCCCwgLAcYjwCjK4vLqv7lfQRjd8Fm38uEyyCBGZtzKzMFEzv9pE
         EOR5AEySm3WojY/YRlekmUOo2AZERlVaOvw/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IvL7jS7AsnEpENjR37jxcyfdNMtBu3dfxoL4kqXt59A=;
        b=assa2fc91XIrrjppAjgnr9ByYvNOOXU8v6pEKiWOEzqDnZKLojPNTTElR/FqgyVx78
         Naruhco2i+PYBKb8uCqcHQY8KGKHF5gyhuR/fu3UD3bOr5PHIwmdFA8Kn8Hq+hKBlXCb
         vxlq+kOBvqEQrBtDT/az9DZBwmdpC6uU/UeK3d0YRpQ8FxajQT6c0RDzSEC8sYrz730M
         Nxt/c8hYtEHNlpa1NefFGmCZGG/51ix4FETpWIsUrepeLyhzXXKWwvDBPugm/a65v2lt
         NN/sf78HYXzaSbomYFPvjPJF+MZs+U201kBPVtJYo/o8nMRovtYCvmqY9p/Y+5MjMtCR
         50zg==
X-Gm-Message-State: ALoCoQm1sYcB8QHsy4BPnozkNxzt9FSCXvCW6eTvoL+kTdlebg0XzxcNzGrFF5ISUYGvxqjpcvsAY9rQesxsskjv2kzSu0k2i8vI07nrnwYf55+ZtRLIrvA=
MIME-Version: 1.0
X-Received: by 10.13.202.194 with SMTP id m185mr4021753ywd.280.1450262896128;
 Wed, 16 Dec 2015 02:48:16 -0800 (PST)
Received: by 10.13.223.140 with HTTP; Wed, 16 Dec 2015 02:48:16 -0800 (PST)
In-Reply-To: <1450133093-7053-13-git-send-email-joshua.henderson@microchip.com>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
        <1450133093-7053-13-git-send-email-joshua.henderson@microchip.com>
Date:   Wed, 16 Dec 2015 11:48:16 +0100
Message-ID: <CAPDyKFpQeq-9G_=n62c8uE+Tkiz3o9jManiOuCZG2qNKwkZ5EQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] mmc: sdhci-pic32: Add PIC32 SDHCI host
 controller driver
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Jean Delvare <jdelvare@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Corneliu Doban <cdoban@broadcom.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Luis de Bethencourt <luisbg@osg.samsung.com>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        yangbo lu <yangbo.lu@freescale.com>,
        Kevin Hao <haokexin@gmail.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Andy Green <andy.green@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

[...]

> +static int pic32_sdhci_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct sdhci_host *host;
> +       struct resource *iomem;
> +       struct pic32_sdhci_pdata *sdhci_pdata;
> +       struct pic32_sdhci_platform_data *plat_data;
> +       unsigned int clk_rate = 0;
> +       int ret;
> +       struct pinctrl *pinctrl;
> +
> +       host = sdhci_alloc_host(dev, sizeof(*sdhci_pdata));
> +       if (IS_ERR(host)) {
> +               ret = PTR_ERR(host);
> +               dev_err(&pdev->dev, "cannot allocate memory for sdhci\n");
> +               goto err;
> +       }
> +
> +       sdhci_pdata = sdhci_priv(host);
> +       sdhci_pdata->pdev = pdev;
> +       platform_set_drvdata(pdev, host);
> +
> +       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       host->ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> +       if (IS_ERR(host->ioaddr)) {
> +               ret = PTR_ERR(host->ioaddr);
> +               dev_err(&pdev->dev, "unable to map iomem: %d\n", ret);
> +               goto err_host;
> +       }
> +
> +       plat_data = pdev->dev.platform_data;
> +       if (plat_data && plat_data->setup_dma) {
> +               ret = plat_data->setup_dma(ADMA_FIFO_RD_THSHLD,
> +                                          ADMA_FIFO_WR_THSHLD);
> +               if (ret)
> +                       goto err_host;
> +       }
> +
> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);

This isn't need as it's already handled by the PM core.

> +       if (IS_ERR(pinctrl)) {
> +               ret = PTR_ERR(pinctrl);
> +               dev_warn(&pdev->dev, "No pinctrl provided %d\n", ret);
> +               if (ret == -EPROBE_DEFER)
> +                       goto err_host;
> +       }
> +
> +       host->ops = &pic32_sdhci_ops;
> +       host->irq = platform_get_irq(pdev, 0);
> +
> +       sdhci_pdata->sys_clk = devm_clk_get(&pdev->dev, "sys_clk");
> +       if (IS_ERR(sdhci_pdata->sys_clk)) {
> +               ret = PTR_ERR(sdhci_pdata->sys_clk);
> +               dev_err(&pdev->dev, "Error getting clock\n");
> +               goto err_host;
> +       }
> +
> +       /* Enable clock when available! */
> +       ret = clk_prepare_enable(sdhci_pdata->sys_clk);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "Error enabling clock\n");
> +               goto err_host;
> +       }
> +
> +       /* SDH CLK enable */
> +       sdhci_pdata->base_clk = devm_clk_get(&pdev->dev, "base_clk");
> +       if (IS_ERR(sdhci_pdata->base_clk)) {
> +               ret = PTR_ERR(sdhci_pdata->base_clk);
> +               dev_err(&pdev->dev, "Error getting clock\n");
> +               goto err_host;
> +       }
> +
> +       /* Enable clock when available! */
> +       ret = clk_prepare_enable(sdhci_pdata->base_clk);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "Error enabling clock\n");
> +               goto err_host;
> +       }
> +
> +       clk_rate = clk_get_rate(sdhci_pdata->base_clk);
> +       dev_dbg(&pdev->dev, "base clock at: %u\n", clk_rate);
> +       clk_rate = clk_get_rate(sdhci_pdata->sys_clk);
> +       dev_dbg(&pdev->dev, "sys clock at: %u\n", clk_rate);

This looks like some leftover from a debugging task. Can you remove them?

> +
> +       host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +
> +       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)

From this point, the error handling doesn't undo clk_prepare_enable().
Please add that.

> +               goto err_host;
> +
> +       ret = pic32_sdhci_probe_platform(pdev, sdhci_pdata);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to probe platform!\n");
> +               goto err_host;
> +       }
> +
> +       ret = sdhci_add_host(host);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "error adding host\n");
> +               goto err_host;
> +       }
> +
> +       dev_info(&pdev->dev, "Successfully added sdhci host\n");
> +       return 0;
> +
> +err_host:
> +       sdhci_free_host(host);
> +err:
> +       dev_err(&pdev->dev, "pic32-sdhci probe failed: %d\n", ret);
> +       return ret;

A general comment for the ->probe() and the below ->remove() callback,
is that you should probably be able to convert to use
sdhci_pltfm_init() and sdhci_pltfm_free() in favor of
sdhci_alloc_host() and sdhci_free_host().

I think that could simplify the code a bit.

> +}
> +
> +static int pic32_sdhci_remove(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct pic32_sdhci_pdata *sdhci_pdata = sdhci_priv(host);
> +       int dead = 0;
> +       u32 scratch;
> +
> +       scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
> +       if (scratch == (u32)-1)
> +               dead = 1;
> +
> +       sdhci_remove_host(host, dead);
> +       clk_disable_unprepare(sdhci_pdata->base_clk);
> +       clk_disable_unprepare(sdhci_pdata->sys_clk);
> +       sdhci_free_host(host);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id pic32_sdhci_id_table[] = {
> +       { .compatible = "microchip,pic32mzda-sdhci" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
> +
> +static struct platform_driver pic32_sdhci_driver = {
> +       .driver = {
> +               .name   = DEV_NAME,
> +               .owner  = THIS_MODULE,
> +               .of_match_table = of_match_ptr(pic32_sdhci_id_table),
> +       },
> +       .probe          = pic32_sdhci_probe,
> +       .remove         = pic32_sdhci_remove,
> +};
> +
> +module_platform_driver(pic32_sdhci_driver);
> +
> +MODULE_DESCRIPTION("Microchip PIC32 SDHCI driver");
> +MODULE_AUTHOR("Pistirica Sorin Andrei & Sandeep Sheriker");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.9.5
>

Kind regards
Uffe
