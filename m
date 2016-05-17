Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 01:51:01 +0200 (CEST)
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33102 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029809AbcEQXu7QjV4v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 01:50:59 +0200
Received: from dc8secmta2.synopsys.com (dc8secmta2.synopsys.com [10.13.218.202])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EC66810C09E3;
        Tue, 17 May 2016 16:50:50 -0700 (PDT)
Received: from dc8secmta2.internal.synopsys.com (dc8secmta2.internal.synopsys.com [127.0.0.1])
        by dc8secmta2.internal.synopsys.com (Service) with ESMTP id 76BB6A4112;
        Tue, 17 May 2016 16:50:50 -0700 (PDT)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
        by dc8secmta2.internal.synopsys.com (Service) with ESMTP id 1FC53A4102;
        Tue, 17 May 2016 16:50:50 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 08D2D3BB;
        Tue, 17 May 2016 16:50:50 -0700 (PDT)
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 543613B7;
        Tue, 17 May 2016 16:50:49 -0700 (PDT)
Received: from US01WEHTC1.internal.synopsys.com (10.12.239.236) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Tue, 17 May 2016 16:50:49 -0700
Received: from [10.9.139.134] (10.9.139.134) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Tue, 17 May 2016 16:50:48 -0700
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
To:     Christian Lamparter <chunkeey@googlemail.com>,
        John Youn <John.Youn@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <2856271.3aAGK3LarU@debian64>
 <5734CE1C.8070208@synopsys.com> <2920638.peXreEnG6d@debian64>
From:   John Youn <John.Youn@synopsys.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <573BAE58.1010206@synopsys.com>
Date:   Tue, 17 May 2016 16:50:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <2920638.peXreEnG6d@debian64>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.9.139.134]
Return-Path: <John.Youn@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: John.Youn@synopsys.com
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

On 5/14/2016 6:11 AM, Christian Lamparter wrote:
> On Thursday, May 12, 2016 11:40:28 AM John Youn wrote:
>> On 5/12/2016 6:30 AM, Christian Lamparter wrote:
>>> On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
>>>> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
>>>>>>>> Detecting the endianess of the
>>>>>>>> device is probably the best future-proof solution, but it's also
>>>>>>>> considerably more work to do in the driver, and comes with a
>>>>>>>> tiny runtime overhead.
>>>>>>>
>>>>>>> The runtime overhead is probably non-measurable compared with the cost
>>>>>>> of the actual MMIOs.
>>>>>>
>>>>>> Right. The code size increase is probably measurable (but still small),
>>>>>> the runtime overhead is not.
>>>>>
>>>>> Ok, so no rebuts or complains have been posted.
>>>>>
>>>>> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
>>>>> and it works: 
>>>>>
>>>>> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
>>>>>
>>>>> So, how do we go from here? There is are two small issues with the
>>>>> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
>>>>> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
>>>>>
>>>>> Arnd, can you please respin and post it (cc'd stable as well)?
>>>>> So this is can be picked up? Or what's your plan?
>>>>
>>>> (I just realized my reply was stuck in my outbox, so the patch
>>>> went out first)
>>>>
>>>> If I recall correctly, the rough consensus was to go with your longer
>>>> patch in the future (fixed up for the comments that BenH and
>>>> I sent), and I'd suggest basing it on top of a fixed version of
>>>> my patch.
>>> Well, but it comes with the "overhead"! So this was just as I said:
>>> "Let's look at it and see if it's any good"... And I think it isn't
>>> since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
>>> archs etc...
>>
>> I slightly prefer the more general patch for future kernel versions.
>> The overhead will probably be negligible, but we can perform some
>> testing to make sure.
>>
>> Can you resubmit with all gathered feedback?
> 
> Yes, here are the changes.
> 
> I've tested it on my MyBook Live Duo. The usbotg comes right up:
> [12610.540004] dwc2 4bff80000.usbotg: USB bus 1 deregistered
> [12612.513934] dwc2 4bff80000.usbotg: Specified GNPTXFDEP=1024 > 256
> [12612.518756] dwc2 4bff80000.usbotg: EPs: 3, shared fifos, 2042 entries in SPRAM
> [12612.530112] dwc2 4bff80000.usbotg: DWC OTG Controller
> [12612.533948] dwc2 4bff80000.usbotg: new USB bus registered, assigned bus number 1
> [12612.540083] dwc2 4bff80000.usbotg: irq 33, io mem 0x00000000
> 
> John: Can you run some perf test with it?
> 
> I've based this on:
> 
> commit 6ea2fffc9057a67df1994d85a7c085d899eaa25a
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Fri May 13 15:52:27 2016 +0200
> 
>     usb: dwc2: fix regression on big-endian PowerPC/ARM systems
> 
> so naturally, it needs to be applied first.
> Most of the conversion work was done by the attached
> coccinelle semantic patches. 
> 
> I had to edit the __bic32 and __orr32 helpers by hand.
> As well as some debugfs code and stuff in gadget.c.
> 

Thanks Christian.

I'll keep this in our internal tree and send it to Felipe later. This
causes a bunch of conflicts that I have to fix up and I should do a
bit of testing as well.

And since there is a patch that fixes the regression this is can wait.

Regards,
John
