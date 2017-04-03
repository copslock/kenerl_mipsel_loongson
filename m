Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Apr 2017 12:20:24 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:60156 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991359AbdDCKUO1ctgr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Apr 2017 12:20:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 03 Apr 2017 12:20:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
In-Reply-To: <48f7f4ee-b8e3-0096-ddea-2fbe0b399b40@cogentembedded.com>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net>
 <48f7f4ee-b8e3-0096-ddea-2fbe0b399b40@cogentembedded.com>
Message-ID: <cf809000718514ba612b4f7b477586a9@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi,

Le 2017-04-03 11:57, Sergei Shtylyov a écrit :
> Hello!
> 
> On 4/2/2017 11:42 PM, Paul Cercueil wrote:
> 
>> For a description of the pinctrl devicetree node, please read
>> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>> 
>> For a description of the gpio devicetree nodes, please read
>> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> [...]
> 
>> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi 
>> b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> index 3e1587f1f77a..9c23c877fc34 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> @@ -55,6 +55,67 @@
>>  		clock-names = "rtc";
>>  	};
>> 
>> +	pinctrl: ingenic-pinctrl@10010000 {
> 
>    The node name should be generic, so please rename it to something
> like "pin-controller@..."

OK.

>> +		compatible = "ingenic,jz4740-pinctrl";
>> +		reg = <0x10010000 0x400>;
>> +
>> +		gpa: gpio-controller@0 {
> 
>    The name should be just "gpio@0", according to ePAPR and its
> successor spec. Although, using the <unit-address> without the "reg"
> prop isn't allowed either...

ePAPR says: "If the node has no reg property, the unit-address may be
omitted if the node name alone differentiates the node from other nodes 
at
the same level in the tree."

I could use 'gpio@bank-a', it is allowed by the spec. Or do you prefer 
'gpio@0'?

> MBR, Sergei

I'll wait from some feedback on the other patches then send a v5.

Thanks,
-Paul
