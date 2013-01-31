Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 15:11:56 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:45947 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825899Ab3AaOLyKO9jv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jan 2013 15:11:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id ED12025CD6A;
        Thu, 31 Jan 2013 15:11:48 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sPyPyUghPsTu; Thu, 31 Jan 2013 15:11:48 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 9A19D25CD65;
        Thu, 31 Jan 2013 15:11:48 +0100 (CET)
Message-ID: <510A7BA3.7050502@openwrt.org>
Date:   Thu, 31 Jan 2013 15:11:47 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 09/10] MIPS: ralink: adds rt305x devicetree
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org> <1359633561-4980-10-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359633561-4980-10-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-archive-position: 35672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2013.01.31. 12:59 keltezéssel, John Crispin írta:
> This adds the devicetree file that describes the rt305x evaluation kit.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

I hate to say this again, but the compatible strings should be extended.

> ---
>  arch/mips/ralink/dts/rt305x.dts |  151 +++++++++++++++++++++++++++++++++++++++
>  arch/mips/ralink/rt305x.c       |    4 +-
>  2 files changed, 153 insertions(+), 2 deletions(-)
>  create mode 100644 arch/mips/ralink/dts/rt305x.dts
> 
> diff --git a/arch/mips/ralink/dts/rt305x.dts b/arch/mips/ralink/dts/rt305x.dts
> new file mode 100644
> index 0000000..c7298f3
> --- /dev/null
> +++ b/arch/mips/ralink/dts/rt305x.dts
> @@ -0,0 +1,151 @@
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ralink,rt305x";

compatible = "ralink,rt3052-eval-board", "ralink,rt3052-soc";

Although if you have a unique model number for your evaluation board, it would
be better to use that in the first compatible string.

Also it would be good to include a model property into each machine's dts file.
I mean something similar to this:

model = "Ralink RT3052 evaluation board";

> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "mips,mips24KEc";
> +		};
> +	};
> +
> +	memory@0 {
> +		reg = <0x0 0x2000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,57600 init=/init";
> +	};
> +
> +	palmbus@10000000 {
> +		compatible = "palmbus";
> +		reg = <0x10000000 0x200000>;
> +                ranges = <0x0 0x10000000 0x1FFFFF>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysc@0 {
> +			compatible = "ralink,rt3052-sysc";

compatible = "ralink,rt3052-sysc", "ralink,rt3050-sysc";

> +			reg = <0x0 0x100>;
> +
> +			ralink,pinmmux = "uartlite", "spi";
> +			ralink,uartmux = "gpio";
> +			ralink,wdtmux = <0>;
> +		};
> +
> +		timer@100 {
> +			compatible = "ralink,rt2880-wdt";

compatible = "ralink,rt3052-wdt", "ralink,rt2880-wdt";

> +			reg = <0x100 0x100>;
> +		};
> +
> +		intc: intc@200 {
> +			compatible = "ralink,rt2880-intc";

compatible = "ralink,rt3052-intc", "ralink,rt2880-intc";


> +			reg = <0x200 0x100>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		memc@300 {
> +			compatible = "ralink,rt3052-memc";

compatible = "ralink,rt3052-memc", "ralink,rt3050-memc";

> +			reg = <0x300 0x100>;
> +		};
> +
> +		gpio0: gpio@600 {
> +			compatible = "ralink,rt2880-gpio";

compatible = "ralink,rt3052-gpio", "ralink,rt2880-gpio";

> +			reg = <0x600 0x34>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			ralink,ngpio = <24>;
> +			ralink,regs = [ 00 04 08 0c
> +					20 24 28 2c
> +					30 34 ];
> +		};
> +
> +		gpio1: gpio@638 {
> +			compatible = "ralink,rt2880-gpio";

compatible = "ralink,rt3052-gpio", "ralink,rt2880-gpio";

> +			reg = <0x638 0x24>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			ralink,ngpio = <16>;
> +			ralink,regs = [ 00 04 08 0c
> +					10 14 18 1c
> +					20 24 ];
> +		};
> +
> +		gpio2: gpio@660 {
> +			compatible = "ralink,rt2880-gpio";

compatible = "ralink,rt3052-gpio", "ralink,rt2880-gpio";

> +			reg = <0x660 0x24>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			ralink,ngpio = <12>;
> +			ralink,regs = [ 00 04 08 0c
> +					10 14 18 1c
> +					20 24 ];
> +		};
> +
> +		spi@b00 {
> +			compatible = "ralink,rt2880-spi";

compatible = "ralink,rt3052-spi", "ralink,rt2880-spi";


> +			reg = <0xb00 0x100>;
> +		};
> +
> +		uartlite@c00 {
> +			compatible = "ns16550a";

compatible = "ralink,rt3052-uart", "ralink,rt2880-uart", "ns16550a";

> +			reg = <0xc00 0x100>;
> +
> +			interrupt-parent = <&intc>;
> +			interrupts = <12>;
> +
> +			reg-shift = <2>;
> +		};
> +
> +		fe@100000 {
> +			compatible = "ralink,rt3052-fe";

compatible = "ralink,rt3052-esw", "ralink,rt3050-fe";

> +			reg = <0x100000 0x10000>;
> +		};
> +
> +		esw@110000 {
> +			compatible = "ralink,rt3052-esw";

compatible = "ralink,rt3052-esw", "ralink,rt3050-esw";

> +			reg = <0x110000 0x8000>;
> +		};
> +	};

-Gabor
