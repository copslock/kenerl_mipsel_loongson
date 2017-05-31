Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 22:11:17 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:42811 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993179AbdEaULKPjRC3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 22:11:10 +0200
Received: from [192.168.10.172] (p57978D77.dip0.t-ipconnect.de [87.151.141.119])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 4C92D100112;
        Wed, 31 May 2017 22:11:05 +0200 (CEST)
Subject: Re: [PATCH v3 05/16] watchdog: lantiq: add device tree binding
 documentation
To:     Rob Herring <robh@kernel.org>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-6-hauke@hauke-m.de>
 <20170531200021.ld54cecme4ekak4i@rob-hp-laptop>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <036b0b9c-a6dd-7d11-70a9-f7e8d4eb36be@hauke-m.de>
Date:   Wed, 31 May 2017 22:11:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170531200021.ld54cecme4ekak4i@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58107
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

On 05/31/2017 10:00 PM, Rob Herring wrote:
> On Sun, May 28, 2017 at 08:39:55PM +0200, Hauke Mehrtens wrote:
>> The binding was not documented before, add the documentation now.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>> new file mode 100644
>> index 000000000000..675c30e23b65
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>> @@ -0,0 +1,28 @@
>> +Lantiq WTD watchdog binding
>> +============================
>> +
>> +This describes the binding of the Lantiq watchdog driver.
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties:
>> +- compatible		: Should be one of
>> +				"lantiq,wdt"
>> +				"lantiq,wdt-xrx100"
>> +				"lantiq,wdt-falcon"
>> +
>> +Optional properties:
>> +- regmap		: A phandle to the RCU syscon
>> +- offset-status		: Offset of the reset cause register
>> +- mask-status		: Mask of the reset cause register value
> 
> These 2 should be implied by the compatible. But if already used in 
> upstream dts files, then it's okay.

This is new.
Should I hard code the offsets of the register and the actual bits
depending on the compatible string in the driver instead of configuring
it in the device tree?

>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Example for the watchdog on the xRX200 SoCs:
>> +		watchdog@803F0 {
> 
> Lowercase hex please.
> 
>> +			compatible = "lantiq,wdt-xrx200", "lantiq,wdt-xrx100";
> 
> Doesn't match the documentation.
> 
>> +			reg = <0x803F0 0x10>;
> 
> Lowercase hex please.
> 
>> +
>> +			regmap = <&rcu0>;
>> +			offset-status = <0x14>;
>> +			mask-status = <0x80000000>;
>> +		};
>> -- 
>> 2.11.0
>>
