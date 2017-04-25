Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 08:56:32 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:44986 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992366AbdDYG4Yiaalv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Apr 2017 08:56:24 +0200
Received: from [192.168.0.100] (ip-109-45-3-139.web.vodafone.de [109.45.3.139])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 2A12510016A;
        Tue, 25 Apr 2017 08:56:20 +0200 (CEST)
Subject: Re: [PATCH 06/13] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
To:     Rob Herring <robh@kernel.org>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-7-hauke@hauke-m.de>
 <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <8742e3b3-4dc2-bc74-f607-00d96f74512c@hauke-m.de>
Date:   Tue, 25 Apr 2017 08:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57780
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



On 04/20/2017 04:48 PM, Rob Herring wrote:
> On Mon, Apr 17, 2017 at 09:29:35PM +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> This allows using the xbar driver on ARX300 based SoCs which require the
>> same xbar setup as the xRX200 chipsets because the xbar driver
>> initialization is not guarded by an xRX200 specific
>> of_machine_is_compatible condition anymore. Additionally the new driver
>> takes a syscon phandle to configure the XBAR endianness bits in RCU
>> (before this was done in arch/mips/lantiq/xway/reset.c and also
>> guarded by an xRX200 specific if-statement).
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 +++++
>>  MAINTAINERS                                        |   1 +
>>  arch/mips/lantiq/xway/reset.c                      |   4 -
>>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>>  drivers/soc/Makefile                               |   1 +
>>  drivers/soc/lantiq/Makefile                        |   1 +
>>  drivers/soc/lantiq/xbar.c                          | 100 +++++++++++++++++++++
>>  7 files changed, 125 insertions(+), 45 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>>  create mode 100644 drivers/soc/lantiq/Makefile
>>  create mode 100644 drivers/soc/lantiq/xbar.c
>>
>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>> new file mode 100644
>> index 000000000000..86e53ff3b0d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>> @@ -0,0 +1,22 @@
>> +Lantiq XWAY SoC XBAR binding
>> +============================
>> +
>> +
>> +-------------------------------------------------------------------------------
>> +Required properties:
>> +- compatible	: Should be "lantiq,xbar-xway"
> 
> This compatible is already in use so it is fine, but you should also 
> have per SoC compatible strings.

I will add a new SoC specific one.
What does per SoC device tree mean? Does it mean for the same silicon,
for the same silicon revision, for the same fusing of a silicon or for
the same marketing name?

I would like to make it per silicon or per silicon revision for the IP
cores which I know are different.

Hauke
