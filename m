Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 14:32:24 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:41878 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992479AbeGYMcUhtC38 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 14:32:20 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9E0DA20876; Wed, 25 Jul 2018 14:32:14 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 651FA2072F;
        Wed, 25 Jul 2018 14:32:04 +0200 (CEST)
Date:   Wed, 25 Jul 2018 14:32:04 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] MIPS: mscc: ocelot: fix length of memory address space
 for MIIM
Message-ID: <20180725123204.GD3539@piout.net>
References: <20180725122132.31187-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725122132.31187-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65138
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

On 25/07/2018 14:21:32+0200, Quentin Schulz wrote:
> The length of memory address space for MIIM0 is from 0x7107009c to
> 0x710700bf included which is 36 bytes long in decimal, or 0x24 bytes in
> hexadecimal and not 0x36.
> 
> Fixes: 49b031690abe ("MIPS: mscc: Add switch to ocelot")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index 4f33dbc67348..7096915f26e0 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -184,7 +184,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "mscc,ocelot-miim";
> -			reg = <0x107009c 0x36>, <0x10700f0 0x8>;
> +			reg = <0x107009c 0x24>, <0x10700f0 0x8>;
>  			interrupts = <14>;
>  			status = "disabled";
>  
> -- 
> 2.14.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
