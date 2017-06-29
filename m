Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 22:27:31 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:33192 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993982AbdF2U1XPn4f4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 22:27:23 +0200
Received: from [192.168.10.172] (p4FD97FB5.dip0.t-ipconnect.de [79.217.127.181])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 287341001DD;
        Thu, 29 Jun 2017 22:27:20 +0200 (CEST)
Subject: Re: [PATCH v5 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
To:     Rob Herring <robh@kernel.org>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-8-hauke@hauke-m.de>
 <20170623221224.fhfc6ezydd3uglfr@rob-hp-laptop>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <1171930b-769b-f0ea-778e-ddcd11b20775@hauke-m.de>
Date:   Thu, 29 Jun 2017 22:27:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170623221224.fhfc6ezydd3uglfr@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 06/24/2017 12:12 AM, Rob Herring wrote:
> On Wed, Jun 21, 2017 at 12:37:34AM +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> This adds the initial documentation for the RCU module (a MFD device
>> which provides USB PHYs, reset controllers and more).
>>
>> The RCU register range is used for multiple purposes. Mostly one device
>> uses one or multiple register exclusively, but for some registers some
>> bits are for one driver and some other bits are for a different driver.
>> With this patch all accesses to the RCU registers will go through
>> syscon.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 95 ++++++++++++++++++++++
>>  1 file changed, 95 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>> new file mode 100644
>> index 000000000000..9c875f4f3c90
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>> @@ -0,0 +1,95 @@
>> +Lantiq XWAY SoC RCU binding
>> +===========================
>> +
>> +This binding describes the RCU (reset controller unit) multifunction device,
>> +where each sub-device has it's own set of registers.
>> +
>> +The RCU register range is used for multiple purposes. Mostly one device
>> +uses one or multiple register exclusively, but for some registers some
>> +bits are for one driver and some other bits are for a different driver.
>> +With this patch all accesses to the RCU registers will go through
>> +syscon.
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties:
>> +- compatible	: The first and second values must be:
>> +		  "lantiq,xrx200-rcu", "simple-mfd", "syscon"
>> +- reg		: The address and length of the system control registers
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Example of the RCU bindings on a xRX200 SoC:
>> +	rcu0: rcu@203000 {
>> +		compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
>> +		reg = <0x203000 0x100>;
>> +		ranges = <0x0 0x203000 0x100>;
>> +		big-endian;
>> +
>> +		gphy0: gphy@0 {
> 
> unit address should match reg, so "phy@20"

done

>> +			compatible = "lantiq,xrx200a2x-gphy";
>> +			reg = <0x20 0x4>;
>> +
>> +			resets = <&reset0 31 30>, <&reset1 7 7>;
>> +			reset-names = "gphy", "gphy2";
>> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
>> +		};
>> +
>> +		gphy1: gphy@1 {
> 
> phy@68

done

>> +			compatible = "lantiq,xrx200a2x-gphy";
>> +			reg = <0x68 0x4>;
>> +
>> +			resets = <&reset0 29 28>, <&reset1 6 6>;
>> +			reset-names = "gphy", "gphy2";
>> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
>> +		};
>> +
>> +		reset0: reset-controller@0 {
> 
> ...@10

done


>> +			compatible = "lantiq,xrx200-reset";
>> +
>> +			offset-set = <0x10>;
>> +			offset-status = <0x14>;
> 
> reg = <0x10 8>;

done

>> +			#reset-cells = <2>;
>> +		};
>> +
>> +		reset1: reset-controller@1 {
>> +			compatible = "lantiq,xrx200-reset";
>> +
>> +			offset-set = <0x48>;
>> +			offset-status = <0x24>;
> 
> reg = <0x48 4>, <0x24 4>;

done

>> +			#reset-cells = <2>;
>> +		};
>> +
>> +		usb_phy0: usb2-phy@0 {
>> +			compatible = "lantiq,xrx200-usb2-phy";
>> +			status = "disabled";
>> +
>> +			regmap = <&rcu0>;
> 
> This should be dropped.

I will get this from the parent device now.

>> +			offset-phy = <0x18>;
>> +			offset-ana = <0x38>;
> 
> Use reg.

There is also one bit used to reset the DSL digital frontend at offset
0x38. This has nothing to do with USB.

>> +			resets = <&reset1 4 4>, <&reset0 4 4>;
>> +			reset-names = "phy", "ctrl";
>> +			#phy-cells = <0>;
>> +		};
>> +
>> +		usb_phy1: usb2-phy@1 {
>> +			compatible = "lantiq,xrx200-usb2-phy";
>> +			status = "disabled";
>> +
>> +			regmap = <&rcu0>;
> 
> Drop.

done

>> +			offset-phy = <0x34>;
>> +			offset-ana = <0x3C>;
> 
> Use reg.

There is also a bits to configure something with the DSL dying gasp at
offset 0x34. This has nothing to do with USB.

> 
>> +			resets = <&reset1 5 4>, <&reset0 4 4>;
>> +			reset-names = "phy", "ctrl";
>> +			#phy-cells = <0>;
>> +		};
>> +
>> +		reboot {
>> +			compatible = "syscon-reboot";
>> +
>> +			regmap = <&rcu0>;
> 
> Drop.

The syscon-reboot driver uses this code to get the regmap:
ctx->map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
This driver was not added by me.

>> +			offset = <0x10>;
>> +			mask = <0x40000000>;
>> +		};
>> +	};
>> +
>> -- 
>> 2.11.0
>>
