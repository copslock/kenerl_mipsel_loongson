Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 18:19:52 +0100 (CET)
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:53841 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006617AbbKRRTuqtyjI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 18:19:50 +0100
Received: from io (unknown [96.238.82.161])
        by outbound1.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Tue, 17 Nov 2015 20:03:45 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id EBD3B80057;
        Tue, 17 Nov 2015 20:03:27 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io EBD3B80057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1447790608;
        bh=gRo41NX0wqRGR7F67keMKtFfz40mjKoymYZSc3M/4Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RT3bvTvgPxTuoATgwWQhlK8EfzZtf53+5f6qFcvX8TbmCesQTyMcL8QEQtFcY6OG6
         /z6qS1LAyaKQVg9+5Li18y0ekIQOLfXOEkGbDRHhbkfeUbHMfq5zlS68cJ47Ir3Io9
         MpIEMVNKEbzABf/v37ujtFwnKfNeUmtkwsSSbLOxYB0VenvxQxG1QUsjFm1OAyKtRc
         kDcRV/teHo+ko2WppJLpTAI3mf/A0n2Galii5k0PpJPlW/edohrqfBMlpkGe2mTncX
         4bKr/BKYVSmuxyXDdi09nOxPJAbOAqyYaUy5xtNgD4Lx2s5wsf2d4wr1aNaRWv3E3V
         MWfgunC1gP0dA==
Date:   Tue, 17 Nov 2015 20:03:27 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
Message-ID: <20151117200327.GA6520@io.lakedaemon.net>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
 <1447788896-15553-5-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447788896-15553-5-git-send-email-albeu@free.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Hi Alban,

On Tue, Nov 17, 2015 at 08:34:54PM +0100, Alban Bedel wrote:
> The driver stays the same but the initialization changes a bit.
> For OF boards we now get the memory map from the OF node and use
> a linear mapping instead of the legacy mapping. For legacy boards
> we still use a legacy mapping and just pass down all the parameters
> from the board init code.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/ath79/irq.c                    | 163 +++------------------------
>  arch/mips/include/asm/mach-ath79/ath79.h |   3 +
>  drivers/irqchip/Makefile                 |   1 +
>  drivers/irqchip/irq-ath79-misc.c         | 182 +++++++++++++++++++++++++++++++
>  4 files changed, 201 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/irqchip/irq-ath79-misc.c
...
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 177f78f..a8f9075 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_IRQCHIP)			+= irqchip.o
>  
> +obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
>  obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o

CONFIG_ARCH_ATH79 ?

Same for the last patch in the series (cpu driver).

thx,

Jason.
