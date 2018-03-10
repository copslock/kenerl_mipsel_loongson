Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 23:44:37 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:42882
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992818AbeCJWobLLRMt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Mar 2018 23:44:31 +0100
Received: by mail-pf0-x243.google.com with SMTP id a16so2760073pfn.9
        for <linux-mips@linux-mips.org>; Sat, 10 Mar 2018 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HFe2GthZsfZWNIb+5Uk/Jl0CvTvOrRJlc5N/dS3ZvE8=;
        b=A+CAKYe9vTEsNzV/ENeRrZxWGFKo1uGfPK8YN6nsfJLGGHuq/o8k7k7h+Ql6ZLsFkt
         b/lLy5450UUZHYv041E3nnS6bAdbXxDdT7tvwNNVoepbPBRk2YF/rbZH8tnCqVWfeMEZ
         4i4sda4W088DWWGL2t31BSCRrnAeagt+PCgLnBWRxW0vgHRwx/z9/rZtw7lXxdtz+Bx9
         AyoAMtUrIf4dxNs69JSdfQ4ho5uYHXa8QWyP98QAhnW7c1Zzi+TXiQeue6uq5f+FKSfP
         z5NbJUUq0SNVieKMkIUfRTbDsvTaOTTqD4nT8i6/GSHS57o3tPEcL6TclQJfWR+dp8WT
         L0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HFe2GthZsfZWNIb+5Uk/Jl0CvTvOrRJlc5N/dS3ZvE8=;
        b=fdYb+Hupe7QDEXIY2HNUaRLzrh2BbhPRgH3L/sF1cYG4MCNQru3y8BnpVv2UP6jX2p
         pIq0ADXMVd96poR+LNU6HwD2cI9bfMh8dPmw8JQtz1hIrrQ5x5aJwKY4uaL3t6mnE83T
         JZO9WRy+sOvDXRw9mNWKzuty04+MQMC/w2ruQmUIhbrpCrHkCWdIzGszQth8Fzv99Oxi
         r80+UmZU6yvKay5DQNL1ZXE0lABTm9NXlXUWtLUO7SHpBwDhaLlGUOIjekrc8soOFI09
         xergqzioAEJS9bj7+onGivJLFd06MyO6/U7Qype0IbB3S5RynysCWv2ngkS/E1Y43tAz
         QZTQ==
X-Gm-Message-State: AElRT7GLs4ulNZs4bproScyQcfCFoUAPTlmvEj20E9StBBVy4pU3LzPo
        YJwZUNYvyZmLFmXvuC/K7evbT3XM6VkoDrd+djJrUw==
X-Google-Smtp-Source: AG47ELspVjugSwu9SWr7mZOaQM0yfr0Y1Tl/nfmncSLsWPUd7xUlcQMST7v6xEFPH3X7j2pXXutfHtns7IHvd3dKpWo=
X-Received: by 10.99.124.7 with SMTP id x7mr2604428pgc.356.1520721864137; Sat,
 10 Mar 2018 14:44:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.149.10 with HTTP; Sat, 10 Mar 2018 14:44:23 -0800 (PST)
In-Reply-To: <df6880caf0291e32250deafeb4c71476@crapouillou.net>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-9-ezequiel@vanguardiasur.com.ar> <df6880caf0291e32250deafeb4c71476@crapouillou.net>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 10 Mar 2018 19:44:23 -0300
Message-ID: <CAAEAJfDm6-HVxmqhNLtgDjrW5uRrc-Soqn7=J0qpkQ3CbpSD3Q@mail.gmail.com>
Subject: Re: [PATCH 08/14] mmc: jz4740: Add support for the JZ4780
To:     Paul Cercueil <paul@crapouillou.net>,
        James Hogan <jhogan@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

On 9 March 2018 at 14:51, Paul Cercueil <paul@crapouillou.net> wrote:
> Hi,
>
>
> Le 2018-03-09 16:12, Ezequiel Garcia a écrit :
>>
>> From: Alex Smith <alex.smith@imgtec.com>
>>
>> Add support for the JZ4780 MMC controller to the jz47xx_mmc driver. There
>> are a few minor differences from the 4740 to the 4780 that need to be
>> handled, but otherwise the controllers behave the same. The IREG and IMASK
>> registers are expanded to 32 bits. Additionally, some error conditions are
>> now reported in both STATUS and IREG. Writing IREG before reading STATUS
>> causes the bits in STATUS to be cleared, so STATUS must be read first to
>> ensure we see and report error conditions correctly.
>>
>> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> [Ezequiel: rebase and introduce register accessors]
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> ---
>>  drivers/mmc/host/Kconfig      |   2 +-
>>  drivers/mmc/host/jz4740_mmc.c | 111
>> ++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 93 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 620c2d90a646..7dd5169a2dfb 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -767,7 +767,7 @@ config MMC_SH_MMCIF
>>
>>  config MMC_JZ4740
>>         tristate "JZ4740 SD/Multimedia Card Interface support"
>> -       depends on MACH_JZ4740
>> +       depends on MACH_JZ4740 || MACH_JZ4780
>>         help
>>           This selects support for the SD/MMC controller on Ingenic JZ4740
>>           SoCs.
>> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
>> index 7d4dcce76cd8..bb1b9114ef53 100644
>> --- a/drivers/mmc/host/jz4740_mmc.c
>> +++ b/drivers/mmc/host/jz4740_mmc.c
>> @@ -1,5 +1,7 @@
>>  /*
>>   *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
>> + *  Copyright (C) 2013, Imagination Technologies
>> + *
>>   *  JZ4740 SD/MMC controller driver
>>   *
>>   *  This program is free software; you can redistribute  it and/or modify
>> it
>> @@ -52,6 +54,7 @@
>>  #define JZ_REG_MMC_RESP_FIFO   0x34
>>  #define JZ_REG_MMC_RXFIFO      0x38
>>  #define JZ_REG_MMC_TXFIFO      0x3C
>> +#define JZ_REG_MMC_DMAC                0x44
>>
>>  #define JZ_MMC_STRPCL_EXIT_MULTIPLE BIT(7)
>>  #define JZ_MMC_STRPCL_EXIT_TRANSFER BIT(6)
>> @@ -105,11 +108,15 @@
>>  #define JZ_MMC_IRQ_PRG_DONE BIT(1)
>>  #define JZ_MMC_IRQ_DATA_TRAN_DONE BIT(0)
>>
>> +#define JZ_MMC_DMAC_DMA_SEL BIT(1)
>> +#define JZ_MMC_DMAC_DMA_EN BIT(0)
>>
>>  #define JZ_MMC_CLK_RATE 24000000
>>
>>  enum jz4740_mmc_version {
>>         JZ_MMC_JZ4740,
>> +       JZ_MMC_JZ4750,
>> +       JZ_MMC_JZ4780,
>>  };
>>
>>  enum jz4740_mmc_state {
>> @@ -144,7 +151,7 @@ struct jz4740_mmc_host {
>>
>>         uint32_t cmdat;
>>
>> -       uint16_t irq_mask;
>> +       uint32_t irq_mask;
>>
>>         spinlock_t lock;
>>
>> @@ -164,8 +171,46 @@ struct jz4740_mmc_host {
>>   * trigger is when data words in MSC_TXFIFO is < 8.
>>   */
>>  #define JZ4740_MMC_FIFO_HALF_SIZE 8
>> +
>> +       void (*write_irq_mask)(struct jz4740_mmc_host *host, uint32_t
>> val);
>> +       void (*write_irq_reg)(struct jz4740_mmc_host *host, uint32_t val);
>> +       uint32_t (*read_irq_reg)(struct jz4740_mmc_host *host);
>>  };
>
>
> I'm not 100% fan about the callback idea, the original commit
> (https://github.com/gcwnow/linux/commit/62472091) doesn't use them and is
> 30 lines shorter.
>
> I'm not terribly against either, so if nobody else bug on that, feel free
> to ignore my comment.
>

On 9 March 2018 at 19:31, James Hogan <james.hogan@mips.com> wrote:
>
> I was thinking the same as Paul too to be honest. Unless there is a
> measurable benefit to having callbacks, I think its cleaner and more
> readable to stick to conditionals and normal abstractions where
> appropriate.

Well, I believe the benefit of having callbacks is scalability and readability,
but perhaps it's only a matter of taste. Once the helpers are there,
adding a new one is just adding the callbacks.

I've always thought this:

static uint32_t jz4740_mmc_read_irq_reg(struct jz4740_mmc_host *host)
{
        return readw(host->base + JZ_REG_MMC_IREG);
}

static uint32_t jz4780_mmc_read_irq_reg(struct jz4740_mmc_host *host)
{
        return readl(host->base + JZ_REG_MMC_IREG);
}

looks so much better than this:

static uint32_t jz_mmc_read_irq_reg(struct jz4740_mmc_host *host)
{
        if (host->version == JZ_MMC_JZ4780) {
                return readl(host->base + JZ_REG_MMC_IREG);
        } else if ... {
                return readw(host->base + JZ_REG_MMC_IREG);
        }
}

In any case, if you guys are strong about the if-else-ism,
I'm fine changing it.
-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar
