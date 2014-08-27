Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 20:22:39 +0200 (CEST)
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36191 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006918AbaH0SWirS76H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 20:22:38 +0200
Received: by mail-oi0-f50.google.com with SMTP id e131so98950oig.37
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=49x0aiYHmhErJDF8w0pyiZI+0ajxZh+2/t5EKviXu8M=;
        b=Jyt04fvcTaY2/nZl3UJMpSVUkkj59kUOpv8CPHt6Mhu/6JObzwyOrTNtaikAluxq28
         ZY9/kTijLuFHcwJViNR1RlT1L7/eC6ncxjOTdex+KT3iFzpDxuQuM5JFDwDywB7EI6Sj
         sErIHclEjVc6u6PUDso+PZw4VMdD6IY4GRxrfViF6jOR9s+R2m6Mm9au2USCtvCntphq
         gC88JryZTN6w8Ke/7/lvCuobikc4ToXCQRGAMraa3IrEpX81V4p4xxggBtQKFbA0jdws
         S0/oT7xGsW/Q0MimOoMkXPByoAWmFNz2bkozX+WPRZwv8pFbXXgXVeNfsSpTu9VLKMXx
         c0LA==
X-Received: by 10.60.65.35 with SMTP id u3mr36686825oes.35.1409163752816;
        Wed, 27 Aug 2014 11:22:32 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id eg11sm1271948obd.22.2014.08.27.11.22.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Aug 2014 11:22:32 -0700 (PDT)
Message-ID: <53FE21C9.7060909@gmail.com>
Date:   Wed, 27 Aug 2014 11:22:01 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org
CC:     zajec5@gmail.com
Subject: Re: [RFC 7/7] ARM: BCM5301X: register bcma bus
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de> <1408915485-8078-9-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1408915485-8078-9-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42283
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

On 08/24/2014 02:24 PM, Hauke Mehrtens wrote:
> ---
>  arch/arm/boot/dts/bcm4708.dtsi | 58 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)

We probably want a compatible string for each of these aix subnodes you
are adding, so we can match them.

> 
> diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
> index 31141e8..7c240ab 100644
> --- a/arch/arm/boot/dts/bcm4708.dtsi
> +++ b/arch/arm/boot/dts/bcm4708.dtsi
> @@ -31,4 +31,62 @@
>  		};
>  	};
>  
> +	nvram0: nvram@0 {
> +		compatible = "brcm,bcm47xx-nvram";
> +		reg = <0x1c000000 0x01000000>;
> +	};
> +
> +	sprom0: sprom@0 {
> +		compatible = "brcm,bcm47xx-sprom";
> +		nvram = <&nvram0>;
> +	};
> +
> +	aix@18000000 {
> +		compatible = "brcm,bus-aix";
> +		reg = <0x18000000 0x1000>;
> +		ranges = <0x00000000 0x18000000 0x00100000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		sprom = <&sprom0>;
> +
> +		usb2@0 {
> +			reg = <0x18021000 0x1000>;
> +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		usb3@0 {
> +			reg = <0x18023000 0x1000>;
> +			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		gmac@0 {
> +			reg = <0x18024000 0x1000>;
> +			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		gmac@1 {
> +			reg = <0x18025000 0x1000>;
> +			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		gmac@2 {
> +			reg = <0x18026000 0x1000>;
> +			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		gmac@3 {
> +			reg = <0x18027000 0x1000>;
> +			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pcie@0 {
> +			reg = <0x18012000 0x1000>;
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pcie@1 {
> +			reg = <0x18013000 0x1000>;
> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
>  };
> 
