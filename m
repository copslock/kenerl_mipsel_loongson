Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 14:53:05 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:33055 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490982Ab1FOMxA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 14:53:00 +0200
Received: by qyl38 with SMTP id 38so217919qyl.15
        for <multiple recipients>; Wed, 15 Jun 2011 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=WEVjYRpH3DvnAtTHz+2ucI9T7s2rHURKpOHmvCZzRBw=;
        b=Kj6DHGxbOI89safhhl40XG9S2yrFY9KO/ewsIfAHyX6g4kJFwxxA58MDK7p24F78El
         c3Fxi5lCppeMJWUHRJtT2iUWzByBrA2uB+4HmbOcsMzSpoY7ywB6IZdUZdBxg+FlXKTT
         mGsbr/9vtEI2/0rnV8blOc+rVuvWfJTJJjX5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AhXExWMho/IyBW/5aPiD586wIl7mKpII3QH5iC1p3nrn/ZzrGVmbCq6bAS94mW6/Em
         Sr6C2eDsTVXhCp7zTgr3NaHZeBT9xtBEoi8McoWn39kf0pH2BaIwtHm5rbpuw/lkSGxm
         DknlPNl6YjVLoN6YEGM91n37nV0QP8nVLxPx4=
Received: by 10.229.9.8 with SMTP id j8mr351825qcj.228.1308142374177; Wed, 15
 Jun 2011 05:52:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.212.206 with HTTP; Wed, 15 Jun 2011 05:52:34 -0700 (PDT)
In-Reply-To: <1307742441-28284-7-git-send-email-mbizon@freebox.fr>
References: <1307742441-28284-1-git-send-email-mbizon@freebox.fr> <1307742441-28284-7-git-send-email-mbizon@freebox.fr>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 15 Jun 2011 14:52:34 +0200
Message-ID: <BANLkTikJ_MCPXweUD+OdWBLx-59L-Geaaw@mail.gmail.com>
Subject: Re: [PATCH 06/11] MIPS: BCM63XX: add more register sets & missing
 register definitions.
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org, florian@openwrt.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12316

Hi,

On 10 June 2011 23:47, Maxime Bizon <mbizon@freebox.fr> wrote:
> Needed for upcoming 6368 CPU support.
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |  183 +++++++++++++++++++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   78 +++++++++
>  2 files changed, 261 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> index 464f948..ce6b3ca 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> @@ -88,6 +88,7 @@ enum bcm63xx_regs_set {
>        RSET_UART1,
>        RSET_GPIO,
>        RSET_SPI,
> +       RSET_SPI2,

What's the difference between SPI and SPI2?

As far as I can tell the biggest difference between the bcm6338/48 SPI
controller and the bcm6358/68 one is the order of the registers (and
some bit positions), but the general way it works is the same. Unless
you have two drivers (which will then probably have a lot of common
code), you'll need to check the chipid anyway to know which RSET to
use, so you could also just direcly use this to use the correct
register offsets.

The High-Speed SPI controller on the bcm6328, bcm63268 and bcm6362 is
a totally different beast though, that one should get it's own
register set (but that's in the future ;-).

>        RSET_UDC0,
>        RSET_OHCI0,
>        RSET_OHCI_PRIV,
> @@ -98,10 +99,23 @@ enum bcm63xx_regs_set {
>        RSET_ENET0,
>        RSET_ENET1,
>        RSET_ENETDMA,
> +       RSET_ENETDMAC,
> +       RSET_ENETDMAS,
> +       RSET_ENETSW,
>        RSET_EHCI0,
>        RSET_SDRAM,
>        RSET_MEMC,
>        RSET_DDR,
> +       RSET_M2M,
> +       RSET_ATM,
> +       RSET_XTM,
> +       RSET_XTMDMA,
> +       RSET_XTMDMAC,
> +       RSET_XTMDMAS,
> +       RSET_PCM,
> +       RSET_PCMDMA,
> +       RSET_PCMDMAC,
> +       RSET_PCMDMAS,
>  };
>
>  #define RSET_DSL_LMEM_SIZE             (64 * 1024 * 4)
> @@ -109,11 +123,18 @@ enum bcm63xx_regs_set {
>  #define RSET_WDT_SIZE                  12
>  #define RSET_ENET_SIZE                 2048
>  #define RSET_ENETDMA_SIZE              2048
> +#define RSET_ENETSW_SIZE               65536
>  #define RSET_UART_SIZE                 24
>  #define RSET_UDC_SIZE                  256
>  #define RSET_OHCI_SIZE                 256
>  #define RSET_EHCI_SIZE                 256
>  #define RSET_PCMCIA_SIZE               12
> +#define RSET_M2M_SIZE                  256
> +#define RSET_ATM_SIZE                  4096
> +#define RSET_XTM_SIZE                  10240
> +#define RSET_XTMDMA_SIZE               256
> +#define RSET_XTMDMAC_SIZE(chans)       (16 * (chans))
> +#define RSET_XTMDMAS_SIZE(chans)       (16 * (chans))
>
>  /*
>  * 6338 register sets base address
> @@ -127,6 +148,7 @@ enum bcm63xx_regs_set {
>  #define BCM_6338_UART1_BASE            (0xdeadbeef)
>  #define BCM_6338_GPIO_BASE             (0xfffe0400)
>  #define BCM_6338_SPI_BASE              (0xfffe0c00)
> +#define BCM_6338_SPI2_BASE             (0xdeadbeef)
>  #define BCM_6338_UDC0_BASE             (0xdeadbeef)
>  #define BCM_6338_USBDMA_BASE           (0xfffe2400)
>  #define BCM_6338_OHCI0_BASE            (0xdeadbeef)
> @@ -141,10 +163,23 @@ enum bcm63xx_regs_set {
>  #define BCM_6338_ENET0_BASE            (0xfffe2800)
>  #define BCM_6338_ENET1_BASE            (0xdeadbeef)
>  #define BCM_6338_ENETDMA_BASE          (0xfffe2400)
> +#define BCM_6338_ENETDMAC_BASE         (0xfffe2500)
> +#define BCM_6338_ENETDMAS_BASE         (0xfffe2600)
> +#define BCM_6338_ENETSW_BASE           (0xdeadbeef)
>  #define BCM_6338_EHCI0_BASE            (0xdeadbeef)
>  #define BCM_6338_SDRAM_BASE            (0xfffe3100)
>  #define BCM_6338_MEMC_BASE             (0xdeadbeef)
>  #define BCM_6338_DDR_BASE              (0xdeadbeef)
> +#define BCM_6338_M2M_BASE              (0xdeadbeef)
> +#define BCM_6338_ATM_BASE              (0xdeadbeef)

That one is already there, it's called BCM_6338_SAR_BASE. You should
just rename that one.

> +#define BCM_6338_XTM_BASE              (0xdeadbeef)
> +#define BCM_6338_XTMDMA_BASE           (0xdeadbeef)
> +#define BCM_6338_XTMDMAC_BASE          (0xdeadbeef)
> +#define BCM_6338_XTMDMAS_BASE          (0xdeadbeef)
> +#define BCM_6338_PCM_BASE              (0xdeadbeef)
> +#define BCM_6338_PCMDMA_BASE           (0xdeadbeef)
> +#define BCM_6338_PCMDMAC_BASE          (0xdeadbeef)
> +#define BCM_6338_PCMDMAS_BASE          (0xdeadbeef)
>
>  /*
>  * 6345 register sets base address
> @@ -158,10 +193,14 @@ enum bcm63xx_regs_set {
>  #define BCM_6345_UART1_BASE            (0xdeadbeef)
>  #define BCM_6345_GPIO_BASE             (0xfffe0400)
>  #define BCM_6345_SPI_BASE              (0xdeadbeef)
> +#define BCM_6345_SPI2_BASE             (0xdeadbeef)
>  #define BCM_6345_UDC0_BASE             (0xdeadbeef)
>  #define BCM_6345_USBDMA_BASE           (0xfffe2800)
>  #define BCM_6345_ENET0_BASE            (0xfffe1800)
>  #define BCM_6345_ENETDMA_BASE          (0xfffe2800)
> +#define BCM_6345_ENETDMAC_BASE         (0xfffe2900)
> +#define BCM_6345_ENETDMAS_BASE         (0xfffe2a00)
> +#define BCM_6345_ENETSW_BASE           (0xdeadbeef)
>  #define BCM_6345_PCMCIA_BASE           (0xfffe2028)
>  #define BCM_6345_MPI_BASE              (0xdeadbeef)
>  #define BCM_6345_OHCI0_BASE            (0xfffe2100)
> @@ -176,6 +215,16 @@ enum bcm63xx_regs_set {
>  #define BCM_6345_SDRAM_BASE            (0xfffe2300)
>  #define BCM_6345_MEMC_BASE             (0xdeadbeef)
>  #define BCM_6345_DDR_BASE              (0xdeadbeef)
> +#define BCM_6345_M2M_BASE              (0xdeadbeef)
> +#define BCM_6345_ATM_BASE              (0xdeadbeef)

Actually that would be 0xfffe4000 (same as the bcm6348). There's also
a SAR_BASE which should be removed.


Jonas
