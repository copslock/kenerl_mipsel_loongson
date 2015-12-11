Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 21:36:41 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:52300 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007521AbbLKUgh14diQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 21:36:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=0vT5+tMjCq1l5HV+calZrTpz7T85SPyfT+i0JE33oQo=;
        b=fDC1HsYaY68a+oxzIQwTGnkD3TNA7Bqz3jup2eNc7Gby1BFNs1Rp7dXkBSMNhjkRxds7DrXoTyF0NqFEZyHPfZWIOBlwhLbMWRAfPSJnDoBFmWJBZeOHmVB75jgzr4NRT009DJ7AFe9dQLbc31xsvpr3pwAFB8r4idL/9B1+137GJ/YOFGfdfjr0lZuIshXyaQGqn3NpGxLmOKK2ay7kwOFunCApUc1OjZOCuonixC/2zsPq9EqhXhooW2c7HNh2XJATGE/1jrrs/xJ6huuTxqbcjj0EuXRYQnlH/SISVfV6PKZn5CNCOIFX92SkgIHhEoErBtPK4wXeSRCK0r2GPA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:34773)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a7UQS-0000nR-9n (Exim); Fri, 11 Dec 2015 20:36:25 +0000
Subject: Re: [PATCH linux-next 1/2] power: Add brcm,bcm6358-power-controller
 device tree binding
To:     Rob Herring <robh@kernel.org>
References: <5668AB4F.7030100@simon.arlott.org.uk>
 <20151211025844.GA5251@rob-hp-laptop>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jogo@openwrt.org>, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566B33C3.3060809@simon.arlott.org.uk>
Date:   Fri, 11 Dec 2015 20:36:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20151211025844.GA5251@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On 11/12/15 02:58, Rob Herring wrote:
> On Wed, Dec 09, 2015 at 10:29:35PM +0000, Simon Arlott wrote:
>> The BCM6358 contains power domains controlled with a register. Power
>> domains are indexed by bits in the register. Power domain bits can be
>> interleaved with other status bits and clocks in the same register.
>> 
>> Newer SoCs with dedicated power domain registers are active low.
>> 
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
>> ---
>>  .../power/brcm,bcm6358-power-controller.txt        | 53 ++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
>> new file mode 100644
>> index 0000000..556c323
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/brcm,bcm6358-power-controller.txt
>> @@ -0,0 +1,53 @@
>> +Broadcom BCM6358 Power domain controller
>> +
>> +This binding uses the power domain bindings:
>> +        Documentation/devicetree/bindings/power/power_domain.txt
>> +
>> +The BCM6358 contains power domains controlled with a register. Power
>> +domains are indexed by bits in the register. Power domain bits can be
>> +interleaved with other status bits and clocks in the same register.
>> +
>> +Newer SoCs with dedicated power domain registers are active low.
>> +
>> +Required properties:
>> +- compatible:           Should be "brcm,bcm<soc>-power-controller", "brcm,bcm6358-power-controller"
>> +- #power-domain-cells:  Should be <1>.
>> +- regmap:               The register map phandle
>> +- offset:               Offset in the register map for the power domain register (in bytes)
>> +- power-domain-indices: The bits in the register used for power domains.
> 
> You should drop this and make the cell values be the register offsets.

I need to register every power domain in order to get the kernel to turn
off those that are unused. Even if I could enumerate all device tree
devices that reference the power-controller node, not all of them have
bindings to allow them to be specified in the device tree file.

I can't register all 32 bits because that won't work on the BCM6358 that
only has 1 power domain bit in the register and several clock bits. On
the BCM63268 there are power domain bits that have no device that I
don't want the kernel to disable (like the memory controller).

How should I determine which bits to register a power domain for?

	misc_iddq_ctrl: power-controller@1000184c {
		compatible = "brcm,bcm6358-power-controller";
		regmap = <&misc>;
		offset = <0x4c>;

		mask = <0x1043fff>;

		#power-domain-cells = <1>;
	};

or

	misc_iddq_ctrl: power-controller@1000184c {
		compatible = "brcm,bcm6358-power-controller";
		regmap = <&misc>;
		offset = <0x4c>;

		#address-cells = <1>;
		#size-cells = <0>;

		sar: power-controller@0 {
			reg = <0>;
			#power-domain-cells = <0>;
		};

		ipsec: power-controller@1 {
			reg = <1>;
			#power-domain-cells = <0>;
		};

		...
	};

or something else?

>> +- power-domain-names:   Should be a list of strings of power domain names
>> +                        indexed by the power domain indices.
> 
> This isn't really needed anyway.

If I remove this then I'll have to use the same node name for each
struct generic_pm_domain "name" field that I register, although these
names don't appear to be exported anywhere.

>> +
>> +Optional properties:
>> +- active-low:           Specify that the bits are active low.
> 
> This should be implied by the compatible property.

Ok, I'll create "brcm,bcm6358-power-controller" that's active high and
"brcm,bcm6328-power-controller" that's active low. This appear to be
the earliest chips that introduced or changed "iddq" register bits.

-- 
Simon Arlott
