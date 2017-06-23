Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 00:17:53 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33313 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992936AbdFWWRmyFf5- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 00:17:42 +0200
Received: by mail-pf0-f196.google.com with SMTP id w12so9200428pfk.0;
        Fri, 23 Jun 2017 15:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7A4SeizBqLd1+CFS1KbyfsemIMxYZQ+j5I3ivR73FlU=;
        b=RA7Nhe9HfHJCKoccDE61gYBC0WEor/CnfRNTSrNQcJn5eoIw1X0wiMsbj+eaUtcDvj
         An8SxFNsN+gtkiRfjnIzRKWlXsabOANwu5dtXergxbAgBGHMf9bh4bz2CZstW95ux1Mk
         S5euA6DlkGz1FW2idajMAmmrgZiMVvKhdcfftD7U2YdsAb4pN+U8Gmt0sEQrJhZHSdce
         bv66EXOSAztmR+BlKvA4kz35zZcTUsSAm0yrMYaKuE6hDsq5N63MVc6BOo5UbSoQo1GD
         1zQOI1lOAjzSsbUbyoyOdiXMGkhhjfabxYiYxVcV4brGkXQU0gJgv++GEY6SGbteUhPw
         O3WA==
X-Gm-Message-State: AKS2vOwPFF5jDvKSsDgf18+3gIRwlNCjvwERJCd04HIt7oPP1UZWXbG5
        X6YzQvVW2XBSEw==
X-Received: by 10.101.86.12 with SMTP id l12mr10063098pgs.114.1498256257034;
        Fri, 23 Jun 2017 15:17:37 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id m134sm10703498pga.15.2017.06.23.15.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Jun 2017 15:17:36 -0700 (PDT)
Date:   Fri, 23 Jun 2017 17:17:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v5 12/16] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
Message-ID: <20170623221735.yxeqnn4javhboegx@rob-hp-laptop>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-13-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620223743.13735-13-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58779
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

On Wed, Jun 21, 2017 at 12:37:39AM +0200, Hauke Mehrtens wrote:
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
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  36 +++
>  arch/mips/lantiq/xway/sysctrl.c                    |   6 +-
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/gphy.c                          | 260 +++++++++++++++++++++
>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
>  5 files changed, 316 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>  create mode 100644 drivers/soc/lantiq/gphy.c
>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
> new file mode 100644
> index 000000000000..ec09783da9b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
> @@ -0,0 +1,36 @@
> +Lantiq XWAY SoC GPHY binding
> +============================
> +
> +This binding describes a software-defined ethernet PHY, provided by the RCU
> +module on newer Lantiq XWAY SoCs (xRX200 and newer).
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,xrx200a1x-gphy"
> +				"lantiq,xrx200a2x-gphy"
> +				"lantiq,xrx300-gphy"
> +				"lantiq,xrx330-gphy"
> +- reg			: Addrress of the GPHY FW load address register
> +- resets		: Must reference the RCU GPHY reset bit
> +- reset-names		: One entry, value must be "gphy" or optional "gphy2"
> +- clocks		: A reference to the (PMU) GPHY clock gate
> +
> +Optional properties:
> +- lantiq,gphy-mode	: GPHY_MODE_GE (default) or GPHY_MODE_FE as defined in
> +			  <dt-bindings/mips/lantiq_xway_gphy.h>
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the GPHys on the xRX200 SoCs:
> +
> +#include <dt-bindings/mips/lantiq_rcu_gphy.h>
> +	gphy0: gphy@0 {

phy@20

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "lantiq,xrx200a2x-gphy";
> +		reg = <0x20 0x4>
> +
> +		resets = <&reset0 31 30>, <&reset1 7 7>;
> +		reset-names = "gphy", "gphy2";
> +		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +		lantiq,gphy-mode = <GPHY_MODE_GE>
> +	};
