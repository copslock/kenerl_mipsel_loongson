Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Feb 2016 22:25:06 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:15326 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011781AbcBNVZBdP7Pn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 14 Feb 2016 22:25:01 +0100
Received: from tock (unknown [78.54.179.56])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 749C0D48127;
        Sun, 14 Feb 2016 22:22:04 +0100 (CET)
Date:   Sun, 14 Feb 2016 22:24:45 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 06/10] MIPS: dts: qca: ar9132: use short references for
 uart, usb and spi nodes
Message-ID: <20160214222445.6eee4365@tock>
In-Reply-To: <1455400697-29898-7-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
        <1455400697-29898-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sun, 14 Feb 2016 00:58:13 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> Here are some Sascha Hauer's arguments for using aliases in the dts
> files:
> 
>  - using aliases reduces the number of indentations in dts files;
> 
>  - dts files become independent of the layout of the dtsi files
>    (it becomes possible to introduce another bus {} hierarchy between
>    a toplevel bus and the devices when you have to);
> 
>  - less chances for typos. if &i2c2 does not exist you get an error.
>    If instead you duplicate the whole path in the dts file a typo
>    in the path will just create another node.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/mips/boot/dts/qca/ar9132.dtsi               |  6 +-
>  arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 82 ++++++++++++------------
>  2 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
> index 3c2ed9e..511cb4d 100644
> --- a/arch/mips/boot/dts/qca/ar9132.dtsi
> +++ b/arch/mips/boot/dts/qca/ar9132.dtsi
> @@ -52,7 +52,7 @@
>  				#qca,ddr-wb-channel-cells = <1>;
>  			};
>  
> -			uart@18020000 {
> +			uart: uart@18020000 {
>  				compatible = "ns8250";
>  				reg = <0x18020000 0x20>;
>  				interrupts = <3>;

Please also add a label for the watchdog, then all devices would be
covered.

> @@ -125,7 +125,7 @@
>  			};
>  		};
>  
> -		usb@1b000100 {
> +		usb: usb@1b000100 {
>  			compatible = "qca,ar7100-ehci", "generic-ehci";
>  			reg = <0x1b000100 0x100>;
>  
> @@ -140,7 +140,7 @@
>  			status = "disabled";
>  		};
>  
> -		spi@1f000000 {
> +		spi: spi@1f000000 {
>  			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
>  			reg = <0x1f000000 0x10>;
>  
> diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> index c3069c3..9528ebd 100644
> --- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> @@ -22,51 +22,10 @@
>  
>  	ahb {
>  		apb {
> -			uart@18020000 {
> -				status = "okay";
> -			};
> -
>  			pll-controller@18050000 {
>  				clocks = <&extosc>;
>  			};
>  		};

Better use a reference for the PLL clock too.

> -
> -		usb@1b000100 {
> -			status = "okay";
> -		};
> -
> -		spi@1f000000 {
> -			status = "okay";
> -			num-cs = <1>;
> -
> -			flash@0 {
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				compatible = "s25sl064a";
> -				reg = <0>;
> -				spi-max-frequency = <25000000>;
> -
> -				partition@0 {
> -					label = "u-boot";
> -					reg = <0x000000 0x020000>;
> -				};
> -
> -				partition@1 {
> -					label = "firmware";
> -					reg = <0x020000 0x7D0000>;
> -				};
> -
> -				partition@2 {
> -					label = "art";
> -					reg = <0x7F0000 0x010000>;
> -					read-only;
> -				};
> -			};
> -		};
> -	};
> -
> -	usb-phy {
> -		status = "okay";
>  	};
>  
>  	gpio-keys {
> @@ -114,3 +73,44 @@
>  		};
>  	};
>  };
> +
> +&uart {
> +	status = "okay";
> +};
> +
> +&usb {
> +	status = "okay";
> +};
> +
> +&usb_phy {
> +	status = "okay";
> +};
> +
> +&spi {
> +	status = "okay";
> +	num-cs = <1>;
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "s25sl064a";
> +		reg = <0>;
> +		spi-max-frequency = <25000000>;
> +
> +		partition@0 {
> +			label = "u-boot";
> +			reg = <0x000000 0x020000>;
> +		};
> +
> +		partition@1 {
> +			label = "firmware";
> +			reg = <0x020000 0x7D0000>;
> +		};
> +
> +		partition@2 {
> +			label = "art";
> +			reg = <0x7F0000 0x010000>;
> +			read-only;
> +		};

Looses partitions like this are now deprecated, we could take the
opportunity to move to the new scheme. We just have to put all the
"partition" nodes under a "partitions" node with a proper compatible and
#address-cells and #size-cells.

Alban
