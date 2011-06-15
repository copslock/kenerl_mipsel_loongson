Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 14:54:41 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:47253 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490982Ab1FOMyh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 14:54:37 +0200
Received: by qyl38 with SMTP id 38so218811qyl.15
        for <multiple recipients>; Wed, 15 Jun 2011 05:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=6BIBl6xH5kO3eDxm3N7toZxUuaeSa0Pzvq0q6wEraKE=;
        b=JmcBojUm+rOTqHknYKj6gZCwUgE7MoVNK3FSMr4CtfS7FQPab819DvlXzw4mYSyXv5
         CUm3kNJv5mQz52lEwzmoPBSKaXShm4uc2D+OaoiGow4IvEUU5P8RRBdyu/HCCzhkra8h
         cpBasj/W4Y0/S5qcCfLKyLVbrmxiPVkxizvVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kCb0rdGxaboCEN08zUrKJBgcUt6Alru/E6M74wZ+BfEimBNrcrmXdBZ6iH9mnpSZAV
         73ktKXE6Q2+3q3HLhrYPyEMz/CL2siJwTwe1pOtBHHLnVAdNN0BdffN+IqNJlxOYrgKv
         ML5AQ8wnPlNLHK084fpicPV+EQ/CBf1mGNcjQ=
Received: by 10.229.9.8 with SMTP id j8mr353492qcj.228.1308142471084; Wed, 15
 Jun 2011 05:54:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.212.206 with HTTP; Wed, 15 Jun 2011 05:54:11 -0700 (PDT)
In-Reply-To: <1307742441-28284-8-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr> <1307742441-28284-8-git-send-email-mbizon@freebox.fr>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 15 Jun 2011 14:54:11 +0200
Message-ID: <BANLkTi=XTYy9+Qxp9XrykMJoLws1ECL1ig@mail.gmail.com>
Subject: Re: [PATCH 07/11] MIPS: BCM63XX: change irq code to prepare for
 per-cpu peculiarity.
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org, florian@openwrt.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12318

Hi,

On 10 June 2011 23:47, Maxime Bizon <mbizon@freebox.fr> wrote:
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> index 3ea2681..4354be1 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> @@ -89,9 +89,18 @@
>
>  /* Interrupt Mask register */
>  #define PERF_IRQMASK_REG               0xc
> +#define PERF_IRQSTAT_REG               0x10

You are re-adding the duplicate PERF_IRQSTAT_REG I just removed.

> +#define PERF_IRQMASK_6338_REG          0xc
> +#define PERF_IRQMASK_6345_REG          0xc
> +#define PERF_IRQMASK_6348_REG          0xc
> +#define PERF_IRQMASK_6358_REG          0xc

If you are adding one for each SoC, why keep the "generic"
PERF_IRQMASK_REG at all? AFAICS it isn't used it any more.

>
>  /* Interrupt Status register */
>  #define PERF_IRQSTAT_REG               0x10
> +#define PERF_IRQSTAT_6338_REG          0x10
> +#define PERF_IRQSTAT_6345_REG          0x10
> +#define PERF_IRQSTAT_6348_REG          0x10
> +#define PERF_IRQSTAT_6358_REG          0x10

The same applies to the "generic" PERF_IRQSTAT_REG, you can also remove it.


Jonas
