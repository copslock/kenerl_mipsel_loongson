Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2017 02:55:24 +0200 (CEST)
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34188 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993887AbdC2AzQKTSJw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Mar 2017 02:55:16 +0200
Received: by mail-ot0-f194.google.com with SMTP id y88so126999ota.1;
        Tue, 28 Mar 2017 17:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NKCB99U4dLL1u3oUms/SnQOc2KLCpfFUHwXxYryOECI=;
        b=r/8nBxQvYK7jstv13tO1Fvae4Xautb+s7LUoO6RkxDu40GIK07Fjy4XIao8NzkMNtS
         F7gwOklyXnbxfLgNDZMyBZ2sux75p43h1Mh8byUsaQovTv05aIxxxm5bkeUK3G3+AI3n
         +V3nuFKxFJVuD2bS/0ZeLL455uAdS0BWWXgOy4UDA7YoyuhCprUBGfS6XvSx37wj9V/t
         CjsZWDLUIVB3mwDOMmuu8RAY95CPVfVa6Szr2WekzLpLgIK9gYb2hjpe46kfGboknGzA
         tYxjQCaSWABS3yq3LEqKJB4OsH3sXpIhO6FOfR/W9UDKd4dBGDgq2fFlZmPgB3XDblA+
         4+PQ==
X-Gm-Message-State: AFeK/H0s8sRbzGrdK09DzQXLL1EjdkqagkPdthXE3OGWZrIuzZ9TBnr6HQ8+gQ51U0jXtA==
X-Received: by 10.157.35.21 with SMTP id j21mr12939635otb.144.1490748910181;
        Tue, 28 Mar 2017 17:55:10 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id k63sm2552662oia.35.2017.03.28.17.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Mar 2017 17:55:09 -0700 (PDT)
Date:   Tue, 28 Mar 2017 19:55:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amit Kama IL <Amit.Kama@satixfy.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Add initial SX3000b platform related documentation to
 document tree
Message-ID: <20170329005509.z7pa6rp5kt5xftg4@rob-hp-laptop>
References: <AM4PR0201MB21799759E18C64A7032A2C3EE43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0201MB21799759E18C64A7032A2C3EE43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57458
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

On Wed, Mar 22, 2017 at 05:59:49AM +0000, Amit Kama IL wrote:
> Add initial SX3000b platform related documentation to document tree:
>  - Vendor prefix
>  - Platform binding documentation
>  - Interrupt Controller Unit binding documentation.

Probably should be 3 patches. Preferred subject prefix is "dt-bindings: 
..."

> 
> Signed-off-by: Amit Kama <amit.kama@staixfy.com>
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/satixfy-icu.txt b/Documentation/devicetree/bindings/interrupt-controller/satixfy-icu.txt
> index 0000000..1893393
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/satixfy-icu.txt
> @@ -0,0 +1,47 @@
> +Satixfy SX3000B Interrupt Controller Unit (ICU)
> +
> +The ICU routes HW interrupts from the inter-module fabric to the
> +processor. For the MIPS interaptive, all interrupts are then routed

interaptive or interaptiv? I see both in the doc.


> +to the GIC.
> +
> +Required properties:
> +- compatible : Should be "satixfy,icu".

icu is fairly generic sounding. Should be satixfy,sx3000b-icu.

> +- reg - must be present and equal <0x1D4D0000 0x1C0>
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt specifier.  Should be 1 - the GIC interrupt number
> +- interrupt-parent - Currently only the MIPS GIC is supported, so
> +<&gic> must be specified as parent
> +- interrupts : in interrupt parent form. For GIC it's
> +<GIC_SHARED x IRQ_TYPE_EDGE_RISING> where x is the interrupt number
> +allocated for ICU in GIC.
> +
> +
> +
> +
> +
> +Example:
> +
> +	icu: interrupt-controller@1d4d0000 {
> +		compatible = "sx,icu";
> +		reg = <0x1D4D0000 0x1C0>;

lowercase

> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SHARED 25 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
> +	uart0: uart@1D4D09C0 {

serial@1d4d09c0

> +		compatible = "ns16550a";
> +		reg = <0x1D4D09C0 0x100>;

lowercase

> +
> +		interrupt-parent = <&icu>;
> +		interrupts = <3>;
> +
> +		clock-frequency = <270000000>;
> +
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +	};
> diff --git a/Documentation/devicetree/bindings/mips/satixfy/sx3000b.txt b/Documentation/devicetree/bindings/mips/satixfy/sx3000b.txt
> index 0000000..7cae67b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/satixfy/sx3000b.txt
> @@ -0,0 +1,37 @@
> +Satixfy SX3000b SoC
> +=========================
> +
> +Required properties:
> +--------------------
> + - compatible: Must include "satixfy,sx3000".

The "b" in SX3000b is not significant?

> +
> +CPU nodes:
> +----------
> +A "cpus" node is required.  Required properties:
> + - #address-cells: Must be 1.
> + - #size-cells: Must be 0.
> +A CPU sub-node is also required for at least CPU 0.  Since the topology may
> +be probed via CPS, it is not necessary to specify secondary CPUs.  Required
> +properties:
> + - device_type: Must be "cpu".
> + - compatible: Must be "mti,interaptiv".
> + - reg: CPU number.
> + - clocks: Must include the CPU clock.  See ../../clock/clock-bindings.txt for
> +   details on clock bindings.
> +Example:
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "mti,interaptiv";
> +			clocks	= <&ext>;
> +			reg = <0>;
> +		};
> +	};
> +
> +Interrupt controllers:
> +----------------------
> +Two nodes are required:
> + - mips,gic - MIPS Global Interrupt Controller - see Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
> + - satixfy,icu - SX3000b SoC Interrupt Controller Unit - see Documentation/devicetree/bindings/interrupt-controller/satixfy-icu.txt
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ec0bfb9..76819dd
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -261,6 +261,7 @@ rockchip	Fuzhou Rockchip Electronics Co., Ltd
>  samsung	Samsung Semiconductor
>  samtec	Samtec/Softing company
>  sandisk	Sandisk Corporation
> +satixfy Satixfy Technologies Ltd
>  sbs	Smart Battery System
>  schindler	Schindler
>  seagate	Seagate Technology PLC
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
