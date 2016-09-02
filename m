Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 14:47:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3320 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990522AbcIBMrguhr7Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 14:47:36 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5A339B4B39348;
        Fri,  2 Sep 2016 13:47:17 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 13:47:19 +0100
Subject: Re: [PATCH v2 3/4] hw_random: jz4780-rng: Add RNG node to jz4780.dtsi
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
References: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
 <1472321697-3094-4-git-send-email-prasannatsmkumar@gmail.com>
CC:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <ralf@linux-mips.org>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@free-electrons.com>, <harvey.hunt@imgtec.com>,
        <prarit@redhat.com>, <f.fainelli@gmail.com>,
        <joshua.henderson@microchip.com>, <narmstrong@baylibre.com>,
        <linus.walleij@linaro.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <4a7fb1cb-e0d4-31b7-7016-35adb63a659d@imgtec.com>
Date:   Fri, 2 Sep 2016 13:47:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472321697-3094-4-git-send-email-prasannatsmkumar@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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



On 27/08/16 19:14, PrasannaKumar Muralidharan wrote:
> This patch adds RNG node to jz4780.dtsi.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index b868b42..f11d139 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -36,7 +36,7 @@
>  
>  	cgu: jz4780-cgu@10000000 {
>  		compatible = "ingenic,jz4780-cgu";
> -		reg = <0x10000000 0x100>;
> +		reg = <0x10000000 0xD8>;

Hi PrasannaKumar,

I don't like this change. The RNG registers are documented as a part of
the same hardware block as the clock & power stuff which the CGU driver
handles, and indeed in the M200 SoC there is a power-related register
after the RNG registers. So shortening the range covered by the CGU
driver is not the right way to go.

Perhaps you could instead have the CGU driver make use of the syscon
infrastructure to expose a regmap which your RNG driver could pick up & use?

Thanks,
    Paul

>  
>  		clocks = <&ext>, <&rtc>;
>  		clock-names = "ext", "rtc";
> @@ -44,6 +44,11 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	rng: jz4780-rng@100000D8 {
> +		compatible = "ingenic,jz4780-rng";
> +		reg = <0x100000D8 0x8>;
> +	};
> +
>  	uart0: serial@10030000 {
>  		compatible = "ingenic,jz4780-uart";
>  		reg = <0x10030000 0x100>;
> 
