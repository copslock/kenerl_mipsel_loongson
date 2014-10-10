Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 15:31:53 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41093 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011068AbaJJNbvqtpBK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Oct 2014 15:31:51 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3DEA528087A;
        Fri, 10 Oct 2014 15:30:57 +0200 (CEST)
Received: from dicker-alter.lan (p548C9AAE.dip0.t-ipconnect.de [84.140.154.174])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 10 Oct 2014 15:30:57 +0200 (CEST)
Message-ID: <5437DFC4.3000808@openwrt.org>
Date:   Fri, 10 Oct 2014 15:31:48 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     linux-mips@linux-mips.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/2] DT: Add documentation for gpio-rt2880
References: <1412885241-12476-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1412885241-12476-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

hi linus, ralf

please ignore these 2 patches, i sent an old version. i will resend in
a bit with the 2nd gpio driver and the ARCH_REQUIRE_GPIOLIB patch added.

	John

On 09/10/2014 22:07, John Crispin wrote:
> Describe gpio-rt2880 binding.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org> Cc:
> linux-mips@linux-mips.org Cc: devicetree@vger.kernel.org Cc:
> linux-gpio@vger.kernel.org --- 
> .../devicetree/bindings/gpio/gpio-rt2880.txt       |   40
> ++++++++++++++++++++ 1 file changed, 40 insertions(+) create mode
> 100644 Documentation/devicetree/bindings/gpio/gpio-rt2880.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt
> b/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt new file
> mode 100644 index 0000000..b4acf02 --- /dev/null +++
> b/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt @@ -0,0
> +1,40 @@ +Ralink SoC GPIO controller bindings + +Required
> properties: +- compatible: +  - "ralink,rt2880-gpio" for Ralink
> controllers +- #gpio-cells : Should be two. +  - first cell is the
> pin number +  - second cell is used to specify optional parameters
> (unused) +- gpio-controller : Marks the device node as a GPIO
> controller +- reg : Physical base address and length of the
> controller's registers +- interrupt-parent: phandle to the INTC
> device node +- interrupts : Specify the INTC interrupt number +-
> ralink,num-gpios : Specify the number of GPIOs +-
> ralink,register-map : The register layout depends on the GPIO bank
> and actual +		SoC type. Register offsets need to be in this order. 
> +		[ INT, EDGE, RENA, FENA, DATA, DIR, POL, SET, RESET, TOGGLE ] + 
> +Optional properties: +- ralink,gpio-base : Specify the GPIO chips
> base number + +Example: + +	gpio0: gpio@600 { +		compatible =
> "ralink,rt5350-gpio", "ralink,rt2880-gpio"; + +		#gpio-cells =
> <2>; +		gpio-controller; + +		reg = <0x600 0x34>; + +
> interrupt-parent = <&intc>; +		interrupts = <6>; + +
> ralink,gpio-base = <0>; +		ralink,num-gpios = <24>; +
> ralink,register-map = [ 00 04 08 0c +				20 24 28 2c +				30 34 ]; 
> + +	};
> 
