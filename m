Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 17:36:22 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36191 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993910AbdDTPgNx6JbQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 17:36:13 +0200
Received: by mail-oi0-f68.google.com with SMTP id a3so5510552oii.3;
        Thu, 20 Apr 2017 08:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/7+DOkKP420Y0yGZ5SybfZymYYa13azJCE0Wq8rp+K0=;
        b=bUjQkSHP2Om1Qi8nyC855RA+QBHdcQZyB7ySxckn+cPiPMCJZPh5Pn+nmsC7L+0X9X
         bm0oijl1Xjz+ACrWSrzEuhXW5ef5dFtg6LHf1rfhb4gntJaCBLVwkBJLeMpWVN77gIql
         sAjs2duf51hX/VUX4gfn2HxgoYZCc6Xz8rct/CnhWLmDQEQnwJ9wf044xp0uEGWI+jKd
         EGnTAtSf4CeFLIIQoN+95yFZSbQPj+tFbb3odcSIVxRsnPZKVcrTfR0pycjXdchHgvRD
         VvdJCvxZTv9fsR0M3q5g5Tx3+ZBscfJQPJeDg/6TjkMigzHqPP2yK7LhCOT2tdO1mC95
         P8mw==
X-Gm-Message-State: AN3rC/6I8OoxSwcM4dhPPXtqOIkWzsrUZb/Z2QpfLzzFPRK1B2qyLAD3
        IGdGp0Wr0vmpKw==
X-Received: by 10.202.59.2 with SMTP id i2mr4706850oia.11.1492702567586;
        Thu, 20 Apr 2017 08:36:07 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id m74sm2672096oik.33.2017.04.20.08.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Apr 2017 08:36:07 -0700 (PDT)
Date:   Thu, 20 Apr 2017 10:36:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 11/13] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
Message-ID: <20170420153606.fdhedc7ovvhc66qd@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-12-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-12-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57748
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

On Mon, Apr 17, 2017 at 09:29:40PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  59 ++++
>  arch/mips/lantiq/xway/reset.c                      |  43 ---
>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 325 +++++++++++++++++++++
>  6 files changed, 405 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> new file mode 100644
> index 000000000000..0ec9f790b6e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> @@ -0,0 +1,59 @@
> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> +===========================================
> +
> +This binding describes the USB PHY hardware provided by the RCU module on the
> +Lantiq XWAY SoCs.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible		: Should be one of
> +				"lantiq,ase-rcu-usb2-phy"
> +				"lantiq,danube-rcu-usb2-phy"
> +				"lantiq,xrx100-rcu-usb2-phy"
> +				"lantiq,xrx200-rcu-usb2-phy"
> +				"lantiq,xrx300-rcu-usb2-phy"

The first x in xrx seems to be a wildcard. Don't use wildcards in 
compatible strings.

> +- lantiq,rcu-syscon	: A phandle to the RCU module and the offsets to the
> +			  USB PHY configuration and USB MAC registers.

Same comment as gphy.

> +- address-cells		: should be 1
> +- size-cells		: should be 0
> +- phy-cells		: from the generic PHY bindings, must be 1

Missing the '#'

> +
> +Optional properties (controller (parent) node):
> +- vbus-gpio		: References a GPIO which enables VBUS all given USB
> +			  ports.

-gpios is preferred form.

> +
> +Required nodes		:  A sub-node is required for each USB PHY port.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (port (child) node):

Where's the sub nodes in the example?

> +- reg        	: The ID of the USB port, usually 0 or 1.
> +- clocks	: References to the (PMU) "ctrl" and "phy" clk gates.
> +- clock-names	: Must be one of the following:
> +			"ctrl"
> +			"phy"
> +- resets	: References to the RCU USB configuration reset bits.
> +- reset-names	: Must be one of the following:
> +			"analog-config" (optional)
> +			"statemachine-soft" (optional)
> +
> +Optional properties (port (child) node):
> +- vbus-gpio	: References a GPIO which enables VBUS for the USB port.
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the USB PHYs on an xRX200 SoC:
> +	usb_phys0: rcu-usb2-phy@0 {

usb-phy@...

> +		compatible      = "lantiq,xrx200-rcu-usb2-phy";

Extra spaces.

> +		reg = <0>;
> +
> +		lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
> +		clocks = <&pmu PMU_GATE_USB0_CTRL>,
> +			 <&pmu PMU_GATE_USB0_PHY>;
> +		clock-names = "ctrl", "phy";
> +		vbus-gpios = <&gpio 32 GPIO_ACTIVE_HIGH>;
> +		resets = <&rcu_reset1 4>, <&rcu_reset0 4>;
> +		reset-names = "phy", "ctrl";
> +		#phy-cells = <0>;
> +	};
