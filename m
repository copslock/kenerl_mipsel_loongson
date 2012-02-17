Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 17:44:07 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:61233 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903691Ab2BQQoD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2012 17:44:03 +0100
Received: by bkcjk13 with SMTP id jk13so4342670bkc.36
        for <linux-mips@linux-mips.org>; Fri, 17 Feb 2012 08:43:58 -0800 (PST)
Received: by 10.204.152.208 with SMTP id h16mr4721323bkw.6.1329497037967;
        Fri, 17 Feb 2012 08:43:57 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id e17sm23641316bkz.13.2012.02.17.08.43.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 08:43:57 -0800 (PST)
Message-ID: <4F3E91B5.5080603@mvista.com>
Date:   Fri, 17 Feb 2012 20:43:17 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: lantiq: add vr9 support
References: <1329474832-21095-1-git-send-email-blogic@openwrt.org> <1329474832-21095-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1329474832-21095-2-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkLn8fiwiGcf5LrS3hSVNeXMxPRy8q1wS3vp11WeJL2haAfdDVNXkUBA77Fly9qoVXkl/ge
X-archive-position: 32460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 02/17/2012 01:33 PM, John Crispin wrote:

> VR9 is a VDSL SoC made by Lantiq. It is very similar to the AR9.
> This patch adds the clkdev init code and SoC detection for the VR9.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> ---
>   .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    1 +
>   arch/mips/lantiq/xway/prom.c                       |    5 +++++
>   arch/mips/lantiq/xway/sysctrl.c                    |   10 ++++++++++
>   3 files changed, 16 insertions(+), 0 deletions(-)

> diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> index 6dfb65e..8e0fa6c 100644
> --- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> +++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> @@ -21,6 +21,7 @@
>  #define SOC_ID_ARX188		0x16C
>  #define SOC_ID_ARX168		0x16D
>  #define SOC_ID_ARX182		0x16F
> +#define SOC_ID_VRX288           0x1C0

    Use tabs to indent the value as above.

> diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
> index 0929acb..53b627c 100644
> --- a/arch/mips/lantiq/xway/prom.c
> +++ b/arch/mips/lantiq/xway/prom.c
> @@ -60,6 +60,11 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
>   #endif
>   		break;
>
> +	case SOC_ID_VRX288:
> +		i->name = SOC_VR9;
> +		i->type = SOC_TYPE_VR9;
> +		break;
> +
>   	default:
>   		unreachable();
>   		break;
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 879c89a..18bff5a 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -152,6 +152,16 @@ void __init ltq_soc_init(void)
>   		clkdev_add_static("io", CLOCK_133M);
>   		clkdev_add_cgu("ephycgu", CGU_EPHY),
>   		clkdev_add_pmu("fpi", "ephy", 0, PMU_EPHY);
> +	} else if (ltq_is_vr9()) {

    Where is this defined?

> +		clkdev_add_static("cpu", ltq_vr9_cpu_hz());
> +		clkdev_add_static("fpi", ltq_vr9_fpi_hz());
> +		clkdev_add_static("io", ltq_vr9_io_region_clock());
> +		clkdev_add_pmu("pcie-phy", NULL, 1, PMU1_PCIE_PHY);
> +		clkdev_add_pmu("pcie-bus", NULL, 0, PMU_PCIE_CLK);
> +		clkdev_add_pmu("pcie-msi", NULL, 1, PMU1_PCIE_MSI);
> +		clkdev_add_pmu("pcie-pdi", NULL, 1, PMU1_PCIE_PDI);
> +		clkdev_add_pmu("pcie-ctl", NULL, 1, PMU1_PCIE_CTL);
> +		clkdev_add_pmu("ahb", NULL, 0, PMU_AHBM | PMU_AHBS);
>   	} else {
>   		clkdev_add_static("cpu", ltq_danube_cpu_hz());
>   		clkdev_add_static("fpi", ltq_danube_fpi_hz());

WBR, Sergei
