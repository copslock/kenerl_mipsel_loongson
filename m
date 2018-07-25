Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 14:32:11 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:41869 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993003AbeGYMcGldXU8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 14:32:06 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 94CDF207AD; Wed, 25 Jul 2018 14:32:00 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5D3672072F;
        Wed, 25 Jul 2018 14:31:50 +0200 (CEST)
Date:   Wed, 25 Jul 2018 14:31:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] MIPS: mscc: ocelot: add MIIM1 bus
Message-ID: <20180725123150.GC3539@piout.net>
References: <20180725122241.31370-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725122241.31370-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 25/07/2018 14:22:41+0200, Quentin Schulz wrote:
> There is an additional MIIM (MDIO) bus in this SoC so let's declare it
> in the dtsi.
> 
> This bus requires GPIO 14 and 15 pins that need to be muxed. There is no
> support for internal PHY reset on this bus on the contrary of MIIM0 so
> there is only one register address space and not two.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index 7096915f26e0..d7f0e3551500 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -178,6 +178,11 @@
>  				pins = "GPIO_12", "GPIO_13";
>  				function = "uart2";
>  			};
> +
> +			miim1: miim1 {
> +				pins = "GPIO_14", "GPIO_15";
> +				function = "miim1";
> +			};
>  		};
>  
>  		mdio0: mdio@107009c {
> @@ -201,5 +206,16 @@
>  				reg = <3>;
>  			};
>  		};
> +
> +		mdio1: mdio@10700c0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "mscc,ocelot-miim";
> +			reg = <0x10700c0 0x24>;
> +			interrupts = <15>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&miim1>;
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.14.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
