Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 23:34:41 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38485 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994895AbdHQVeeTALnu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 23:34:34 +0200
Received: by mail-oi0-f68.google.com with SMTP id s21so7621955oie.5;
        Thu, 17 Aug 2017 14:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDmenF5UfbVhME7G2vOZc03yH1cUi/1Zx2uk5ZMd5og=;
        b=ngrfEeGuP9/LsYQv0n92725kREjKcJedBN/NT/sg0AXGoQGDBYHG4yL0a6wLRyogQr
         wtvV/Jtz8Yse3u1C00AIzhEECBI0+p7w5Fno2FK/pehqKEsiWJBf0z/IultABOfugYPO
         hLFiPUnrYltblrgWfIArltFBUpiGBKTdH8rEkiJtcxIwAiU+2HF/KRytby46jzPsbyyr
         mL1j+4GZNth4QWxaRbCnkVBBi9OB/xrcbRLglN8l3CKlmsPhtMggCrLpNY3z1ys7Ucw3
         Z9hFe3oaiSMejluUC1+StBHiSyYmT2qausy83Rg1wsiX76WeUbRVnOUt3rVj9OmHA5PJ
         M9MQ==
X-Gm-Message-State: AHYfb5iSw4SAca4DILAVI9Ut1zXsxtAV55FjB15CZaw20x0iXbGV/pFM
        GkbSoMnwRCgR4Q==
X-Received: by 10.202.197.74 with SMTP id v71mr9828623oif.40.1503005668340;
        Thu, 17 Aug 2017 14:34:28 -0700 (PDT)
Received: from localhost (mobile-166-173-60-17.mycingular.net. [166.173.60.17])
        by smtp.gmail.com with ESMTPSA id r136sm4939468oie.20.2017.08.17.14.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2017 14:34:27 -0700 (PDT)
Date:   Thu, 17 Aug 2017 16:34:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     mark.rutland@arm.com, matthias.bgg@gmail.com, ralf@linux-mips.org,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] MIPS: dts: ralink: Add Mediatek MT7628A SoC
Message-ID: <20170817213426.34shgxwnjowcg4sk@rob-hp-laptop>
References: <1502814530-40604-1-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502814530-40604-1-git-send-email-harvey.hunt@imgtec.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59637
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

On Tue, Aug 15, 2017 at 05:28:50PM +0100, Harvey Hunt wrote:
> The MT7628A is the successor to the MT7620 and pin compatible with the
> MT7688A, although the latter supports only a 1T1R antenna rather than
> a 2T2R antenna.
> 
> This commit adds support for the following features:
> 
> - UART
> - USB PHY
> - EHCI
> - Interrupt controller
> - System controller
> - Memory controller
> - Reset controller
> 
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: linux-mips@linux-mips.org 
> Cc: devicetree@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> Cc: linux-mediatek@lists.infradead.org 
> ---
>  Documentation/devicetree/bindings/mips/ralink.txt |   1 +
>  arch/mips/boot/dts/ralink/mt7628a.dtsi            | 125 ++++++++++++++++++++++
>  2 files changed, 126 insertions(+)
>  create mode 100644 arch/mips/boot/dts/ralink/mt7628a.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/mips/ralink.txt b/Documentation/devicetree/bindings/mips/ralink.txt
> index b35a8d0..a16e8d7 100644
> --- a/Documentation/devicetree/bindings/mips/ralink.txt
> +++ b/Documentation/devicetree/bindings/mips/ralink.txt
> @@ -15,3 +15,4 @@ value must be one of the following values:
>    ralink,rt5350-soc
>    ralink,mt7620a-soc
>    ralink,mt7620n-soc
> +  ralink,mt7628a-soc
> diff --git a/arch/mips/boot/dts/ralink/mt7628a.dtsi b/arch/mips/boot/dts/ralink/mt7628a.dtsi
> new file mode 100644
> index 0000000..8461fe9
> --- /dev/null
> +++ b/arch/mips/boot/dts/ralink/mt7628a.dtsi
> @@ -0,0 +1,125 @@
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ralink,mt7628a-soc";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "mti,mips24KEc";
> +			device_type = "cpu";
> +			reg = <0>;
> +		};
> +	};
> +
> +	resetctrl: resetctrl {

reset-controller {

> +		compatible = "ralink,rt2880-reset";
> +		#reset-cells = <1>;
> +	};
> +
> +	cpuintc: cpuintc {

interrupt-controller {

> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		compatible = "mti,cpu-interrupt-controller";
> +	};
> +
> +	palmbus@10000000 {
> +		compatible = "palmbus";
> +		reg = <0x10000000 0x200000>;
> +		ranges = <0x0 0x10000000 0x1FFFFF>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysc@0 {

system-controller@0

> +			compatible = "ralink,mt7620a-sysc";
> +			reg = <0x0 0x100>;
> +		};
> +
> +		intc: intc@200 {

interrupt-controller@200

> +			compatible = "ralink,rt2880-intc";
> +			reg = <0x200 0x100>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			resets = <&resetctrl 9>;
> +			reset-names = "intc";
> +
> +			interrupt-parent = <&cpuintc>;
> +			interrupts = <2>;
> +
> +			ralink,intc-registers = <0x9c 0xa0
> +						 0x6c 0xa4
> +						 0x80 0x78>;
> +		};
> +
> +		memc@300 {

memory-controller@300

> +			compatible = "ralink,mt7620a-memc";
> +			reg = <0x300 0x100>;
> +		};
> +
> +		uartlite@c00 {

serial@c00

And so on. IOW, use standard, generic node names as defined in the DT 
spec.

> +			compatible = "ns16550a";
> +			reg = <0xc00 0x100>;
> +
> +			resets = <&resetctrl 12>;
> +			reset-names = "uart0";
> +
> +			interrupt-parent = <&intc>;
> +			interrupts = <20>;
> +
> +			reg-shift = <2>;
> +		};
> +
> +		uart1@d00 {
> +			compatible = "ns16550a";
> +			reg = <0xd00 0x100>;
> +
> +			resets = <&resetctrl 19>;
> +			reset-names = "uart1";
> +
> +			interrupt-parent = <&intc>;
> +			interrupts = <21>;
> +
> +			reg-shift = <2>;
> +		};
> +
> +		uart2@e00 {
> +			compatible = "ns16550a";
> +			reg = <0xe00 0x100>;
> +
> +			resets = <&resetctrl 20>;
> +			reset-names = "uart2";
> +
> +			interrupt-parent = <&intc>;
> +			interrupts = <22>;
> +
> +			reg-shift = <2>;
> +		};
> +	};
> +
> +	usbphy: uphy@10120000 {
> +		compatible = "mediatek,mt7628-usbphy";
> +		reg = <0x10120000 0x1000>;
> +
> +		#phy-cells = <0>;
> +
> +		resets = <&resetctrl 22 &resetctrl 25>;
> +		reset-names = "host", "device";
> +	};
> +
> +	ehci@101c0000 {
> +		compatible = "generic-ehci";
> +		reg = <0x101c0000 0x1000>;
> +
> +		phys = <&usbphy>;
> +		phy-names = "usb";
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <18>;
> +	};
> +};
> -- 
> 2.7.4
> 
