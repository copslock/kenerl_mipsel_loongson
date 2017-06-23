Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 00:15:45 +0200 (CEST)
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34343 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993867AbdFWWPixfOk- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 00:15:38 +0200
Received: by mail-pg0-f68.google.com with SMTP id j186so7649821pge.1;
        Fri, 23 Jun 2017 15:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1GhxickJCYct+JBl5M0a3mAGnEmGAeBmYEKcTAMgwjs=;
        b=B+nqnLcdkRVz/DFbHDR+MVthWoKgb0QCMztdNlsqS952XmxYSh14NlsQ1+AuIEFZXN
         E8OJ4AjdXI+HbNdJfTiG99db8S9BMN8CN1Kh25tWXMNI9u75ZXNhe77XTdzrGV4GSiOk
         VZLi5bZVCvJvma1DZm9IHrLO70rOE54Pi0+SJNMkwm8Kq3pfdtYNIcCLF8o7geh2DPmi
         5BpuGG3uB3mBISVUy0IZe0otP/nkd1FbToBwtpBS2bFiVbOi/N+7bxDYL9xV9tdIC4vN
         1zdIV6CLlNzi7njzSzU2u8Y3+upe+RzLABIhljSKd/0n0ENIHK7OZD0pgM7W6aK+Ivb1
         FBhw==
X-Gm-Message-State: AKS2vOwuiM94A3jpcrDMW/RKLJfJ2uV9LEuU3pmakCaLXTmeTaZqgMjP
        aJmQZShwkoHdNQ==
X-Received: by 10.84.231.15 with SMTP id f15mr11478895plk.131.1498256133044;
        Fri, 23 Jun 2017 15:15:33 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h123sm11039147pgc.36.2017.06.23.15.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Jun 2017 15:15:32 -0700 (PDT)
Date:   Fri, 23 Jun 2017 17:15:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v5 08/16] MIPS: lantiq: Convert the fpi bus driver to a
 platform_driver
Message-ID: <20170623221531.o5vvuoobwjvokjms@rob-hp-laptop>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-9-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620223743.13735-9-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58778
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

On Wed, Jun 21, 2017 at 12:37:35AM +0200, Hauke Mehrtens wrote:
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/fpi-bus.txt    | 31 ++++++++
>  MAINTAINERS                                        |  1 +
>  arch/mips/lantiq/xway/reset.c                      |  4 -
>  arch/mips/lantiq/xway/sysctrl.c                    | 41 -----------
>  drivers/soc/Makefile                               |  1 +
>  drivers/soc/lantiq/Makefile                        |  1 +
>  drivers/soc/lantiq/fpi-bus.c                       | 85 ++++++++++++++++++++++
>  7 files changed, 119 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/fpi-bus.c
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
> new file mode 100644
> index 000000000000..80555b76fd34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
> @@ -0,0 +1,31 @@
> +Lantiq XWAY SoC FPI BUS binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be one of
> +				"lantiq,xrx200-fpi"
> +- reg		: The address and length of the XBAR configuration register.
> +		  Address and length of the FPI bus itself
> +
> +Optional properties:
> +- regmap		: A phandle to the RCU syscon

"lantiq,rcu" instead.

> +- offset-endianness	: Offset of the endianness configuration register

lantiq,offset-endianness

> +
> +-------------------------------------------------------------------------------
> +Example for the FPI on the xrx200 SoCs:
> +	fpi@10000000 {
> +		compatible = "lantiq,xrx200-fpi", "simple-bus";

Drop simple-bus.

> +		ranges = <0x0 0x10000000 0xf000000>;
> +		reg =	<0x1f400000 0x1000>,
> +			<0x10000000 0xf000000>;
> +		regmap = <&rcu0>;
> +		offset-endianness = <0x4c>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		gptu@e100a00 {
> +			......
> +		};
> +	};
