Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 10:51:59 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39510 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834885Ab3DLIs3YbUTD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 10:48:29 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QM9tRGpGEMRj; Fri, 12 Apr 2013 10:46:44 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 108CD2802BD;
        Fri, 12 Apr 2013 10:46:44 +0200 (CEST)
Message-ID: <5167CA3E.2080806@openwrt.org>
Date:   Fri, 12 Apr 2013 10:47:58 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 05/16] MIPS: ralink: add RT3352 usb register defines
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-5-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365751663-5725-5-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.04.12. 9:27 keltezéssel, John Crispin írta:
> Add a few missing defines that are needed to make USB work on the RT3352
> and RT5350.

This is not fully correct. This change contains definitions which are not
related to USB at all and those are used by a previous patch. You said that you
will reorder the patches, but please change the log as well when you are doing that.

-Gabor

> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/include/asm/mach-ralink/rt305x.h |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
> index 4e62cef..80cda8a 100644
> --- a/arch/mips/include/asm/mach-ralink/rt305x.h
> +++ b/arch/mips/include/asm/mach-ralink/rt305x.h
> @@ -144,4 +144,17 @@ static inline int soc_is_rt5350(void)
>  #define RT305X_GPIO_MODE_SDRAM		BIT(8)
>  #define RT305X_GPIO_MODE_RGMII		BIT(9)
>  
> +#define RT3352_SYSC_REG_SYSCFG0		0x010
> +#define RT3352_SYSC_REG_SYSCFG1         0x014
> +#define RT3352_SYSC_REG_CLKCFG1         0x030
> +#define RT3352_SYSC_REG_RSTCTRL         0x034
> +#define RT3352_SYSC_REG_USB_PS          0x05c
> +
> +#define RT3352_CLKCFG0_XTAL_SEL		BIT(20)
> +#define RT3352_CLKCFG1_UPHY0_CLK_EN	BIT(18)
> +#define RT3352_CLKCFG1_UPHY1_CLK_EN	BIT(20)
> +#define RT3352_RSTCTRL_UHST		BIT(22)
> +#define RT3352_RSTCTRL_UDEV		BIT(25)
> +#define RT3352_SYSCFG1_USB0_HOST_MODE	BIT(10)
> +
>  #endif
> 
