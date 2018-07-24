Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 07:27:44 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:15586 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990509AbeGXF1lcvWaw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 07:27:41 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id ED13347E22;
        Tue, 24 Jul 2018 07:27:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id cTtrY1KQ3Gqr; Tue, 24 Jul 2018 07:27:34 +0200 (CEST)
Subject: Re: [PATCH 3/4] net: lantiq: Add Lantiq / Intel vrx200 Ethernet
 driver
To:     Paul Burton <paul.burton@mips.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-4-hauke@hauke-m.de>
 <20180724003443.y2fcakalxmwwkqab@pburton-laptop>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <ad8e5cf7-2304-35ce-6229-39d31fcf3e15@hauke-m.de>
Date:   Tue, 24 Jul 2018 07:27:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180724003443.y2fcakalxmwwkqab@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65071
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

Hi Paul,

On 07/24/2018 02:34 AM, Paul Burton wrote:
> Hi Hauke,
> 
> On Sat, Jul 21, 2018 at 09:13:57PM +0200, Hauke Mehrtens wrote:
>> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
>> index e0af39b33e28..c704312ef7d5 100644
>> --- a/arch/mips/lantiq/xway/sysctrl.c
>> +++ b/arch/mips/lantiq/xway/sysctrl.c
>> @@ -536,7 +536,7 @@ void __init ltq_soc_init(void)
>>  		clkdev_add_pmu(NULL, "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
>>  
>>  		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
>> -		clkdev_add_pmu("1e108000.eth", NULL, 0, 0,
>> +		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0,
>>  				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
>>  				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
>>  				PMU_PPE_QSB | PMU_PPE_TOP);
> 
> Is this intentional?

Yes

> Why is it needed? Was the old address wrong? Does it change anything
> functionally?

The Ethernet driver is newly added in these patches, this entry was not
used before.
This has to match the device name and the device name is now named
1e10b308.eth because this only uses the register range of the pmac and
not of the complete switch core, this is different to the old driver
used in OpenWrt.

The lantiq clock code should really be converted to the common clock
framework so we can define this in device tree and do not need this code
any more.
I am planning to do this, but want to wait till the xrx500 clk code from
these patches is in mainline:
https://www.linux-mips.org/archives/linux-mips/2018-06/msg00092.html
There are already some more recent versions available internally.

> If it is needed it seems like a separate change - unless there's some
> reason it's tied to adding this driver?
> 
> Should this really apply only to the lantiq,vr9 case or also to the
> similar lantiq,grx390 & lantiq,ar10 paths?

The AR10 has a similar switch core, but I haven't tested this device
with this Ethernet driver, but there is a good chance it works out of
the box when the sysctrl.c gets adapted and the correct device tree is
provided.
I do not know exactly what the grx390 SoC is, this is probably some
uncommon name for one of the Lantiq / Intel SoCs, I have to look this up.

> 
> Whatever the answers to these questions it would be good to include them
> in the commit message.

I will update the commit massage for the v2.

Hauke
