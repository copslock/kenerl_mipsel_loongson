Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 11:42:24 +0100 (CET)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33422 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007972AbaLUKmVvwZEY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2014 11:42:21 +0100
Received: by mail-ig0-f175.google.com with SMTP id h15so2752867igd.2;
        Sun, 21 Dec 2014 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VGjF3AE8wVjn4XaWvWfSm1sOVJjPlLkyNTW28UnB80A=;
        b=kpXGkgW+xGquc6VPTZGwRh168VvdtvVm2Qp+BO3gLZu1RhL33M4+jmCTD5vlhnDS7W
         aFN4AqVdPRvlEyXMnVnXWVPVGd+5MUa5iYV79mbFC126jd0nJM13JhxtvzY1YSH31llX
         JfUgEEY6e14jzyhuBVpjVtjpdpa5sthr8nZTWprOcHYhWN0E7+ulsJ8lV0DOylSk/11G
         Km1jDktZYRmW7FIwz4AeRFfKeBjA1ev8XcmSA/vs5FCtbG4CSwCddvivm51ZgNbVjnX8
         6nXWdt5F22bboeB6xaZ9Ol1zaAcV5/j6G/ZSv8JpM9tYMpnZ2zPDv3C8g3rmVGWUINNg
         SLlA==
X-Received: by 10.50.79.202 with SMTP id l10mr11264668igx.24.1419158535369;
 Sun, 21 Dec 2014 02:42:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.165.65 with HTTP; Sun, 21 Dec 2014 02:41:35 -0800 (PST)
In-Reply-To: <1418985621-4210-1-git-send-email-jaedon.shin@gmail.com>
References: <1418985621-4210-1-git-send-email-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 21 Dec 2014 02:41:35 -0800
Message-ID: <CAGVrzcYaKF2M_pZTvB6kGM2czrTQq2KhV1BTKb0VkQivjMsNxg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BMIPS: fix overwriting without setting the bit
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014-12-19 2:40 GMT-08:00 Jaedon Shin <jaedon.shin@gmail.com>:
> To flush to readahead cache, set 8th bit in the RAC_CONFIG.
>
> The previous commit "MIPS: BMIPS: Flush the readahead cache after DMA"
> has a problem overwriting to the original other configuration values.

Right, after the the first write we would basically disable the RAC entirely.

>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/mips/mm/dma-default.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index ee6d12c..38ee47a 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -74,9 +74,11 @@ static inline int cpu_needs_post_dma_flush(struct device *dev)
>             boot_cpu_type() == CPU_BMIPS4350 ||
>             boot_cpu_type() == CPU_BMIPS4380) {
>                 void __iomem *cbr = BMIPS_GET_CBR();
> +               u32 cfg;
>
>                 /* Flush stale data out of the readahead cache */
> -               __raw_writel(0x100, cbr + BMIPS_RAC_CONFIG);
> +               cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
> +               __raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
>                 __raw_readl(cbr + BMIPS_RAC_CONFIG);
>
>                 return 0;
> --
> 1.9.3
>
>



-- 
Florian
