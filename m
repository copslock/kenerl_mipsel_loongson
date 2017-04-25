Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 09:07:10 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:45021 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993868AbdDYHHDQEJtv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Apr 2017 09:07:03 +0200
Received: from [192.168.0.100] (ip-109-45-3-139.web.vodafone.de [109.45.3.139])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 0BB2010016A;
        Tue, 25 Apr 2017 09:06:59 +0200 (CEST)
Subject: Re: [PATCH 11/13] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To:     Rob Herring <robh@kernel.org>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-12-hauke@hauke-m.de>
 <20170420153606.fdhedc7ovvhc66qd@rob-hp-laptop>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <f15b576e-36bf-657d-97ff-99ea174c1d00@hauke-m.de>
Date:   Tue, 25 Apr 2017 09:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170420153606.fdhedc7ovvhc66qd@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57783
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



On 04/20/2017 05:36 PM, Rob Herring wrote:
> On Mon, Apr 17, 2017 at 09:29:40PM +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  59 ++++
>>  arch/mips/lantiq/xway/reset.c                      |  43 ---
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 325 +++++++++++++++++++++
>>  6 files changed, 405 insertions(+), 55 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>> new file mode 100644
>> index 000000000000..0ec9f790b6e0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>> @@ -0,0 +1,59 @@
>> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
>> +===========================================
>> +
>> +This binding describes the USB PHY hardware provided by the RCU module on the
>> +Lantiq XWAY SoCs.
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties (controller (parent) node):
>> +- compatible		: Should be one of
>> +				"lantiq,ase-rcu-usb2-phy"
>> +				"lantiq,danube-rcu-usb2-phy"
>> +				"lantiq,xrx100-rcu-usb2-phy"
>> +				"lantiq,xrx200-rcu-usb2-phy"
>> +				"lantiq,xrx300-rcu-usb2-phy"
> 
> The first x in xrx seems to be a wildcard. Don't use wildcards in 
> compatible strings.

Yes that is correct, I will replace it in the newly introduced
compatible strings with the full names without wild cards.

> 
>> +- lantiq,rcu-syscon	: A phandle to the RCU module and the offsets to the
>> +			  USB PHY configuration and USB MAC registers.
> 
> Same comment as gphy.
> 
>> +- address-cells		: should be 1
>> +- size-cells		: should be 0
>> +- phy-cells		: from the generic PHY bindings, must be 1
> 
> Missing the '#'
> 
>> +
>> +Optional properties (controller (parent) node):
>> +- vbus-gpio		: References a GPIO which enables VBUS all given USB
>> +			  ports.
> 
> -gpios is preferred form.
> 
>> +
>> +Required nodes		:  A sub-node is required for each USB PHY port.
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties (port (child) node):
> 
> Where's the sub nodes in the example?

Sorry, this was from an older version, I will update this.

> 
>> +- reg        	: The ID of the USB port, usually 0 or 1.
>> +- clocks	: References to the (PMU) "ctrl" and "phy" clk gates.
>> +- clock-names	: Must be one of the following:
>> +			"ctrl"
>> +			"phy"
>> +- resets	: References to the RCU USB configuration reset bits.
>> +- reset-names	: Must be one of the following:
>> +			"analog-config" (optional)
>> +			"statemachine-soft" (optional)
>> +
>> +Optional properties (port (child) node):
>> +- vbus-gpio	: References a GPIO which enables VBUS for the USB port.
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Example for the USB PHYs on an xRX200 SoC:
>> +	usb_phys0: rcu-usb2-phy@0 {
> 
> usb-phy@...
> 
>> +		compatible      = "lantiq,xrx200-rcu-usb2-phy";
> 
> Extra spaces.
> 
>> +		reg = <0>;
>> +
>> +		lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
>> +		clocks = <&pmu PMU_GATE_USB0_CTRL>,
>> +			 <&pmu PMU_GATE_USB0_PHY>;
>> +		clock-names = "ctrl", "phy";
>> +		vbus-gpios = <&gpio 32 GPIO_ACTIVE_HIGH>;
>> +		resets = <&rcu_reset1 4>, <&rcu_reset0 4>;
>> +		reset-names = "phy", "ctrl";
>> +		#phy-cells = <0>;
>> +	};
