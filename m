Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2011 02:15:40 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:55925 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491981Ab1CEBPh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Mar 2011 02:15:37 +0100
Received: by yxh35 with SMTP id 35so1045289yxh.36
        for <multiple recipients>; Fri, 04 Mar 2011 17:15:30 -0800 (PST)
Received: by 10.101.211.6 with SMTP id n6mr49159anq.253.1299287730469;
        Fri, 04 Mar 2011 17:15:30 -0800 (PST)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id w6sm12663anf.6.2011.03.04.17.15.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 17:15:29 -0800 (PST)
Received: by angua (Postfix, from userid 1000)
        id E361F3C00D3; Fri,  4 Mar 2011 18:15:26 -0700 (MST)
Date:   Fri, 4 Mar 2011 18:15:26 -0700
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/12] MIPS: Octeon: Add device tree source
 files.
Message-ID: <20110305011526.GE7579@angua.secretlab.ca>
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
 <1299267744-17278-5-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299267744-17278-5-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Fri, Mar 04, 2011 at 11:42:16AM -0800, David Daney wrote:
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/cavium-octeon/.gitignore      |    2 +
>  arch/mips/cavium-octeon/Makefile        |   13 ++
>  arch/mips/cavium-octeon/octeon_3xxx.dts |  330 +++++++++++++++++++++++++++++++
>  arch/mips/cavium-octeon/octeon_68xx.dts |  116 +++++++++++
>  4 files changed, 461 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/cavium-octeon/.gitignore
>  create mode 100644 arch/mips/cavium-octeon/octeon_3xxx.dts
>  create mode 100644 arch/mips/cavium-octeon/octeon_68xx.dts
> 
> diff --git a/arch/mips/cavium-octeon/.gitignore b/arch/mips/cavium-octeon/.gitignore
> new file mode 100644
> index 0000000..39c9686
> --- /dev/null
> +++ b/arch/mips/cavium-octeon/.gitignore
> @@ -0,0 +1,2 @@
> +*.dtb.S
> +*.dtb
> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
> index 19eb043..5e25dce 100644
> --- a/arch/mips/cavium-octeon/Makefile
> +++ b/arch/mips/cavium-octeon/Makefile
> @@ -15,3 +15,16 @@ obj-y += octeon-memcpy.o
>  obj-y += executive/
>  
>  obj-$(CONFIG_SMP)                     += smp.o
> +
> +DTS_FILES = octeon_3xxx.dts octeon_68xx.dts
> +DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
> +
> +obj-y += $(patsubst %.dts, %.dtb.o, $(DTS_FILES))
> +
> +$(obj)/%.dtb: $(src)/%.dts
> +	$(call cmd,dtc)
> +
> +# Let's keep the .dtb files around in case we want to look at them.
> +.SECONDARY:  $(addprefix $(obj)/, $(DTB_FILES))
> +
> +clean-files += $(DTB_FILES) $(patsubst %.dtb, %.dtb.S, $(DTB_FILES))
> diff --git a/arch/mips/cavium-octeon/octeon_3xxx.dts b/arch/mips/cavium-octeon/octeon_3xxx.dts
> new file mode 100644
> index 0000000..6910d9d
> --- /dev/null
> +++ b/arch/mips/cavium-octeon/octeon_3xxx.dts
> @@ -0,0 +1,330 @@
> +/dts-v1/;
> +/*
> + * OCTEON 3XXX, 5XXX, 63XX device tree skeleton.
> + *
> + * This device tree is pruned and patched by early boot code before
> + * use.  Because of this, it contains a super-set of the available
> + * devices and properties.
> + */
> +/ {
> +	model = "OCTEON";

Be more specific in the model property.  What is the full (human
readable) name of this board?  Since your using this simply as a
template, it may be better to just omit this property entirely.

> +	compatible = "cavium,octeon-3860";

All of the new compatible values in this file need to be documented in
Documentation/devicetree/bindings.

> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges; /* Direct mapping */
> +
> +		ciu: interrupt-controller@1070000000000 {
> +			compatible = "cavium,octeon-3860-ciu";
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			/* Interrupts are specified by three parts:
> +			 * 1) Controller register (0 or 1)
> +			 * 2) Bit within the register (0..63)
> +			 * 3) Triggering (0 - level active high
> +			 *		  1 - level active low
> +			 *		  2 - edge rising
> +			 *		  3 - edge falling
> +			 *
> +			 * For non-GPIO sources, the triggering cannot be
> +			 * changed and is ignored.
> +			 */
> +			#interrupt-cells = <3>;
> +			reg = <0x10700 0x00000000 0x0 0x7000>;
> +		};
> +
> +		smi0: mdio@1180000001800 {
> +			compatible = "cavium,octeon-3860-mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x11800 0x00001800 0x0 0x40>;
> +
> +			phy0: ethernet-phy@0 {
> +				reg = <0>;

Should have a compatible property for each of the phys

> +			};
> +
> +			phy1: ethernet-phy@1 {
> +				reg = <1>;
> +			};
> +
> +			phy2: ethernet-phy@2 {
> +				reg = <2>;
> +				marvell,reg-init = <3 0x10 0 0x5777>,
> +					<3 0x11 0 0x00aa>,
> +					<3 0x12 0 0x4105>,
> +					<3 0x13 0 0x0a60>;
> +			};
> +			phy3: ethernet-phy@3 {
> +				reg = <3>;
> +				marvell,reg-init = <3 0x10 0 0x5777>,
> +					<3 0x11 0 0x00aa>,
> +					<3 0x12 0 0x4105>,
> +					<3 0x13 0 0x0a60>;
> +			};
> +			phy4: ethernet-phy@4 {
> +				reg = <4>;
> +				marvell,reg-init = <3 0x10 0 0x5777>,
> +					<3 0x11 0 0x00aa>,
> +					<3 0x12 0 0x4105>,
> +					<3 0x13 0 0x0a60>;
> +			};
> +			phy5: ethernet-phy@5 {
> +				reg = <5>;
> +				marvell,reg-init = <3 0x10 0 0x5777>,
> +					<3 0x11 0 0x00aa>,
> +					<3 0x12 0 0x4105>,
> +					<3 0x13 0 0x0a60>;
> +			};
> +
> +			phy6: ethernet-phy@6 {
> +				reg = <6>;
> +				marvell,reg-init = <3 0x10 0 0x5777>,
> +					<3 0x11 0 0x00aa>,
> +					<3 0x12 0 0x4105>,
> +					<3 0x13 0 0x0a60>;
> +			};
> +			phy7: ethernet-phy@7 {
> +				reg = <7>;
> +				marvell,reg-init = <3 0x10 0 0x5777>,
> +					<3 0x11 0 0x00aa>,
> +					<3 0x12 0 0x4105>,
> +					<3 0x13 0 0x0a60>;
> +			};
> +			phy8: ethernet-phy@8 {
> +				reg = <8>;
> +				marvell,reg-init = <3 0x10 0 0x5777>,
> +					<3 0x11 0 0x00aa>,
> +					<3 0x12 0 0x4105>,
> +					<3 0x13 0 0x0a60>;
> +			};
> +			phy9: ethernet-phy@9 {
> +				reg = <9>;
> +				marvell,reg-init = <3 0x10 0 0x5777>,
> +					<3 0x11 0 0x00aa>,
> +					<3 0x12 0 0x4105>,
> +					<3 0x13 0 0x0a60>;
> +			};
> +		};
> +
> +		smi1: mdio@1180000001900 {
> +			compatible = "cavium,octeon-3860-mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x11800 0x00001900 0x0 0x40>;
> +		};
> +
> +		mix0: ethernet@1070000100000 {
> +			compatible = "cavium,octeon-5750-mix";
> +			device_type = "network";

Drop 'device_type' property.  It only makes sense if you have a real
OpenFirmware implementation.  Ditto through the rest of the file.

> +			reg = <0x10700 0x00100000 0x0 0x100>, /* MIX */
> +			      <0x11800 0xE0000000 0x0 0x300>, /* AGL */
> +			      <0x11800 0xE0000400 0x0 0x400>, /* AGL_SHARED  */
> +			      <0x11800 0xE0002000 0x0 0x8>;   /* AGL_PRT_CTL */
> +			cell-index = <0>;
> +			interrupt-parent = <&ciu>;

If you put this property up in the root node, then you can omit it
from everywhere else because they'll pick it up as the default
interrupt controller.

> +			interrupts = <0 62 0>, <1 46 0>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			phy-handle = <&phy0>;
> +		};
> +
> +		mix1: ethernet@1070000100800 {
> +			compatible = "cavium,octeon-5750-mix";
> +			device_type = "network";
> +			reg = <0x10700 0x00100800 0x0 0x100>, /* MIX */
> +			      <0x11800 0xE0000800 0x0 0x300>, /* AGL */
> +			      <0x11800 0xE0000400 0x0 0x400>, /* AGL_SHARED  */
> +			      <0x11800 0xE0002008 0x0 0x8>;   /* AGL_PRT_CTL */
> +			cell-index = <1>;
> +			interrupt-parent = <&ciu>;
> +			interrupts = <1 18 0>, < 1 46 0>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			phy-handle = <&phy1>;
> +		};
> +
> +		pip: pip@11800a0000000 {
> +			compatible = "cavium,octeon-3860-pip";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x11800 0xa0000000 0x0 0x2000>;
> +
> +			interface@0 {
> +				compatible = "cavium,octeon-3860-pip-interface";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0>; /* interface */
> +
> +				ethernet@0 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x0>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +					phy-handle = <&phy2>;
> +				};
> +				ethernet@1 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x1>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +					phy-handle = <&phy3>;
> +				};
> +				ethernet@2 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x2>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +					phy-handle = <&phy4>;
> +				};
> +				ethernet@3 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x3>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +					phy-handle = <&phy5>;
> +				};
> +			};
> +
> +			interface@1 {
> +				compatible = "cavium,octeon-3860-pip-interface";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <1>; /* interface */
> +
> +				ethernet@0 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x0>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +					phy-handle = <&phy6>;
> +				};
> +				ethernet@1 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x1>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +					phy-handle = <&phy7>;
> +				};
> +				ethernet@2 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x2>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +					phy-handle = <&phy8>;
> +				};
> +				ethernet@3 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x3>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +					phy-handle = <&phy9>;
> +				};
> +			};
> +
> +			interface@2 { /* DPI interface. */
> +				compatible = "cavium,octeon-3860-pip-interface";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <2>; /* interface */
> +
> +				ethernet@0 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x0>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +				};
> +				ethernet@1 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x1>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +				};
> +				ethernet@2 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x2>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +				};
> +				ethernet@3 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x3>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +				};
> +			};
> +
> +			interface@3 { /* Loop interface. */
> +				compatible = "cavium,octeon-3860-pip-interface";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <3>; /* interface */
> +
> +				ethernet@0 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x0>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +				};
> +				ethernet@1 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x1>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +				};
> +				ethernet@2 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x2>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +				};
> +				ethernet@3 {
> +					compatible = "cavium,octeon-3860-pip-port";
> +					device_type = "network";
> +					reg = <0x3>; /* Port */
> +					local-mac-address = [ 00 00 00 00 00 00 ];
> +				};
> +			};
> +		};
> +
> +		twsi0: i2c@1180000001000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "cavium,octeon-3860-twsi";
> +			reg = <0x11800 0x00001000 0x0 0x200>;
> +			interrupt-parent = <&ciu>;
> +			interrupts = <0 45 0>;
> +			clock-rate = <100000>;
> +
> +			rtc@68 {
> +				compatible = "dallas,ds1337";
> +				reg = <0x68>;
> +			};
> +			tmp@4c {
> +				compatible = "ti,tmp421";
> +				reg = <0x4c>;
> +			};
> +		};
> +
> +		twsi1: i2c@1180000001200 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "cavium,octeon-3860-twsi";
> +			reg = <0x11800 0x00001200 0x0 0x200>;
> +			interrupt-parent = <&ciu>;
> +			interrupts = <0 59 0>;
> +			clock-rate = <100000>;
> +		};
> +	};
> +
> +	aliases {
> +		mix0 = &mix0;
> +		mix1 = &mix1;
> +		pip = &pip;
> +		smi0 = &smi0;
> +		smi1 = &smi1;
> +		twsi0 = &twsi0;
> +		twsi1 = &twsi1;
> +	};
> + };
> diff --git a/arch/mips/cavium-octeon/octeon_68xx.dts b/arch/mips/cavium-octeon/octeon_68xx.dts
> new file mode 100644
> index 0000000..f2a8eab
> --- /dev/null
> +++ b/arch/mips/cavium-octeon/octeon_68xx.dts
> @@ -0,0 +1,116 @@
> +/dts-v1/;
> +/*
> + * OCTEON 68XX device tree skeleton.
> + */
> +/ {
> +	model = "OCTEON";
> +	compatible = "cavium,octeon-6880";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges; /* Direct mapping */
> +
> +		ciu2: interrupt-controller@1070100000000 {
> +			compatible = "cavium,octeon-6880-ciu2";
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x10701 0x00000000 0x0 0x4000000>;
> +		};
> +
> +		smi0: mdio@1180000003800 {
> +			compatible = "cavium,octeon-3860-mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x11800 0x00003800 0x0 0x40>;
> +
> +		phy0: ethernet-phy@0 {
> +				reg = <0>;
> +				device_type = "ethernet-phy";
> +			};
> +
> +		phy1: ethernet-phy@1 {
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};
> +
> +		phy3: ethernet-phy@3 {
> +				reg = <3>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		smi1: mdio@1180000003880 {
> +			compatible = "cavium,octeon-3860-mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x11800 0x00003880 0x0 0x40>;
> +		};
> +
> +		smi2: mdio@1180000003900 {
> +			compatible = "cavium,octeon-3860-mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x11800 0x00003900 0x0 0x40>;
> +		};
> +
> +		smi3: mdio@1180000003980 {
> +			compatible = "cavium,octeon-3860-mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x11800 0x00003980 0x0 0x40>;
> +		};
> +
> +		mix0: ethernet@1070000100000 {
> +			compatible = "cavium,octeon-5750-mix";
> +			device_type = "network";
> +			reg = <0x10700 0x00100000 0x0 0x100>, /* MIX */
> +			      <0x11800 0xE0000000 0x0 0x300>, /* AGL */
> +			      <0x11800 0xE0000400 0x0 0x400>, /* AGL_SHARED  */
> +			      <0x11800 0xE0002000 0x0 0x8>;   /* AGL_PRT_CTL */
> +			cell-index = <0>;
> +			interrupt-parent = <&ciu2>;
> +			interrupts = <0 62>, <1 46>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			phy-handle = <&phy0>;
> +		};
> +
> +		twsi0: i2c@1180000001000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "cavium,octeon-3860-twsi";
> +			reg = <0x11800 0x00001000 0x0 0x200>;
> +			interrupt-parent = <&ciu2>;
> +			interrupts = <0 45>;
> +			clock-rate = <100000>;
> +
> +			rtc@68 {
> +				compatible = "dallas,ds1337";
> +				reg = <0x68>;
> +			};
> +		};
> +
> +		twsi1: i2c@1180000001200 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "cavium,octeon-3860-twsi";
> +			reg = <0x11800 0x00001200 0x0 0x200>;
> +			interrupt-parent = <&ciu2>;
> +			interrupts = <0 59>;
> +			clock-rate = <100000>;
> +		};
> +	};
> +	aliases {
> +		mix0 = &mix0;
> +		smi0 = &smi0;
> +		smi1 = &smi1;
> +		smi2 = &smi2;
> +		smi3 = &smi3;
> +		twsi0 = &twsi0;
> +		twsi1 = &twsi1;
> +	};
> + };
> -- 
> 1.7.2.3
> 
