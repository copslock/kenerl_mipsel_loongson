Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 21:02:11 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:44719 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993947AbdGGTB7BHgdc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 21:01:59 +0200
Received: from [192.168.0.100] (ip-109-47-0-109.web.vodafone.de [109.47.0.109])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 0B5FC10005E;
        Fri,  7 Jul 2017 21:01:49 +0200 (CEST)
Subject: Re: [PATCH v7 05/16] watchdog: lantiq: add device tree binding
 documentation
To:     Rob Herring <robh@kernel.org>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-6-hauke@hauke-m.de>
 <20170707140834.nugjw5jxkyzwrmzq@rob-hp-laptop>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <704b3b8b-3f33-3d51-82d7-a9515fc39742@hauke-m.de>
Date:   Fri, 7 Jul 2017 21:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170707140834.nugjw5jxkyzwrmzq@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59059
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



On 07/07/2017 04:08 PM, Rob Herring wrote:
> On Mon, Jul 03, 2017 at 12:40:40AM +0200, Hauke Mehrtens wrote:
>> The binding was not documented before, add the documentation now.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 24 ++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>> new file mode 100644
>> index 000000000000..c3967feebb6c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>> @@ -0,0 +1,24 @@
>> +Lantiq WTD watchdog binding
>> +============================
>> +
>> +This describes the binding of the Lantiq watchdog driver.
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties:
>> +- compatible		: Should be one of
>> +				"lantiq,wdt"
>> +				"lantiq,xrx100-wdt"
>> +				"lantiq,xrx200-wdt"
>> +				"lantiq,falcon-wdt"
>> +- lantiq,rcu		: A phandle to the RCU syscon (required for
>> +			  "lantiq,falcon-wdt", "lantiq,xrx200-wdt" and
>> +			  "lantiq,xrx100-wdt")
>> +
>> +-------------------------------------------------------------------------------
>> +Example for the watchdog on the xRX200 SoCs:
>> +		watchdog@803f0 {
>> +			compatible = "lantiq,xrx200-wdt", "lantiq,xrx100-wdt";
> 
> This is still mismatched. If the example is correct, then the compatible 
> list should be:
> 
> "lantiq,wdt"
> "lantiq,xrx100-wdt"
> "lantiq,xrx200-wdt", "lantiq,xrx100-wdt"
> "lantiq,falcon-wdt"
> 
> You can also remove "lantiq,xrx200-wdt" from the driver if you want as 
> "lantiq,xrx100-wdt" is good enough to match on.
> 
> Rob
> 
Ok thank you.

All the features that are supported by the wtd drivers use the same
register offsets on the xrx100 and xrx200 SoCs. I added the xrx200 only
if in the future we find some mismatch and I want to be able to use some
other code for this SoC.
In this case I would then list complete compatible line which should be
used for this SoC in the description of the compatible line, is that
correct?

I will update the patch, this makes sense to me.

Hauke
