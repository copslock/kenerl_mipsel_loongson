Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2017 23:30:01 +0100 (CET)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33198 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991087AbdCWW3ww6G0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Mar 2017 23:29:52 +0100
Received: by mail-oi0-f66.google.com with SMTP id f193so2291876oib.0;
        Thu, 23 Mar 2017 15:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gcm5a9k6amh5UMFXyxzQAGYPxV6Ec1pSe4L7DEz4STQ=;
        b=hj7/eylIqu/UfFtWm6z8ny1TAgRP38umeKKIf8Zz+KQ8+HjDyzOXCQ8azHJ+F6TfEa
         zj4aKPSZashfXlv/l+urnBUos+wJK0i4D2LlaAaBp8bCWbBVo7TQs4iHxgFzMuvrKwC5
         Svew9f5R3wpm5NUfZJcvSUuh+7MkPPCOVX1YtkEc6CgOXmddRLX3c8ujHk9m2EIMntOO
         NGCZ09tSy3yD0bsZGxEAvaFWIdjnhw9PLnwTBLeTcxOokmUtrDu1IAX1eV28bADae9Oo
         XlMEDXa4IeQMlgO7O/fQRNNHBMxOm1fuceXYBEg82ILPACvwo15FvnqSz/Qc2DLJtExj
         6RoQ==
X-Gm-Message-State: AFeK/H2r1PIJ+95+DaR0N7E6Mie7g4LVJXYs+8u92iPkpZG+t1qkZJtbeeCPMDH3jzUqQg==
X-Received: by 10.202.218.11 with SMTP id r11mr408848oig.129.1490308186907;
        Thu, 23 Mar 2017 15:29:46 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id s8sm199524ots.47.2017.03.23.15.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Mar 2017 15:29:46 -0700 (PDT)
Date:   Thu, 23 Mar 2017 17:29:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     linus.walleij@linaro.org, gnurou@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: NI 169445 board support
Message-ID: <20170323222945.bxz4qa6ydicrh4q6@rob-hp-laptop>
References: <1489508003-25288-1-git-send-email-nathan.sullivan@ni.com>
 <1489508003-25288-3-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489508003-25288-3-git-send-email-nathan.sullivan@ni.com>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57431
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

On Tue, Mar 14, 2017 at 11:13:23AM -0500, Nathan Sullivan wrote:
> Support the National Instruments 169445 board.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
>  Documentation/devicetree/bindings/mips/ni.txt   |   7 ++
>  MAINTAINERS                                     |   8 ++
>  arch/mips/boot/dts/Makefile                     |   1 +
>  arch/mips/boot/dts/ni/169445.dts                | 100 ++++++++++++++++++++++++
>  arch/mips/boot/dts/ni/Makefile                  |   7 ++
>  arch/mips/configs/generic/board-ni169445.config |  27 +++++++
>  arch/mips/generic/Kconfig                       |   6 ++
>  arch/mips/generic/vmlinux.its.S                 |  25 ++++++
>  8 files changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ni.txt
>  create mode 100644 arch/mips/boot/dts/ni/169445.dts
>  create mode 100644 arch/mips/boot/dts/ni/Makefile
>  create mode 100644 arch/mips/configs/generic/board-ni169445.config
> 
> diff --git a/Documentation/devicetree/bindings/mips/ni.txt b/Documentation/devicetree/bindings/mips/ni.txt
> new file mode 100644
> index 0000000..722bf2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/ni.txt
> @@ -0,0 +1,7 @@
> +National Instruments MIPS platforms
> +
> +required root node properties:
> +	- compatible: must be "ni,169445"
> +
> +CPU Nodes
> +	- compatible: must be "mti,mips14KEc"
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c265a5f..b72f059 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8887,6 +8887,14 @@ F:	include/linux/sunrpc/
>  F:	include/uapi/linux/nfs*
>  F:	include/uapi/linux/sunrpc/
>  
> +NI169445 MIPS ARCHITECTURE
> +M:	Nathan Sullivan <nathan.sullivan@ni.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/boot/dts/ni/
> +F:	arch/mips/configs/generic/board-ni169445.config
> +F:	Documentation/devicetree/bindings/mips/ni.txt
> +
>  NILFS2 FILESYSTEM
>  M:	Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
>  L:	linux-nilfs@vger.kernel.org
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index b9db492..27b0f37 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -4,6 +4,7 @@ dts-dirs	+= img
>  dts-dirs	+= ingenic
>  dts-dirs	+= lantiq
>  dts-dirs	+= mti
> +dts-dirs	+= ni
>  dts-dirs	+= netlogic
>  dts-dirs	+= pic32
>  dts-dirs	+= qca
> diff --git a/arch/mips/boot/dts/ni/169445.dts b/arch/mips/boot/dts/ni/169445.dts
> new file mode 100644
> index 0000000..9746576
> --- /dev/null
> +++ b/arch/mips/boot/dts/ni/169445.dts
> @@ -0,0 +1,100 @@
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ni,169445";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "mti,mips14KEc";
> +			clocks = <&baseclk>;
> +			reg = <0>;
> +		};
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x10000000>;
> +	};
> +
> +	baseclk: baseclock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +	};
> +
> +	cpu_intc: cpu_intc {

interrupt-controller {

> +		#address-cells = <0>;
> +		compatible = "mti,cpu-interrupt-controller";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	ahb@0 {

ahb@1f300000

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x1f300000 0x80FFF>;
> +
> +		gpio1:gpio-controller@1f300010 {
                      ^ space

'gpio' is the standard node name, so

gpio@...

> +			compatible = "ni,169445-nand-gpio";
> +			reg = <0x10 0x4>;
> +			reg-names = "dat";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		gpio2:gpio-controller@1f300014 {

ditto

> +			compatible = "ni,169445-nand-gpio";
> +			reg = <0x14 0x4>;
> +			reg-names = "dat";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			no-output;
> +		};
> +
> +		nand@1f300000 {
> +			compatible = "gpio-control-nand";
> +			nand-on-flash-bbt;
> +			nand-ecc-mode = "soft_bch";
> +			nand-ecc-step-size = <512>;
> +			nand-ecc-strength = <4>;
> +			reg = <0x0 4>;
> +			gpios = <&gpio2 0 0>, /* rdy */
> +				<&gpio1 1 0>, /* nce */
> +				<&gpio1 2 0>, /* ale */
> +				<&gpio1 3 0>, /* cle */
> +				<&gpio1 4 0>; /* nwp */
> +		};
> +
> +		serial@1f380000 {
> +			compatible = "ns16550a";
> +			reg = <0x80000 0x1000>;
> +			interrupt-parent = <&cpu_intc>;
> +			interrupts = <6>;
> +			clocks = <&baseclk>;
> +			reg-shift = <0>;
> +		};
> +
> +		ethernet@1f340000 {
> +			compatible = "snps,dwmac-4.10a";
> +			interrupt-parent = <&cpu_intc>;
> +			interrupts = <5>;
> +			interrupt-names = "macirq";
> +			reg = <0x40000 0x2000>;
> +			clock-names = "stmmaceth", "pclk";
> +			clocks = <&baseclk>, <&baseclk>;
> +
> +			phy-mode = "rgmii";
> +
> +			fixed-link {
> +				speed = <1000>;
> +				full-duplex;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/mips/boot/dts/ni/Makefile b/arch/mips/boot/dts/ni/Makefile
> new file mode 100644
> index 0000000..66cfdff
> --- /dev/null
> +++ b/arch/mips/boot/dts/ni/Makefile
> @@ -0,0 +1,7 @@
> +dtb-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= 169445.dtb
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-					+= dummy.o
> +
> +always					:= $(dtb-y)
> +clean-files				:= *.dtb *.dtb.S
> diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/configs/generic/board-ni169445.config
> new file mode 100644
> index 0000000..0bae1f8
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-ni169445.config
> @@ -0,0 +1,27 @@
> +CONFIG_FIT_IMAGE_FDT_NI169445=y
> +
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +
> +CONFIG_GPIOLIB=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_GENERIC_PLATFORM=y
> +
> +CONFIG_MTD=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_CMDLINE_PARTS=y
> +
> +CONFIG_MTD_NAND_ECC=y
> +CONFIG_MTD_NAND_ECC_BCH=y
> +CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_GPIO=y
> +CONFIG_MTD_NAND_IDS=y
> +
> +CONFIG_MTD_UBI=y
> +CONFIG_MTD_UBI_BLOCK=y
> +
> +CONFIG_NETDEVICES=y
> +CONFIG_STMMAC_ETH=y
> +CONFIG_STMMAC_PLATFORM=y
> +CONFIG_DWMAC_GENERIC=y
> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index a606b3f..fbf0813 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -16,4 +16,10 @@ config LEGACY_BOARD_SEAD3
>  	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
>  	  development boards, which boot using a legacy boot protocol.
>  
> +config FIT_IMAGE_FDT_NI169445
> +	bool "Include FDT for NI 169445"
> +	help
> +	  Enable this to include the FDT for the 169445 platform from
> +	  National Instruments in the FIT kernel image.
> +
>  endif
> diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
> index f67fbf1..de851f7 100644
> --- a/arch/mips/generic/vmlinux.its.S
> +++ b/arch/mips/generic/vmlinux.its.S
> @@ -29,3 +29,28 @@
>  		};
>  	};
>  };
> +
> +#ifdef CONFIG_FIT_IMAGE_FDT_NI169445
> +/ {

IMO, this shouldn't be in the kernel. Is the kernel supposed to 
create board specific images for every bootloaders custom format? It 
doesn't scale.

> +	images {
> +		fdt@ni169445 {
> +			description = "NI 169445 device tree";
> +			data = /incbin/("boot/dts/ni/169445.dtb");
> +			type = "flat_dt";
> +			arch = "mips";
> +			compression = "none";
> +			hash@0 {
> +				algo = "sha1";
> +			};
> +		};
> +	};
> +
> +	configurations {
> +		conf@ni169445 {
> +			description = "NI 169445 Linux Kernel";
> +			kernel = "kernel@0";
> +			fdt = "fdt@ni169445";
> +		};
> +	};
> +};
> +#endif
> -- 
> 2.1.4
> 
