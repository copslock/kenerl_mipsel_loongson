Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:38:32 +0100 (CET)
Received: from mx1.mailbox.org ([80.241.60.212]:53516 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990400AbeCLViZoMtxf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 22:38:25 +0100
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 54DED429B7;
        Mon, 12 Mar 2018 22:38:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id Kg4IRmNSCF7m; Mon, 12 Mar 2018 22:38:19 +0100 (CET)
Subject: Re: [PATCH 2/3] MIPS: lantiq: enable AHB Bus for USB
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        James Hogan <jhogan@kernel.org>
Cc:     ralf@linux-mips.org, john@phrozen.org, dev@kresin.me,
        linux-mips@linux-mips.org
References: <20180311174123.2578-1-hauke@hauke-m.de>
 <20180311174123.2578-2-hauke@hauke-m.de> <20180312211702.GB21642@saruman>
 <CAFBinCA3-AOVwxAofBtEAEK1+n=Txgf14KanEW6YYV+Rr6mvGA@mail.gmail.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <4aaf0fa8-ee7c-c01d-b1a2-73665df45f4e@hauke-m.de>
Date:   Mon, 12 Mar 2018 22:38:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAFBinCA3-AOVwxAofBtEAEK1+n=Txgf14KanEW6YYV+Rr6mvGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62928
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

Hi James,

On 03/12/2018 10:29 PM, Martin Blumenstingl wrote:
> Hi James,
> 
> On Mon, Mar 12, 2018 at 10:17 PM, James Hogan <jhogan@kernel.org> wrote:
>> Hi,
>>
>> On Sun, Mar 11, 2018 at 06:41:22PM +0100, Hauke Mehrtens wrote:
>>> From: Mathias Kresin <dev@kresin.me>
>>>
>>> On Danube and AR9 the USB core is connected to the AHB bus, hence we need
>>> to enable the AHB Bus as well.
>>>
>>> Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
>>> Signed-off-by: Mathias Kresin <dev@kresin.me>
>>
>> Hauke: I think this needs your SoB line too (same for other 2 patches
>> too).

Sorry, I forgot this before sending the patches, I send it now.

>>
>>> ---
>>>  arch/mips/lantiq/xway/sysctrl.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
>>> index f11f1dd10493..e0af39b33e28 100644
>>> --- a/arch/mips/lantiq/xway/sysctrl.c
>>> +++ b/arch/mips/lantiq/xway/sysctrl.c
>>> @@ -549,9 +549,9 @@ void __init ltq_soc_init(void)
>>>               clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
>>>                               ltq_ar9_fpi_hz(), CLOCK_250M);
>>>               clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>>> -             clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
>>> +             clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
>>
>> Checkpatch complains about these changed lines all being >80 columns,
>> though there are admittedly other violations nearby too.
> I suggest to keep it as suggested by Mathias/Hauke.
> our (Hauke and my) plan is to remove the whole file and replace it
> with a driver based on the common clock framework (in drivers/clk/)
> mid-term. in my opinion this is better than just fixing the 80 column
> limit

I agree with Martin. I think this code is better readable when we do not
break it, but I can also send an updated version of this patch.

Hauke
