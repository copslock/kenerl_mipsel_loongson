Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2015 03:58:16 +0200 (CEST)
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34308 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011052AbbJVB51cqaE5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2015 03:57:27 +0200
Received: by oies66 with SMTP id s66so39932188oie.1;
        Wed, 21 Oct 2015 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=WAJEFgQnIIyt7M9Ig8p66++885ok0+pd/EVYeVzqLsE=;
        b=OxthKYePWk7fd/MfyhtUihp2nkilMcNrV2iFwUH2/Y0VGOjlfBpnWxTDTOSdJjLb/j
         z2aFTeOe4kepsXQKPhyoYYKIcKsWEs1Gw+Vah7D0G0P5656s7wSDijkHc/SnO+o4tt49
         +7d6Kga3hy7nmYTkZfbPAMkMQ827PT850qhx/neMhzFwCbjc6Is/wfWbvq66IuKQhZxe
         Q/a8oh4+hQcUtJxxfliFKRT1oRREPb+9RLzMXQOXj30tbx1sgs1Lmu3slAucyKshp414
         QnDhA2cpi8/0++Emcpl6QlxwqApgJsVdK46lv7INkwT51ul2vfk2P+nZiHecnrrBqLZL
         30pA==
X-Received: by 10.202.190.87 with SMTP id o84mr8273717oif.111.1445479042000;
        Wed, 21 Oct 2015 18:57:22 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:44a6:f084:5dfa:7bd0? ([2001:470:d:73f:44a6:f084:5dfa:7bd0])
        by smtp.googlemail.com with ESMTPSA id u130sm4974793oie.2.2015.10.21.18.57.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 18:57:21 -0700 (PDT)
Subject: Re: [PATCH 8/9] MIPS: BMIPS: brcmstb: add I2C node for bcm7360
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-9-git-send-email-jaedon.shin@gmail.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56284280.9070906@gmail.com>
Date:   Wed, 21 Oct 2015 18:57:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445395021-4204-9-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49638
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

Le 20/10/2015 19:37, Jaedon Shin a écrit :
> Add I2C device nodes to BMIPS based BCM7360 platform.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/mips/boot/dts/brcm/bcm7360.dtsi     | 62 ++++++++++++++++++++++++++++++--
>  arch/mips/boot/dts/brcm/bcm97360svmb.dts | 16 +++++++++
>  2 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
> index 9e1e571ba346..7e5f76040fb8 100644
> --- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
> @@ -81,14 +81,32 @@
>  			compatible = "brcm,bcm7120-l2-intc";
>  			reg = <0x406600 0x8>;
>  
> -			brcm,int-map-mask = <0x44>;
> +			brcm,int-map-mask = <0x44>, <0x7000000>;
>  			brcm,int-fwd-mask = <0x70000>;
>  
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
>  
>  			interrupt-parent = <&periph_intc>;
> -			interrupts = <56>;
> +			interrupts = <56>, <54>;
> +			interrupt-names = "upg_main", "upg_bsc";
> +		};
> +
> +		upg_aon_irq0_intc: upg_aon_irq0_intc@408b80 {
> +			compatible = "brcm,bcm7120-l2-intc";
> +			reg = <0x408b80 0x8>;
> +
> +			brcm,int-map-mask = <0x40>, <0x8000000>, <0x100000>;
> +			brcm,int-fwd-mask = <0>;
> +			brcm,irq-can-wake;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			interrupt-parent = <&periph_intc>;
> +			interrupts = <57>, <55>, <59>;
> +			interrupt-names = "upg_main_aon", "upg_bsc_aon",
> +					  "upg_spi";
>  		};
>  
>  		sun_top_ctrl: syscon@404000 {
> @@ -138,6 +156,46 @@
>  			status = "disabled";
>  		};
>  
> +		bsca: i2c@406200 {
> +		      clock-frequency = <390000>;
> +		      compatible = "brcm,brcmstb-i2c";
> +		      interrupt-parent = <&upg_irq0_intc>;
> +		      reg = <0x406200 0x58>;
> +		      interrupts = <24>;
> +		      interrupt-names = "upg_bsca";
> +		      status = "disabled";
> +		};
> +
> +		bscb: i2c@406280 {
> +		      clock-frequency = <390000>;
> +		      compatible = "brcm,brcmstb-i2c";
> +		      interrupt-parent = <&upg_irq0_intc>;
> +		      reg = <0x406280 0x58>;
> +		      interrupts = <25>;
> +		      interrupt-names = "upg_bscb";
> +		      status = "disabled";
> +		};
> +
> +		bscc: i2c@406300 {
> +		      clock-frequency = <390000>;
> +		      compatible = "brcm,brcmstb-i2c";
> +		      interrupt-parent = <&upg_irq0_intc>;
> +		      reg = <0x406300 0x58>;
> +		      interrupts = <26>;
> +		      interrupt-names = "upg_bscc";
> +		      status = "disabled";
> +		};
> +
> +		bscd: i2c@408980 {
> +		      clock-frequency = <390000>;
> +		      compatible = "brcm,brcmstb-i2c";
> +		      interrupt-parent = <&upg_aon_irq0_intc>;
> +		      reg = <0x408980 0x58>;
> +		      interrupts = <27>;
> +		      interrupt-names = "upg_bscd";
> +		      status = "disabled";
> +		};
> +
>  		enet0: ethernet@430000 {
>  			phy-mode = "internal";
>  			phy-handle = <&phy1>;
> diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
> index eee8b0e32681..d48462e091f1 100644
> --- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
> +++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
> @@ -29,6 +29,22 @@
>  	status = "okay";
>  };
>  
> +&bsca {
> +	status = "okay";
> +};
> +
> +&bscb {
> +	status = "okay";
> +};
> +
> +&bscc {
> +	status = "okay";
> +};
> +
> +&bscd {
> +	status = "okay";
> +};
> +
>  &enet0 {
>  	status = "okay";
>  };
> 


-- 
Florian
