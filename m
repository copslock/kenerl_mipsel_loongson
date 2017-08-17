Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 17:10:43 +0200 (CEST)
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38899 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994878AbdHQPKUQy9II (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 17:10:20 +0200
Received: by mail-pg0-f65.google.com with SMTP id 123so10307860pga.5;
        Thu, 17 Aug 2017 08:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bdXBvr5pYKsymi4IHLoCInbM4wx7HKNxFb+Vfl6ripA=;
        b=is9Gq4XvGWkiiEKCQH8bjUKVhbTmcN9yXYvTKrZtNZRv76I5ChMZsPOOqq2z+dOv+x
         EQXbSrA1gy9CKD6NG/VLgzvmNs11gtfaARgQ6DaWXF+IcFGAyrjOKiyM9dWU0yasfGcH
         aLgsG2y4BivtmnydBgt7C2VKxfLdK0rSQVTNDdUCTA96MC5w6A8TlHP3tI3HjQM6Q9dT
         6GI0AEp4FP4HXJKpbo2yKsf1OgLmq/QNm47v4bOgab4EvCJoUHiXGn34xr7DLS0dX1Jp
         YJmhDeUhWj/uvCpvIYtG8DEpuFmlHOknqCRKhZOJ/zH+WWhVySPt6Y9E+KMe5wWEOm1g
         et5w==
X-Gm-Message-State: AHYfb5iZ85wG4sjDs0ZDXQCpHOpCXWkMrx0wGNTZgd7sy7Sr/CITsAus
        0tOER4MEu3prLSdTtqA=
X-Received: by 10.99.101.132 with SMTP id z126mr5304422pgb.64.1502982614504;
        Thu, 17 Aug 2017 08:10:14 -0700 (PDT)
Received: from localhost (mobile-166-170-50-41.mycingular.net. [166.170.50.41])
        by smtp.gmail.com with ESMTPSA id r87sm7575791pfa.142.2017.08.17.08.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2017 08:10:14 -0700 (PDT)
Date:   Thu, 17 Aug 2017 10:10:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de, kishon@ti.com, mark.rutland@arm.com
Subject: Re: [PATCH v9 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Message-ID: <20170817151012.7hbnsgwv477mjnqx@rob-hp-laptop>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-11-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808225247.32266-11-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59624
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

On Wed, Aug 09, 2017 at 12:52:41AM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> The reset controllers (on xRX200 and newer SoCs have two of them) are
> provided by the RCU module. This was initially implemented as a simple
> reset controller. However, the RCU module provides more functionality
> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> The old reset controller driver implementation from
> arch/mips/lantiq/xway/reset.c did not honor this fact.
> 
> For some devices the request and the status bits are different.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../devicetree/bindings/reset/lantiq,reset.txt     |  30 +++
>  drivers/reset/Kconfig                              |   6 +
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-lantiq.c                       | 212 +++++++++++++++++++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
>  create mode 100644 drivers/reset/reset-lantiq.c
> 
> diff --git a/Documentation/devicetree/bindings/reset/lantiq,reset.txt b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> new file mode 100644
> index 000000000000..c1c48aa099b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> @@ -0,0 +1,30 @@
> +Lantiq XWAY SoC RCU reset controller binding
> +============================================
> +
> +This binding describes a reset-controller found on the RCU module on Lantiq
> +XWAY SoCs.
> +
> +This driver has to be a sub node of the Lantiq RCU block.

s/driver/node/

> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,danube-reset"
> +				"lantiq,xrx200-reset"
> +- reg			: Defines the following sets of registers in the parent
> +			  syscon device
> +			- Offset of the reset set register
> +			- Offset of the reset status register
> +- #reset-cells		: Specifies the number of cells needed to encode the
> +			  reset line, should be 2.
> +			  The first cell takes the reset set bit and the
> +			  second cell takes the status bit.
> +
> +-------------------------------------------------------------------------------
> +Example for the reset-controllers on the xRX200 SoCs:
> +	reset0: reset-controller@0 {

Should be: reset-controller@10

With those fixed,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "lantiq,xrx200-reset";
> +		reg <0x10 0x04>, <0x14 0x04>;
> +
> +		#reset-cells = <2>;
> +	};
