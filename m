Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Sep 2015 13:11:17 +0200 (CEST)
Received: from arroyo.ext.ti.com ([192.94.94.40]:59299 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008006AbbI2LLPlrGLC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Sep 2015 13:11:15 +0200
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id t8TBAlGF008772;
        Tue, 29 Sep 2015 06:10:47 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id t8TBAkLo008111;
        Tue, 29 Sep 2015 06:10:46 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE72.ent.ti.com
 (128.247.5.109) with Microsoft SMTP Server id 14.3.224.2; Tue, 29 Sep 2015
 06:10:47 -0500
Received: from [172.24.190.79] (ileax41-snat.itg.ti.com [10.172.224.153])       by
 dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id t8TBAg3A007414;        Tue, 29 Sep
 2015 06:10:43 -0500
Subject: Re: [PATCH 0/4] MIPS: ath79: Add USB support on the TL-WR1043ND
To:     Arnd Bergmann <arnd@arndb.de>, Alban <albeu@free.fr>
References: <1441120994-31476-1-git-send-email-albeu@free.fr>
 <3589971.cbF7muh57v@wuerfel> <20150909161459.30cf580f@avionic-0020>
 <1734684.IINudhV2s6@wuerfel>
CC:     <linux-mips@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <560A71B2.8050606@ti.com>
Date:   Tue, 29 Sep 2015 16:40:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1734684.IINudhV2s6@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <kishon@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kishon@ti.com
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

On Wednesday 09 September 2015 07:51 PM, Arnd Bergmann wrote:
> On Wednesday 09 September 2015 16:14:59 Alban wrote:
>> On Mon, 07 Sep 2015 15:20:42 +0200
>> Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> On Tuesday 01 September 2015 17:23:10 Alban Bedel wrote:
>>>>
>>>> this serie add a driver for the USB phy on the ATH79 SoCs and enable the
>>>> USB port on the TL-WR1043ND. The phy controller is really trivial as it
>>>> only use reset lines.
>>>>
>>>
>>> Is this a common thing to have? If other PHY devices are like this, we
>>> could instead add a simple generic PHY driver that just asserts all
>>> its reset lines in the order as provided, rather than making this a
>>> hardware specific driver that ends up getting copied several times.
>>
>> I don't know how common it is. However I agree that a simple driver that
>> can start a clock and toggle a few GPIO and/or reset would make sense.
>>
>> However in the case of the ATH79 SoC some models have a reset line that
>> is misused to force the PHY in sleep mode. Sadly this extra reset must
>> be asserted for the PHY to work, so it wouldn't fit in such a generic
>> design.
>>
>> Still we could have such a generic driver and let the ATH79 driver
>> build on top of it. Honestly that's what I wanted to do, but getting
>> generic drivers with DT support accepted is not easy. That's why I went
>> with this driver, it is technically inferior but much easier to get
>> considered for merging.
> 
> Ok, fair enough. If we end up doing a more generic driver for this,
> we can still consider adding the compatible string there, potentially
> with some workaround for the sleep mode.

hmm, makes sense to have a generic PHY driver for PHY's which doesn't
have PHY registers to be programmed like a PHY driver which enables only
clocks, regulators, drives gpios etc.

Cheers
Kishon
