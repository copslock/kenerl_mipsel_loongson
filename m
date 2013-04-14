Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Apr 2013 13:40:53 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:59662 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825727Ab3DNLkwf-U12 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 14 Apr 2013 13:40:52 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r56tSYyR9b99; Sun, 14 Apr 2013 13:40:04 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 332F728015F;
        Sun, 14 Apr 2013 13:40:04 +0200 (CEST)
Message-ID: <516A95ED.1060801@openwrt.org>
Date:   Sun, 14 Apr 2013 13:41:33 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 6/6] DT: MIPS: ralink: add MT7620 dts files
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org> <1365843026-11015-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365843026-11015-6-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36162
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

2013.04.13. 10:50 keltezéssel, John Crispin írta:
> Add a dtsi file for MT7620 SoC and a sample dts file.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/Kconfig             |    4 +++
>  arch/mips/ralink/dts/Makefile        |    1 +
>  arch/mips/ralink/dts/mt7620.dtsi     |   58 ++++++++++++++++++++++++++++++++++
>  arch/mips/ralink/dts/mt7620_eval.dts |   18 +++++++++++
>  4 files changed, 81 insertions(+)
>  create mode 100644 arch/mips/ralink/dts/mt7620.dtsi
>  create mode 100644 arch/mips/ralink/dts/mt7620_eval.dts
> 
> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> index 493411f..8254502 100644
> --- a/arch/mips/ralink/Kconfig
> +++ b/arch/mips/ralink/Kconfig
> @@ -46,6 +46,10 @@ choice
>  		bool "RT3883 eval kit"
>  		depends on SOC_RT3883
>  
> +	config DTB_MT7620_EVAL
> +		bool "MT7620 eval kit"

To be precise, this is a MT7620A based evaluation board. Both the config symbol
and the prompt should reflect that IMO.

> +		depends on SOC_MT7620
> +
>  endchoice
>  
>  endif
> diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
> index 040a986..036603a 100644
> --- a/arch/mips/ralink/dts/Makefile
> +++ b/arch/mips/ralink/dts/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
>  obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
>  obj-$(CONFIG_DTB_RT3883_EVAL) := rt3883_eval.dtb.o
> +obj-$(CONFIG_DTB_MT7620_EVAL) := mt7620_eval.dtb.o
> diff --git a/arch/mips/ralink/dts/mt7620.dtsi b/arch/mips/ralink/dts/mt7620.dtsi
> new file mode 100644
> index 0000000..5087c57
> --- /dev/null
> +++ b/arch/mips/ralink/dts/mt7620.dtsi
> @@ -0,0 +1,58 @@
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ralink,mtk7620n-soc", "ralink,mt7620-soc";

This does not match with the actual MT7620 code. That uses "ralink,mt7620n-soc"
and "ralink,mt7620a-soc" values. Ideally, we should have separate dtsi files for
the two SoCs. Additionally, the compatible property of the root node will be
overwritten in the board specific dts files so adding that to the dtsi file
seems superfluous.

> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "mips,mips24KEc";
> +		};
> +	};
> +
> +	cpuintc: cpuintc@0 {
> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		compatible = "mti,cpu-interrupt-controller";
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
> +			compatible = "ralink,mt7620-sysc", "ralink,mt7620n-sysc";

The 'mt7620-' prefix is a wildcard, either 'mt7620n-' or 'mt7620a-' should be
used instead. This applies to the following nodes as well.

> +			reg = <0x0 0x100>;
> +		};
> +
> +		intc: intc@200 {
> +			compatible = "ralink,mt7620-intc", "ralink,rt2880-intc";
> +			reg = <0x200 0x100>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			interrupt-parent = <&cpuintc>;
> +			interrupts = <2>;
> +		};
> +
> +		memc@300 {
> +			compatible = "ralink,mt7620-memc", "ralink,rt3050-memc";
> +			reg = <0x300 0x100>;
> +		};
> +
> +		uartlite@c00 {
> +			compatible = "ralink,mt7620-uart", "ralink,rt2880-uart", "ns16550a";
> +			reg = <0xc00 0x100>;
> +
> +			interrupt-parent = <&intc>;
> +			interrupts = <12>;
> +
> +			reg-shift = <2>;
> +		};
> +	};
> +};
> diff --git a/arch/mips/ralink/dts/mt7620_eval.dts b/arch/mips/ralink/dts/mt7620_eval.dts
> new file mode 100644
> index 0000000..72dec59
> --- /dev/null
> +++ b/arch/mips/ralink/dts/mt7620_eval.dts

The DTS file describes an evaluation board with a MT7620A SoC, the file name
should be changed to reflect that. It would help to avoid confusion if we want
to add another DTS file for a MT7620N based evaluation board later.

> @@ -0,0 +1,18 @@
> +/dts-v1/;
> +
> +/include/ "mt7620.dtsi"
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ralink,mt7620a-eval-board", "ralink,mt7620a-soc";
> +	model = "Ralink MT7620 evaluation board";

s/MT7620/MT7620A/

> +
> +	memory@0 {
> +		reg = <0x0 0x4000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,57600";
> +	};
> +};
> 

-Gabor
