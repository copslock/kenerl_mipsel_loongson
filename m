Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 17:59:18 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010806AbcATQ7Qe9fjf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2016 17:59:16 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 3E4DC204DE;
        Wed, 20 Jan 2016 16:59:14 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DE0F20375;
        Wed, 20 Jan 2016 16:59:12 +0000 (UTC)
Date:   Wed, 20 Jan 2016 10:59:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
Subject: Re: [PATCH 2/2] bmips: add device tree example for BCM6358
Message-ID: <20160120165910.GA32520@rob-hp-laptop>
References: <1453030101-14794-2-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1453030101-14794-2-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51258
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

On Sun, Jan 17, 2016 at 12:28:21PM +0100, Álvaro Fernández Rojas wrote:
> This adds a device tree example for SFR Neufbox4 (Sercomm version), which
> also serves as a real example for brcm,bcm6358-leds.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

[...]

> diff --git a/arch/mips/boot/dts/brcm/bcm6358.dtsi 
b/arch/mips/boot/dts/brcm/bcm6358.dtsi
> new file mode 100644
> index 0000000..b2d11da
> --- /dev/null
> +++ b/arch/mips/boot/dts/brcm/bcm6358.dtsi
> @@ -0,0 +1,111 @@
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "brcm,bcm6358";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mips-hpt-frequency = <150000000>;
> +
> +		cpu@0 {
> +			compatible = "brcm,bmips4350";
> +			device_type = "cpu";
> +			reg = <0>;
> +		};
> +
> +		cpu@1 {
> +			compatible = "brcm,bmips4350";
> +			device_type = "cpu";
> +			reg = <1>;
> +		};
> +	};
> +
> +	clocks {
> +		periph_clk: periph_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <50000000>;
> +		};
> +	};
> +
> +	aliases {
> +		leds0 = &leds0;

Why do we need alias for LEDs?

> +		uart0 = &uart0;
> +		uart1 = &uart1;
> +	};

[...]

> diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
> new file mode 100644
> index 0000000..ca95084
> --- /dev/null
> +++ b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
> @@ -0,0 +1,47 @@
> +/dts-v1/;
> +
> +/include/ "bcm6358.dtsi"
> +
> +/ {
> +	compatible = "sfr,nb4-ser", "brcm,bcm6358";
> +	model = "SFR Neufbox 4 (Sercomm)";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x02000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +		stdout-path = &uart0;

You shouldn't need both here. Just stdout-path.

Rob
