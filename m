Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 22:13:34 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:34520 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993179AbdEaUN1Be-y3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 May 2017 22:13:27 +0200
Received: from [192.168.10.172] (p57978D77.dip0.t-ipconnect.de [87.151.141.119])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 833F91001D5;
        Wed, 31 May 2017 22:13:25 +0200 (CEST)
Subject: Re: [PATCH v3 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
To:     Rob Herring <robh@kernel.org>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-8-hauke@hauke-m.de>
 <20170531200540.joludfqpy35yc5yy@rob-hp-laptop>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <6b8bb1cd-c090-435d-d150-d53edf04d2df@hauke-m.de>
Date:   Wed, 31 May 2017 22:13:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170531200540.joludfqpy35yc5yy@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58108
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

On 05/31/2017 10:05 PM, Rob Herring wrote:
> On Sun, May 28, 2017 at 08:39:57PM +0200, Hauke Mehrtens wrote:
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
>>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 97 ++++++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>> new file mode 100644
>> index 000000000000..3e2461262218
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>> @@ -0,0 +1,97 @@
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
>> +- compatible	: The first and second values must be: "simple-mfd", "syscon"
>> +- reg		: The address and length of the system control registers
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Example of the RCU bindings on a xRX200 SoC:
>> +	rcu0: rcu@203000 {
>> +		compatible = "lantiq,rcu-xrx200", "simple-mfd", "syscon";
>> +		reg = <0x203000 0x100>;
>> +		big-endian;
>> +
>> +		gphy0: gphy@0 {
> 
> Unit address without reg address is not valid.
> 
>> +			compatible = "lantiq,xrx200a2x-rcu-gphy";
>> +
>> +			regmap = <&rcu0>;
>> +			offset = <0x20>;
> 
> Does reg not work instead?

Is it ok to access some registers in this range with a reg = <0x20 0x04>
setting and some others through syscon? This specific register is only
used by this gphy, but the reset controller shares the register with
some other drivers like the watchdog driver.

>> +			resets = <&reset0 31 30>, <&reset1 7 7>;
>> +			reset-names = "gphy", "gphy2";
>> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
>> +		};
>> +
>> +		gphy1: gphy@1 {
>> +			compatible = "lantiq,xrx200a2x-rcu-gphy";
>> +
>> +			regmap = <&rcu0>;
>> +			offset = <0x68>;
>> +			resets = <&reset0 29 28>, <&reset1 6 6>;
>> +			reset-names = "gphy", "gphy2";
>> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
>> +		};
>> +
>> +		reset0: reset-controller@0 {
>> +			compatible = "lantiq,rcu-reset";
>> +
>> +			regmap = <&rcu0>;
>> +			offset-set = <0x10>;
>> +			offset-status = <0x14>;
>> +			#reset-cells = <2>;
>> +		};
>> +
>> +		reset1: reset-controller@1 {
>> +			compatible = "lantiq,rcu-reset";
>> +
>> +			regmap = <&rcu0>;
>> +			offset-set = <0x48>;
>> +			offset-status = <0x24>;
>> +			#reset-cells = <2>;
>> +		};
>> +
>> +		usb_phy0: usb2-phy@0 {
>> +			compatible = "lantiq,xrx200-rcu-usb2-phy";
>> +			status = "disabled";
>> +
>> +			regmap = <&rcu0>;
>> +			offset-phy = <0x18>;
>> +			offset-ana = <0x38>;
>> +			resets = <&reset1 4 4>, <&reset0 4 4>;
>> +			reset-names = "phy", "ctrl";
>> +			#phy-cells = <0>;
>> +		};
>> +
>> +		usb_phy1: usb2-phy@1 {
>> +			compatible = "lantiq,xrx200-rcu-usb2-phy";
>> +			status = "disabled";
>> +
>> +			regmap = <&rcu0>;
>> +			offset-phy = <0x34>;
>> +			offset-ana = <0x3C>;
>> +			resets = <&reset1 5 4>, <&reset0 4 4>;
>> +			reset-names = "phy", "ctrl";
>> +			#phy-cells = <0>;
>> +		};
>> +
>> +		reboot {
>> +			compatible = "syscon-reboot";
>> +
>> +			regmap = <&rcu0>;
>> +			offset = <0x10>;
>> +			mask = <0x40000000>;
>> +		};
>> +	};
>> +
>> -- 
>> 2.11.0
>>
