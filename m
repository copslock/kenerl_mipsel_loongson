Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 17:21:18 +0200 (CEST)
Received: from mail-io0-f193.google.com ([209.85.223.193]:45144 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbeGYPVMhDYB- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 17:21:12 +0200
Received: by mail-io0-f193.google.com with SMTP id k16-v6so6633079iom.12;
        Wed, 25 Jul 2018 08:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r6UvukqqFtJLNs66fvUoQBrNE8/ZKaQPS8O1sXHFxUQ=;
        b=o3vakQbqb+ZeHql4m5H93C08Vskl0Lh42IHq9nNSOPweGzS7KYS/CtskCzB1x6Sh9e
         EWbQh9rdrdTzHHQqYrDpjW1K61J3wsa+C+V5eIU+ENyXtERe9nM8Rczmht6iudOVn9l+
         mY6fIX5T/hNqWrWnnluKErYToFl8vrOuZ2qAXJyTyL+DclgatC81/jdAXiVNSCDhg5OE
         TCbGiMuUQIHOoUymc4zP4MS/Xv2ouA22gERG5WF3NgYhmTHVhBskZ9M/41Ukjvw4Jv3A
         n9SaMdVHioacv4SJyfvGySW/+pBIDsUUxUSPRcTnzDWpCv8uFawYunAGcKvoP6LpHupD
         Du/w==
X-Gm-Message-State: AOUpUlGNmtGWKPAYT/jSPuDAMOobK6uRTCE47xx/PO3OyIQFBaDDf2C5
        kezT/UmCTBRBGAYyLUkT3A==
X-Google-Smtp-Source: AAOMgpdsh2TKt23eAcb8Ab1F78JyV15HnwwjLCDco/OFH2MJ/XmPe9K+VTttc0/C6qKt3Xg8/VTI0g==
X-Received: by 2002:a6b:e816:: with SMTP id f22-v6mr15970608ioh.4.1532532066299;
        Wed, 25 Jul 2018 08:21:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id c3-v6sm3674473itd.8.2018.07.25.08.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 08:21:05 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:21:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
Message-ID: <20180725152105.GA6347@rob-hp-laptop>
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724231958.20659-5-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Jul 25, 2018 at 01:19:41AM +0200, Paul Cercueil wrote:
> Add documentation about how to properly use the Ingenic TCU
> (Timer/Counter Unit) drivers from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  24 +---
>  .../devicetree/bindings/timer/ingenic,tcu.txt      | 147 +++++++++++++++++++++
>  .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 +--
>  3 files changed, 151 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> 
>  v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
>      added content.
> 
>  v5: - Edited PWM/watchdog DT bindings documentation to point to the new
>        document.
>      - Moved main document to
>        Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>      - Updated documentation to reflect the new devicetree bindings.
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> index 7d9d3f90641b..a722cdde3aa7 100644
> --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> @@ -1,25 +1,5 @@
>  Ingenic JZ47xx PWM Controller
>  =============================
>  
> -Required properties:
> -- compatible: One of:
> -  * "ingenic,jz4740-pwm"
> -  * "ingenic,jz4770-pwm"
> -  * "ingenic,jz4780-pwm"
> -- #pwm-cells: Should be 3. See pwm.txt in this directory for a description
> -  of the cells format.
> -- clocks : phandle to the external clock.
> -- clock-names : Should be "ext".
> -
> -
> -Example:
> -
> -	pwm: pwm@10002000 {
> -		compatible = "ingenic,jz4740-pwm";
> -		reg = <0x10002000 0x1000>;
> -
> -		#pwm-cells = <3>;
> -
> -		clocks = <&ext>;
> -		clock-names = "ext";
> -	};
> +This documentation has moved; for a description of the devicetree bindings of
> +this driver, please refer to ../timer/ingenic,tcu.txt.

This should be evident from the git log. Just remove it.

> diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> new file mode 100644
> index 000000000000..65d125b460aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> @@ -0,0 +1,147 @@
> +Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
> +==========================================================
> +
> +For a description of the TCU hardware and drivers, have a look at
> +Documentation/mips/ingenic-tcu.txt.
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +  * ingenic,jz4740-tcu
> +  * ingenic,jz4725b-tcu
> +  * ingenic,jz4770-tcu
> +- reg: Should be the offset/length value corresponding to the TCU registers

> +- #address-cells: Should be <1>;
> +- #size-cells: Should be <1>;
> +- ranges: Should be one range for the full TCU registers area

These can all be implied.

> +- clocks: List of phandle & clock specifiers for clocks external to the TCU.
> +  The "pclk", "rtc", "ext" and "tcu" clocks should be provided.
> +- clock-names: List of name strings for the external clocks.
> +- #clock-cells: Should be <1>;
> +  Clock consumers specify this argument to identify a clock. The valid values
> +  may be found in <dt-bindings/clock/ingenic,tcu.h>.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value should be 1.
> +- interrupt-parent : phandle of the interrupt controller.
> +- interrupts : Specifies the interrupt the controller is connected to.

How many and what are they. The example shows there are 3.
> +
> +Optional properties:
> +
> +- ingenic,timer-channel: Specifies the TCU channel that should be used as
> +  system timer. If not provided, the TCU channel 0 is used for the system timer.
> +
> +- ingenic,clocksource-channel: Specifies the TCU channel that should be used
> +  as clocksource and sched_clock. It must be a different channel than the one
> +  used as system timer. If not provided, neither a clocksource nor a
> +  sched_clock is instantiated.

clocksource and sched_clock are Linux specific and don't belong in DT. 
You should define properties of the hardware or use existing properties 
like interrupts or clocks to figure out which channel to use. For 
example, if some channels don't have an interrupt, then use them for 
clocksource and not a clockevent. Or you could have timers that run in 
low-power modes or not. If all the channels are identical, then it 
shouldn't matter which ones the OS picks.

> +
> +
> +Children nodes
> +==========================================================
> +
> +
> +PWM node:
> +---------
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +  * ingenic,jz4740-pwm
> +  * ingenic,jz4725b-pwm
> +- #pwm-cells: Should be 3. See ../pwm/pwm.txt for a description of the cell
> +  format.
> +- clocks: List of phandle & clock specifiers for the TCU clocks.
> +- clock-names: List of name strings for the TCU clocks.
> +
> +
> +Watchdog node:
> +--------------
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +  * ingenic,jz4740-watchdog
> +  * ingenic,jz4780-watchdog
> +- clocks: phandle to the RTC clock
> +- clock-names: should be "rtc"
> +
> +
> +OST node:
> +---------
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +  * ingenic,jz4725b-ost
> +  * ingenic,jz4770-ost
> +- clocks: phandle to the OST clock
> +- clock-names: should be "ost"
> +- interrupts : Specifies the interrupt the OST is connected to.
> +
> +
> +Example
> +==========================================================
> +
> +#include <dt-bindings/clock/jz4770-cgu.h>
> +#include <dt-bindings/clock/ingenic,tcu.h>
> +
> +/ {
> +	tcu: timer@10002000 {
> +		compatible = "ingenic,jz4770-tcu";
> +		reg = <0x10002000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x10002000 0x1000>;
> +
> +		#clock-cells = <1>;
> +
> +		clocks = <&cgu JZ4770_CLK_RTC
> +			  &cgu JZ4770_CLK_EXT
> +			  &cgu JZ4770_CLK_PCLK
> +			  &cgu JZ4770_CLK_EXT>;
> +		clock-names = "rtc", "ext", "pclk", "tcu";
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <27 26 25>;
> +
> +		watchdog: watchdog@0 {
> +			compatible = "ingenic,jz4740-watchdog";
> +			reg = <0x0 0x10>;
> +
> +			clocks = <&tcu TCU_CLK_WDT>;
> +			clock-names = "wdt";
> +		};
> +
> +		pwm: pwm@10 {
> +			compatible = "ingenic,jz4740-pwm";
> +			reg = <0x10 0xff0>;
> +
> +			#pwm-cells = <3>;
> +
> +			clocks = <&tcu TCU_CLK_TIMER0
> +				  &tcu TCU_CLK_TIMER1
> +				  &tcu TCU_CLK_TIMER2
> +				  &tcu TCU_CLK_TIMER3
> +				  &tcu TCU_CLK_TIMER4
> +				  &tcu TCU_CLK_TIMER5
> +				  &tcu TCU_CLK_TIMER6
> +				  &tcu TCU_CLK_TIMER7>;
> +			clock-names = "timer0", "timer1", "timer2", "timer3",
> +				      "timer4", "timer5", "timer6", "timer7";
> +		};
> +
> +		ost: timer@e0 {
> +			compatible = "ingenic,jz4770-ost";
> +			reg = <0xe0 0x20>;

This is creating an overlapping region with PWM which should be avoided. 
Are timers and PWM the same h/w? Then there should be one node (or maybe 
you can do 1 node per channel if each channel is independent (has its 
own register range, clocks, interrupts, etc.

Or the PWM node needs to exclude this region (by having 2 reg regions).

> +
> +			clocks = <&tcu TCU_CLK_OST>;
> +			clock-names = "ost";
> +
> +			interrupts = <15>;
> +		};
> +	};
> +};
