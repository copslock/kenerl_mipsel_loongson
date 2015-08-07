Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 23:32:14 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35880 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012892AbbHGVcLPguy3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 23:32:11 +0200
Received: by lbbpu9 with SMTP id pu9so40326907lbb.3;
        Fri, 07 Aug 2015 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uRuaLNneYnUVD+u29jKtmi6vLSc8MkYUVVJOFni7CV8=;
        b=Ob3WVhZVeCxaGsVJn8HJoPdX6SH4niX3VgEYKxZEiIw9kKqf/KoKJZlED7/Iz7KZmL
         Jd9VmKdHWFjMOihQp3e7ojk21zOMCmKfZVpM1WOdbZzaaJQkv/2CgR4rO3vZje1qYYqm
         KOoq/OfJtCG/uq/n9CQnYusff2d3zCrkbK36eFKtVWQkCSOooN6P3+gU9FPWwUIWTxvI
         xc+z4B6pe42HV9p29CuQaIG7cV/LLl3FlxiFiuRsdr7PB7dKrBfUbkk/AMIF31dZ+tRI
         /ohBQfC6dH0aafEAhjdLvAd25R+aWNmzPytKPxwFFCWfbB1A0dyG5s+hGxN/Hwi63/n3
         eJGA==
MIME-Version: 1.0
X-Received: by 10.112.140.132 with SMTP id rg4mr9885827lbb.49.1438983125906;
 Fri, 07 Aug 2015 14:32:05 -0700 (PDT)
Received: by 10.152.133.168 with HTTP; Fri, 7 Aug 2015 14:32:05 -0700 (PDT)
In-Reply-To: <1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
        <1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
Date:   Fri, 7 Aug 2015 23:32:05 +0200
Message-ID: <CAGhQ9VxUYvgGD=K3J3cQ0CNpCC-RfGE9cxhBHnTeAU2CmWkiKA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/9] mmc: dw_mmc: Add external dma interface support
From:   Joachim Eastwood <manabian@gmail.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     jh80.chung@samsung.com, Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <manabian@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manabian@gmail.com
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

Hi Shawn,

On 6 August 2015 at 08:44, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> DesignWare MMC Controller can supports two types of DMA
> mode: external dma and internal dma. We get a RK312x platform
> integrated dw_mmc and ARM pl330 dma controller. This patch add
> edmac ops to support these platforms. I've tested it on RK312x
> platform with edmac mode and RK3288 platform with idmac mode.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

> @@ -2256,26 +2373,30 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>
>         }
>
> -#ifdef CONFIG_MMC_DW_IDMAC
> -       /* Handle DMA interrupts */
> -       if (host->dma_64bit_address == 1) {
> -               pending = mci_readl(host, IDSTS64);
> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
> -                                                       SDMMC_IDMAC_INT_RI);
> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> -                       host->dma_ops->complete(host);
> -               }
> -       } else {
> -               pending = mci_readl(host, IDSTS);
> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
> -                                                       SDMMC_IDMAC_INT_RI);
> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> -                       host->dma_ops->complete(host);
> +       if (host->use_dma == TRANS_MODE_IDMAC) {

Doing:
if (host->use_dma != TRANS_MODE_IDMAC)
    return IRQ_HANDLED;

Could save you the extra level of identation you add below.

> +               /* Handle DMA interrupts */
> +               if (host->dma_64bit_address == 1) {
> +                       pending = mci_readl(host, IDSTS64);
> +                       if (pending & (SDMMC_IDMAC_INT_TI |
> +                                      SDMMC_IDMAC_INT_RI)) {
> +                               mci_writel(host, IDSTS64,
> +                                          SDMMC_IDMAC_INT_TI |
> +                                          SDMMC_IDMAC_INT_RI);
> +                               mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> +                               host->dma_ops->complete((void *)host);
> +                       }
> +               } else {
> +                       pending = mci_readl(host, IDSTS);
> +                       if (pending & (SDMMC_IDMAC_INT_TI |
> +                                      SDMMC_IDMAC_INT_RI)) {
> +                               mci_writel(host, IDSTS,
> +                                          SDMMC_IDMAC_INT_TI |
> +                                          SDMMC_IDMAC_INT_RI);
> +                               mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> +                               host->dma_ops->complete((void *)host);
> +                       }
>                 }
>         }
> -#endif
>
>         return IRQ_HANDLED;
>  }


> @@ -2437,6 +2567,21 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
>  static void dw_mci_init_dma(struct dw_mci *host)
>  {
>         int addr_config;
> +       int trans_mode;
> +       struct device *dev = host->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       /* Check tansfer mode */
> +       trans_mode = (mci_readl(host, HCON) >> 16) & 0x3;

I think it would be nice if you could add some defines for 16 and 0x03
or add a macro like SDMMC_GET_FCNT() that is in dw_mmc.h.

> +       if (trans_mode == 0) {
> +               trans_mode = TRANS_MODE_IDMAC;
> +       } else if (trans_mode == 1 || trans_mode == 2) {
> +               trans_mode = TRANS_MODE_EDMAC;
> +       } else {
> +               trans_mode = TRANS_MODE_PIO;
> +               goto no_dma;
> +       }
> +
>         /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
>         addr_config = (mci_readl(host, HCON) >> 27) & 0x01;

I'll try to get this patch tested on my lpc18xx platform soon.
btw, the HCON reg on lpc18xx reads as 0x00e42cc1 (address 0x40004070).


regard,
Joachim Eastwood
