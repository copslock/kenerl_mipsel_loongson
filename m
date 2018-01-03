Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 21:02:31 +0100 (CET)
Received: from mail-ot0-f196.google.com ([74.125.82.196]:47003 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbeACUCTBvRMa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2018 21:02:19 +0100
Received: by mail-ot0-f196.google.com with SMTP id v40so2191387ote.13;
        Wed, 03 Jan 2018 12:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rskena7Kp2NJZXN57vvhE6H4q7gpSoSoHF6ormVrjHM=;
        b=tLW9URl5FtH9xviNdNiUOG9z2FCz/QCnFrlfAjgS9qfR+QkLKCYZLaHVsBLYjYz08J
         qeW0TqMRNha7PXAVFoEEmfDFSYWeI/2VzlZ20FJt/ii73PfeLp8gxMurfXPJ6Nv6B4/Y
         9UiR556A+bzX7/3SEKde8hJWPJhHfQuXqDzURmxWcENX4DoWRKllw8BK5Gp+pPr5JmS9
         VrjuUUoMFd/F+7QYGjfftoinanOqcT8DkmUxvhOl81V4jEQC0FoEt3ER6ddUqEMwHWjc
         Ibeec/EvnLAgV07x7/1xptljUQGKRibviFp9Ax55CUz8mrg2FSWL4aZe4Kdfo2yqS6eA
         YYbg==
X-Gm-Message-State: AKGB3mICZjQmwLPW/nXxbSSc0OIfg6IZBDEw6fc4RsQV+BoUr6mdgoW/
        KAr6qO63xxVmouhQj1es+g==
X-Google-Smtp-Source: ACJfBot1FJHrp4eNThxKyaj4tOPjfaer9VtPAUAp0V667Q8gYKZTmv9CR893wDXk/GOE7Gr2oETBnw==
X-Received: by 10.157.34.227 with SMTP id y90mr1549185ota.302.1515009732649;
        Wed, 03 Jan 2018 12:02:12 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id y56sm754298oty.18.2018.01.03.12.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jan 2018 12:02:12 -0800 (PST)
Date:   Wed, 3 Jan 2018 14:02:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] nvmem: add driver for JZ4780 efuse
Message-ID: <20180103200211.u56tqesyumsofoff@rob-hp-laptop>
References: <20171228212954.2922-1-malat@debian.org>
 <20171228212954.2922-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171228212954.2922-2-malat@debian.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61891
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

On Thu, Dec 28, 2017 at 10:29:52PM +0100, Mathieu Malaterre wrote:
> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> 
> This patch brings support for the JZ4780 efuse. Currently it only expose
> a read only access to the entire 8K bits efuse memory.
> 
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  .../ABI/testing/sysfs-driver-jz4780-efuse          |  16 ++
>  .../bindings/nvmem/ingenic,jz4780-efuse.txt        |  17 ++

Please split bindings to separate patch.

>  MAINTAINERS                                        |   5 +
>  arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++-

dts files should also be separate.

>  drivers/nvmem/Kconfig                              |  10 +
>  drivers/nvmem/Makefile                             |   2 +
>  drivers/nvmem/jz4780-efuse.c                       | 305 +++++++++++++++++++++
>  7 files changed, 383 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
>  create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
>  create mode 100644 drivers/nvmem/jz4780-efuse.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-jz4780-efuse b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
> new file mode 100644
> index 000000000000..bb6f5d6ceea0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
> @@ -0,0 +1,16 @@
> +What:		/sys/devices/*/<our-device>/nvmem
> +Date:		December 2017
> +Contact:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> +Description:	read-only access to the efuse on the Ingenic JZ4780 SoC
> +		The SoC has a one time programmable 8K efuse that is
> +		split into segments. The driver supports read only.
> +		The segments are
> +		0x000   64 bit Random Number
> +		0x008  128 bit Ingenic Chip ID
> +		0x018  128 bit Customer ID
> +		0x028 3520 bit Reserved
> +		0x1E0    8 bit Protect Segment
> +		0x1E1 2296 bit HDMI Key
> +		0x300 2048 bit Security boot key

Why do these need to be exposed to userspace?

sysfs is 1 value per file and this is lots of different things. 

We already have ways to feed random data (entropy) to the system. And we 
have a way to expose SoC ID info to userspace (socdev).

> +Users:		any user space application which wants to read the Chip
> +		and Customer ID
> diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
> new file mode 100644
> index 000000000000..cd6d67ec22fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
> @@ -0,0 +1,17 @@
> +Ingenic JZ EFUSE driver bindings
> +
> +Required properties:
> +- "compatible"		Must be set to "ingenic,jz4780-efuse"
> +- "reg"			Register location and length
> +- "clocks"		Handle for the ahb clock for the efuse.
> +- "clock-names"		Must be "bus_clk"
> +
> +Example:
> +
> +efuse: efuse@134100d0 {
> +	compatible = "ingenic,jz4780-efuse";
> +	reg = <0x134100D0 0xFF>;
> +
> +	clocks = <&cgu JZ4780_CLK_AHB2>;
> +	clock-names = "bus_clk";
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6e86e20761e..7a050c20c533 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6902,6 +6902,11 @@ M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>  S:	Maintained
>  F:	drivers/dma/dma-jz4780.c
>  
> +INGENIC JZ4780 EFUSE Driver
> +M:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> +S:	Maintained
> +F:	drivers/nvmem/jz4780-efuse.c

Binding file?

> +
>  INGENIC JZ4780 NAND DRIVER
>  M:	Harvey Hunt <harveyhuntnexus@gmail.com>
>  L:	linux-mtd@lists.infradead.org
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index 9b5794667aee..3fb9d916a2ea 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -224,21 +224,37 @@
>  		reg = <0x10002000 0x100>;
>  	};
>  
> -	nemc: nemc@13410000 {
> -		compatible = "ingenic,jz4780-nemc";
> -		reg = <0x13410000 0x10000>;
> -		#address-cells = <2>;
> +
> +	ahb2: ahb2 {
> +		compatible = "simple-bus";

This is an unrelated change and should be its own patch.

> +		#address-cells = <1>;
>  		#size-cells = <1>;
> -		ranges = <1 0 0x1b000000 0x1000000
> -			  2 0 0x1a000000 0x1000000
> -			  3 0 0x19000000 0x1000000
> -			  4 0 0x18000000 0x1000000
> -			  5 0 0x17000000 0x1000000
> -			  6 0 0x16000000 0x1000000>;
> +		ranges = <>;
> +
> +		nemc: nemc@13410000 {
> +			compatible = "ingenic,jz4780-nemc";
> +			reg = <0x13410000 0x10000>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			ranges = <1 0 0x1b000000 0x1000000
> +				  2 0 0x1a000000 0x1000000
> +				  3 0 0x19000000 0x1000000
> +				  4 0 0x18000000 0x1000000
> +				  5 0 0x17000000 0x1000000
> +				  6 0 0x16000000 0x1000000>;
> +
> +			clocks = <&cgu JZ4780_CLK_NEMC>;
> +
> +			status = "disabled";
> +		};
>  
> -		clocks = <&cgu JZ4780_CLK_NEMC>;
> +		efuse: efuse@134100d0 {
> +			compatible = "ingenic,jz4780-efuse";
> +			reg = <0x134100d0 0xff>;

You are creating an overlapping region here with nemc above. Don't do 
that.

>  
> -		status = "disabled";
> +			clocks = <&cgu JZ4780_CLK_AHB2>;
> +			clock-names = "bus_clk";
> +		};
>  	};
>  
>  	bch: bch@134d0000 {
