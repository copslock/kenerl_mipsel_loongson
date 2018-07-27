Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 12:36:42 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:41132 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990757AbeG0KghkktVn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 12:36:37 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4272A20876; Fri, 27 Jul 2018 12:36:31 +0200 (CEST)
Received: from localhost (unknown [88.128.81.178])
        by mail.bootlin.com (Postfix) with ESMTPSA id 04AF820618;
        Fri, 27 Jul 2018 12:36:20 +0200 (CEST)
Date:   Fri, 27 Jul 2018 12:36:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 1/2] MIPS: mscc: ocelot: add interrupt controller
 properties to GPIO controller
Message-ID: <20180727103621.GA7701@piout.net>
References: <20180725122621.31713-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725122621.31713-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65195
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

On 25/07/2018 14:26:20+0200, Quentin Schulz wrote:
> The GPIO controller also serves as an interrupt controller for events
> on the GPIO it handles.
> 
> An interrupt occurs whenever a GPIO line has changed.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index d7f0e3551500..afe8fc9011ea 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -168,6 +168,9 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			gpio-ranges = <&gpio 0 0 22>;
> +			interrupt-controller;
> +			interrupts = <13>;
> +			#interrupt-cells = <2>;
>  
>  			uart_pins: uart-pins {
>  				pins = "GPIO_6", "GPIO_7";
> -- 
> 2.14.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
