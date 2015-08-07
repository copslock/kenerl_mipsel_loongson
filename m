Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 23:34:38 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:33403 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012892AbbHGVe34C0V3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 23:34:29 +0200
Received: by labjt7 with SMTP id jt7so56921058lab.0;
        Fri, 07 Aug 2015 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VY70DvepuurHRa3Pal9poXEC3xy2jEVjSu+3vU2FQs0=;
        b=LJnqiSBadMtCk1MHhmsSVu14ZdlvaudoBA+hFDJgW63zSx+ar+5N/6HOAFPnBFsDTj
         KLJ8msMmJ85tpHZHYo6+VWJKJkSdPXU9NfEsOAY3CrRlx7qMTxK0NIFksk0QW+Sq8hn4
         DqgIHLE9zdw3Tp1+lbHkjlagmJmJI5eeXhZvvXnSFocSKgG3TwSDK1e//jwE1YMnAn6G
         FL/T6+uAxT41IF10wpH5Ze/gJ46bpVL1xXtXbS74U6YVmjSCjhKQf4OmU2d9fNyODx0P
         sMpg/J1s8okIA2/BQ3qUyvPwPAk383OphHNug3hYwHwYt8+Ve3NSmK0rgaBCjZOqrvCJ
         NNTg==
MIME-Version: 1.0
X-Received: by 10.152.9.37 with SMTP id w5mr6015751laa.43.1438983264471; Fri,
 07 Aug 2015 14:34:24 -0700 (PDT)
Received: by 10.152.133.168 with HTTP; Fri, 7 Aug 2015 14:34:24 -0700 (PDT)
In-Reply-To: <1438843590-24101-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
        <1438843590-24101-1-git-send-email-shawn.lin@rock-chips.com>
Date:   Fri, 7 Aug 2015 23:34:24 +0200
Message-ID: <CAGhQ9VxkFk19HGtToUm8bOU62Z8S0_dMqciUiNfJry-Jb5YF=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/9] arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
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
X-archive-position: 48728
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

On 6 August 2015 at 08:46, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Joachim Eastwood <manabian@gmail.com>

>  arch/arm/configs/lpc18xx_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
> index 1c47f86..b7e8cda 100644
> --- a/arch/arm/configs/lpc18xx_defconfig
> +++ b/arch/arm/configs/lpc18xx_defconfig
> @@ -119,7 +119,6 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_ROOT_HUB_TT=y
>  CONFIG_MMC=y
>  CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_IDMAC=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_PCA9532=y
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
