Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:31:58 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:57471 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011496AbcAYWb4MFdCU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:31:56 +0100
Received: from tock (unknown [80.171.100.146])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 9003582280;
        Mon, 25 Jan 2016 23:30:24 +0100 (CET)
Date:   Mon, 25 Jan 2016 23:31:48 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC v3 06/14] MIPS: dts: qca: ar9132: use short references for
 uart and spi nodes
Message-ID: <20160125233148.4951e311@tock>
In-Reply-To: <1453580251-2341-7-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51378
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

On Sat, 23 Jan 2016 23:17:23 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

I personally prefer the version without aliases :) Is there any
guidelines on this?

Alban

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/mips/boot/dts/qca/ar9132.dtsi               |  4 +-
>  arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 70 +++++++++++-------------
>  2 files changed, 35 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
> index cd1602f..a14f6f2 100644
> --- a/arch/mips/boot/dts/qca/ar9132.dtsi
> +++ b/arch/mips/boot/dts/qca/ar9132.dtsi
> @@ -61,7 +61,7 @@
>  				#qca,ddr-wb-channel-cells = <1>;
>  			};
>  
> -			uart@18020000 {
> +			uart: uart@18020000 {
>  				compatible = "ns8250";
>  				reg = <0x18020000 0x20>;
>  				interrupts = <3>;
> @@ -134,7 +134,7 @@
>  			};
>  		};
>  
> -		spi@1f000000 {
> +		spi: spi@1f000000 {
>  			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
>  			reg = <0x1f000000 0x10>;
>  
> diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> index 9618105..f22c22c 100644
> --- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> @@ -14,43 +14,6 @@
>  		reg = <0x0 0x2000000>;
>  	};
>  
> -	ahb {
> -		apb {
> -			uart@18020000 {
> -				status = "okay";
> -			};
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
>  	gpio-keys {
>  		compatible = "gpio-keys-polled";
>  		#address-cells = <1>;
> @@ -100,3 +63,36 @@
>  &extosc {
>  	clock-frequency = <40000000>;
>  };
> +
> +&uart {
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
> +	};
> +};
