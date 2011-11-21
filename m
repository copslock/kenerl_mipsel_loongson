Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 11:12:22 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:56950 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903711Ab1KUKMP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 11:12:15 +0100
Received: by ghbg15 with SMTP id g15so2998494ghb.36
        for <multiple recipients>; Mon, 21 Nov 2011 02:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/j08jdStfL3lTt0T+NmaxUwJKscmaQA4LKob4k7KDc4=;
        b=qUxR5oTA9ji1oIycDd4cLRHbBzHGCjYY6a17SZV4BDEhCT1tJ5vD1+Vdb5WHEH2jSk
         TYs5g2lntxzN8USUsVKb38Y98ysaa7hBHCHVgzPtzg421kcotxwKjrwQEplD0V8CCv1U
         A5SvbK3q1fR1efFwgXqZi9RQ//jNYgx6J7gSc=
Received: by 10.182.220.7 with SMTP id ps7mr360830obc.51.1321870328530; Mon,
 21 Nov 2011 02:12:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.29.195 with HTTP; Mon, 21 Nov 2011 02:11:46 -0800 (PST)
In-Reply-To: <1321866861-14340-8-git-send-email-florian@openwrt.org>
References: <1321866861-14340-1-git-send-email-florian@openwrt.org> <1321866861-14340-8-git-send-email-florian@openwrt.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 21 Nov 2011 11:11:46 +0100
X-Google-Sender-Auth: HKBpPQlIHd-pWn_Lz15ufq5VsyA
Message-ID: <CAGVrzcZMeUha9uqe7zaX7tKj+bFnb-scyni7Y61R3qwOM_+WnA@mail.gmail.com>
Subject: Re: [PATCH 7/9] MIPS: BCM63XX: add stub to register the SPI platform driver
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17085

Hello Ralf,

2011/11/21 Florian Fainelli <florian@openwrt.org>:
> This patch adds the necessary stub to register the SPI platform driver.
> Since the registers are shuffled between the 4 BCM63xx CPUs supported by
> this SPI driver we also need to generate the internal register layout and
> export this layout for the driver to use it properly.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/bcm63xx/dev-spi.c                        |  117 ++++++++++++++++++++
>  .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   89 +++++++++++++++
>  2 files changed, 206 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/bcm63xx/dev-spi.c
>  create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
>
> diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
> new file mode 100644
> index 0000000..b0faa85
> --- /dev/null
> +++ b/arch/mips/bcm63xx/dev-spi.c
> @@ -0,0 +1,117 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2009-2011 Florian Fainelli <florian@openwrt.org>
> + * Copyright (C) 2010 Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +
> +#include <bcm63xx_cpu.h>
> +#include <bcm63xx_dev_spi.h>
> +#include <bcm63xx_regs.h>
> +
> +#ifdef BCMCPU_RUNTIME_DETECT
> +/*
> + * register offsets
> + */
> +static const unsigned long bcm6338_regs_spi[] = {
> +       __GEN_SPI_REGS_TABLE(6338)
> +};
> +
> +static const unsigned long bcm6348_regs_spi[] = {
> +       __GEN_SPI_REGS_TABLE(6348)
> +};
> +
> +static const unsigned long bcm6358_regs_spi[] = {
> +       __GEN_SPI_REGS_TABLE(6358)
> +};
> +
> +static const unsigned long bcm6368_regs_spi[] = {
> +       __GEN_SPI_REGS_TABLE(6368)
> +};
> +
> +const unsigned long *bcm63xx_regs_spi;
> +EXPORT_SYMBOL(bcm63xx_regs_spi);
> +
> +static __init void bcm63xx_spi_regs_init(void)
> +{
> +       if (BCMCPU_IS_6338())
> +               bcm63xx_regs_spi = bcm6338_regs_spi;
> +       if (BCMCPU_IS_6348())
> +               bcm63xx_regs_spi = bcm6348_regs_spi;
> +       if (BCMCPU_IS_6358())
> +               bcm63xx_regs_spi = bcm6358_regs_spi;
> +       if (BCMCPU_IS_6368())
> +               bcm63xx_regs_spi = bcm6358_regs_spi;

There is a typo here, I will resubmit a version 2 of the patchset.
--
Florian
