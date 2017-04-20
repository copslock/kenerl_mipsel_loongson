Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 17:28:09 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35658 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991867AbdDTP2Bdst9Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 17:28:01 +0200
Received: by mail-oi0-f65.google.com with SMTP id m34so1684626oik.2;
        Thu, 20 Apr 2017 08:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gGv3sPDsS6YRhQsQlgnSsVA9rn+s6kZEBupKhPsi4ME=;
        b=uV99VdrnAC922rk/hIo440SdymTF38JoHFtb/4Hgu5hfibkwfsnVKdWPPQdq6ilD92
         iTiVtURF+nEzV9Sw1taKBX7pkuunaZN4K+eNufxWFZ0RVIveiI4uLz10k0//fJUWMeJQ
         qAyEpJhUfUKbh/dd7C3nhBrVMrwdrNtH76tRARyoB2vXWkp1UMUBorogszkKOtDvzWLR
         1hABCtX4SX8neP0atApa2n6hPCm9lOhwinItbiT1gRRZCgR17fWjcWdaAN3nJVqRiza1
         5NIt0AboM8yBVROVzOUNGnVZAPIaXkDC3QF9WOs4MG9jMU3dvK0z6AEtynmR7t07au6C
         DpWQ==
X-Gm-Message-State: AN3rC/6YyiYOvTLL0CCNEvetiyY2/pYCzfPlajrxQbKsjtFkFRedduOG
        8XMQSIaWyqm7/A==
X-Received: by 10.202.232.67 with SMTP id f64mr4741549oih.36.1492702075761;
        Thu, 20 Apr 2017 08:27:55 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id e31sm2648035ote.42.2017.04.20.08.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Apr 2017 08:27:55 -0700 (PDT)
Date:   Thu, 20 Apr 2017 10:27:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 09/13] MIPS: lantiq: Add a GPHY driver which uses the RCU
 syscon-mfd
Message-ID: <20170420152754.3tkjxjvoiuatbvpo@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-10-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-10-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57747
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

On Mon, Apr 17, 2017 at 09:29:38PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Compared to the old xrx200_phy_fw driver the new version has multiple
> enhancements. The name of the firmware files does not have to be added
> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
> instead. Each GPHY can now also boot separate firmware (thus mixing of
> GE and FE GPHYs is now possible).
> The new implementation is based on the RCU syscon-mfd and uses the
> reeset_controller framework instead of raw RCU register reads/writes.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  54 +++++
>  arch/mips/lantiq/xway/sysctrl.c                    |   4 +-
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/gphy.c                          | 242 +++++++++++++++++++++
>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
>  5 files changed, 314 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>  create mode 100644 drivers/soc/lantiq/gphy.c
>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
> new file mode 100644
> index 000000000000..d525c7ce9f0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
> @@ -0,0 +1,54 @@
> +Lantiq XWAY SoC GPHY binding
> +============================
> +
> +This binding describes a software-defined ethernet PHY, provided by the RCU
> +module on newer Lantiq XWAY SoCs (xRX200 and newer).
> +This depends on binary firmware blobs which must be provided by userspace.

Where the blobs come from is not relevant. 

> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible		: Should be one of
> +				"lantiq,xrx200a1x-rcu-gphy"
> +				"lantiq,xrx200a2x-rcu-gphy"
> +				"lantiq,xrx300-rcu-gphy"
> +				"lantiq,xrx330-rcu-gphy"
> +- lantiq,rcu-syscon	: A phandle and offset to the GPHY address registers in
> +			  the RCU
> +- resets		: Must reference the RCU GPHY reset bit
> +- reset-names		: One entry, value must be "gphy" or optional "gphy2"
> +
> +Optional properties (port (child) node):
> +- lantiq,gphy-mode	: GPHY_MODE_GE (default) or GPHY_MODE_FE as defined in
> +			  <dt-bindings/mips/lantiq_xway_gphy.h>
> +- clocks		: A reference to the (PMU) GPHY clock gate
> +- clock-names		: If clocks is given then this must be "gphy"

Kind of pointless to have a name for a single clock.

> +
> +
> +-------------------------------------------------------------------------------
> +Example for the GPHys on the xRX200 SoCs:
> +
> +#include <dt-bindings/mips/lantiq_rcu_gphy.h>
> +	gphy0: rcu_gphy@0 {

Use generic node names: phy@...

> +		compatible = "lantiq,xrx200a2x-rcu-gphy";
> +		reg = <0>;
> +
> +		lantiq,rcu-syscon = <&rcu0 0x20>;

Could the phy just be a child of the rcu? Then you don't need a phandle 
here and 0x20 becomes the reg address.

> +		resets = <&rcu_reset0 31>, <&rcu_reset1 7>;
> +		reset-names = "gphy", "gphy2";
> +		lantiq,gphy-mode = <GPHY_MODE_GE>;
> +		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +		clock-names = "gphy";
> +	};
> +
> +	gphy1: rcu_gphy@1 {
> +		compatible = "lantiq,xrx200a2x-rcu-gphy";
> +		reg = <0>;
> +
> +		lantiq,rcu-syscon = <&rcu0 0x68>;
> +		resets = <&rcu_reset0 29>, <&rcu_reset1 6>;
> +		reset-names = "gphy", "gphy2";
> +		lantiq,gphy-mode = <GPHY_MODE_FE>;
> +		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +		clock-names = "gphy";
> +	};
