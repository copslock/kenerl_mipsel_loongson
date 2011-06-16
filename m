Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2011 10:52:26 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:46291 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490997Ab1FPIwV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jun 2011 10:52:21 +0200
Received: by qwi2 with SMTP id 2so135593qwi.36
        for <multiple recipients>; Thu, 16 Jun 2011 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=2kuvyJIdpvFmOTPqZfR6/Ctfkx3rJKcShXp2JF8LBU8=;
        b=dwd1QQvTzLhB+QpJMe0nkSv5OOGjo+Fn6BER/cbChRXKVerCRkLuNJ9TEwOjTn6V3N
         a8xmeEIwohWBTooLQf23i0h5daQHtMGgAc1sHD/aRKB7UuWUnC7LaLeJxOLfNRL+1491
         xjOsBwv2mCwoTv846DBPOyuUJbJ36Qzx4pz6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mx+93QZCgqgI4kNYuRzMddNqoByvdNq6VwOO119RJ6jBtos5MZmmxdGbadnmyOLo+g
         p+PcPJPq19E3Pb6lcdhev/33jEwLqcFLcFxrRDuR33+K0o79yItZ1ZScESb/92jukOVV
         ieVnmyPNre0lKc8rsMzitENGHWkUR5eltKWQI=
Received: by 10.229.9.8 with SMTP id j8mr463059qcj.228.1308214335127; Thu, 16
 Jun 2011 01:52:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.212.206 with HTTP; Thu, 16 Jun 2011 01:51:55 -0700 (PDT)
In-Reply-To: <1307742441-28284-11-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr> <1307742441-28284-11-git-send-email-mbizon@freebox.fr>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 16 Jun 2011 10:51:55 +0200
Message-ID: <BANLkTi=t5zXy-gPrO6z9_unPzTp-xY01hQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] MIPS: BCM63XX: add external irq support for non
 6348 CPUs.
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org, florian@openwrt.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13232

Hi,

On 10 June 2011 23:47, Maxime Bizon <mbizon@freebox.fr> wrote:
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> index 4354be1..0fa613c 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> @@ -104,12 +104,22 @@
>
>  /* External Interrupt Configuration register */
>  #define PERF_EXTIRQ_CFG_REG            0x14
> +
> +/* for 6348 only */
> +#define EXTIRQ_CFG_SENSE_6348(x)       (1 << (x))
> +#define EXTIRQ_CFG_STAT_6348(x)                (1 << (x + 5))
> +#define EXTIRQ_CFG_CLEAR_6348(x)       (1 << (x + 10))
> +#define EXTIRQ_CFG_MASK_6348(x)                (1 << (x + 15))
> +#define EXTIRQ_CFG_BOTHEDGE_6348(x)    (1 << (x + 20))
> +#define EXTIRQ_CFG_LEVELSENSE_6348(x)  (1 << (x + 25))
> +
> +/* for all others */
>  #define EXTIRQ_CFG_SENSE(x)            (1 << (x))
> -#define EXTIRQ_CFG_STAT(x)             (1 << (x + 5))
> -#define EXTIRQ_CFG_CLEAR(x)            (1 << (x + 10))
> -#define EXTIRQ_CFG_MASK(x)             (1 << (x + 15))
> -#define EXTIRQ_CFG_BOTHEDGE(x)         (1 << (x + 20))
> -#define EXTIRQ_CFG_LEVELSENSE(x)       (1 << (x + 25))
> +#define EXTIRQ_CFG_STAT(x)             (1 << (x + 4))
> +#define EXTIRQ_CFG_CLEAR(x)            (1 << (x + 8))
> +#define EXTIRQ_CFG_MASK(x)             (1 << (x + 12))
> +#define EXTIRQ_CFG_BOTHEDGE(x)         (1 << (x + 16))
> +#define EXTIRQ_CFG_LEVELSENSE(x)       (1 << (x + 20))
>
>  #define EXTIRQ_CFG_CLEAR_ALL           (0xf << 10)
>  #define EXTIRQ_CFG_MASK_ALL            (0xf << 15)

These two are still based on the 6348 definition, you should also add
these for non 6348 SoCs.
<http://lxr.linux.no/#linux+v2.6.39/arch/mips/bcm63xx/setup.c#L64>,
where these get used, needs also to be changed to then use the
appropriate one.


Jonas
