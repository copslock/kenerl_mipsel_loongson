Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 09:01:08 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:53310 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993868AbdDYHA64DwIv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Apr 2017 09:00:58 +0200
Received: from [192.168.0.100] (ip-109-45-3-139.web.vodafone.de [109.45.3.139])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 6470C100306;
        Tue, 25 Apr 2017 09:00:56 +0200 (CEST)
Subject: Re: [PATCH 08/13] reset: Add a reset controller driver for the Lantiq
 XWAY based SoCs
To:     Rob Herring <robh@kernel.org>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-9-hauke@hauke-m.de>
 <20170420145405.7s3iapxggr5575d2@rob-hp-laptop>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <a9519140-a804-9888-3223-9a1446e25c52@hauke-m.de>
Date:   Tue, 25 Apr 2017 09:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170420145405.7s3iapxggr5575d2@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57781
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



On 04/20/2017 04:54 PM, Rob Herring wrote:
> On Mon, Apr 17, 2017 at 09:29:37PM +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> The reset controllers (on xRX200 and newer SoCs have two of them) are
>> provided by the RCU module. This was initially implemented as a simple
>> reset controller. However, the RCU module provides more functionality
>> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
>> The old reset controller driver implementation from
>> arch/mips/lantiq/xway/reset.c did not honor this fact.
>>
>> For some devices the request and the status bits are different.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  43 ++++
>>  arch/mips/lantiq/xway/reset.c                      |  68 ------
>>  drivers/reset/Kconfig                              |   6 +
>>  drivers/reset/Makefile                             |   1 +
>>  drivers/reset/reset-lantiq-rcu.c                   | 231 +++++++++++++++++++++
>>  5 files changed, 281 insertions(+), 68 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>>  create mode 100644 drivers/reset/reset-lantiq-rcu.c
>>
>> diff --git a/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>> new file mode 100644
>> index 000000000000..7f097d16bbb7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>> @@ -0,0 +1,43 @@
>> +Lantiq XWAY SoC RCU reset controller binding
>> +============================================
>> +
>> +This binding describes a reset-controller found on the RCU module on Lantiq
>> +XWAY SoCs.
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties (controller (parent) node):
>> +- compatible		: Should be "lantiq,rcu-reset"
>> +- lantiq,rcu-syscon	: A phandle to the RCU syscon, the reset register
>> +			  offset and the status register offset.
>> +- #reset-cells		: Specifies the number of cells needed to encode the
>> +			  reset line, should be 1.
>> +
>> +Optional properties:
>> +- reset-status		: The request status bit. For some bits the request bit
>> +			  and the status bit are different. This is depending
>> +			  on the SoC. If the reset-status bit does not match
>> +			  the reset-request bit, put the reset number into the
>> +			  reset-request property and the status bit at the same
>> +			  index into the reset-status property. If no
>> +			  reset-request bit is given here, the driver assume
>> +			  status and request bit are the same.
>> +- reset-request		: The reset request bit, to map it to the reset-status
>> +			  bit.
> 
> These should either be implied by SoC specific compatible or be made 
> part of the reset cells. In the latter case, you still need the SoC 
> specific compatible.

Currently the reset framework only supports a single reset cell to my
knowledge, but I haven't looked into the details, I could extend it to
make it support two.

The SoC which needs this has two reset control register sets and the
bits are specific for each register set. Would a specific compatible
string for each register set ok?

> 
>> +-------------------------------------------------------------------------------
>> +Example for the reset-controllers on the xRX200 SoCs:
>> +	rcu_reset0: rcu_reset {
>> +		compatible = "lantiq,rcu-reset";
>> +		lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
>> +		#reset-cells = <1>;
>> +		reset-request = <31>, <29>, <21>, <19>, <16>, <12>;
>> +		reset-status  = <30>, <28>, <16>, <25>, <5>,  <24>;
>> +	};
>> +
>> +	rcu_reset1: rcu_reset {
>> +		compatible = "lantiq,rcu-reset";
> 
> These 2 blocks are identical? Given different registers sizes, I'd say 
> not. So they should have different compatible strings.

I will remove the second one.

> 
>> +		lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
>> +		#reset-cells = <1>;
>> +	};
