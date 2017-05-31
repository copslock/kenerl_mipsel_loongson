Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 22:54:52 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32853 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbdEaUypxRqnO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 22:54:45 +0200
Received: by mail-oi0-f67.google.com with SMTP id h4so3790260oib.0;
        Wed, 31 May 2017 13:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HpWh8FwpRUf5peOaXMHkKYOaCR+Jh04Qv8USZTp1D9Q=;
        b=jRMILaJamcgl1w3z60I7LkhQCrZHvu/HnVYqrJV3jcYXY0VahrE7YynM7Y6VFWrmKO
         1xipQf5nUNdoo0kG2jAF2uKO9Lo5xSyKAe/MJYHiAkQXptDjuB4uAMoFFasvuk4x7wg6
         1WKzZYWnTKiyTKGNfn0SPkQMEWfeMfK5HwjUqrnwdfcq0B0inyunVlaOMB2Ly9927sd5
         8lOcQbsUVkWgq7wMx1MT8ub83oik0S6XSSNVEm6niFMlZUFa2r0U4+nKioXcJS2/020O
         Wzpklewi0q0AGeSCnKq+PeXEOi9QiObhvaxP5y6f0EFYP6MQ/ZHnssoptHVoMbv+A91X
         l4nw==
X-Gm-Message-State: AODbwcD5uILu/j2ZBcpq2c+fKpPIz5/f3dwZxpigrtkS0Cqjat6Ha02j
        9cUC6gr7pqHYrg==
X-Received: by 10.202.205.196 with SMTP id d187mr13206171oig.6.1496264080117;
        Wed, 31 May 2017 13:54:40 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id f68sm1887624otb.32.2017.05.31.13.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 May 2017 13:54:39 -0700 (PDT)
Date:   Wed, 31 May 2017 15:54:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v3 08/16] MIPS: lantiq: Convert the fpi bus driver to a
 platform_driver
Message-ID: <20170531205439.l5fiatf4v3kp43yq@rob-hp-laptop>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-9-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170528184006.31668-9-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58109
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

On Sun, May 28, 2017 at 08:39:58PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/fpi-bus.txt    | 33 ++++++++
>  MAINTAINERS                                        |  1 +
>  arch/mips/lantiq/xway/reset.c                      |  4 -
>  arch/mips/lantiq/xway/sysctrl.c                    | 41 ----------
>  drivers/soc/Makefile                               |  1 +
>  drivers/soc/lantiq/Makefile                        |  1 +
>  drivers/soc/lantiq/fpi-bus.c                       | 91 ++++++++++++++++++++++
>  7 files changed, 127 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/fpi-bus.c
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
> new file mode 100644
> index 000000000000..52d4bb9d2ffa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
> @@ -0,0 +1,33 @@
> +Lantiq XWAY SoC FPI BUS binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be one of
> +				"lantiq,fpi-xrx200"
> +- reg		: The address and length of the XBAR configuration register.
> +		  Address and length of the FPI bus itself
> +
> +Optional properties:
> +- regmap		: A phandle to the RCU syscon
> +- offset-endianness	: Offset of the endianness configuration register
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the FPI on the xrx200 SoCs:
> +	fpi@10000000 {
> +		compatible = "lantiq,fpi-xrx200", "simple-bus";
> +		ranges = <0x0 0x10000000 0xF000000>;

lowercase hex please.

> +		reg =	<0x1F400000 0x1000>,
> +			<0x10000000 0xF000000>;
> +		regmap = <&rcu0>;
> +		offset-endianness = <0x4c>;

Presumably, this is for endianness of the children. So this needs to be 
configured before probing the children. If so, then you should not call 
this a "simple-bus".

> +		big-endian;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		gptu@E100A00 {

lowercase hex.

> +			......
> +		};
> +	};
