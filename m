Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 22:56:01 +0200 (CEST)
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:52783 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027122AbcELUz7VXFa6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 22:55:59 +0200
Received: from dc8secmta1.synopsys.com (dc8secmta1.synopsys.com [10.13.218.200])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9989824E0054;
        Thu, 12 May 2016 13:55:51 -0700 (PDT)
Received: from dc8secmta1.internal.synopsys.com (dc8secmta1.internal.synopsys.com [127.0.0.1])
        by dc8secmta1.internal.synopsys.com (Service) with ESMTP id 7DC7227113;
        Thu, 12 May 2016 13:55:51 -0700 (PDT)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
        by dc8secmta1.internal.synopsys.com (Service) with ESMTP id 2FA3A27102;
        Thu, 12 May 2016 13:55:51 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1761749D;
        Thu, 12 May 2016 13:55:51 -0700 (PDT)
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id CE88B497;
        Thu, 12 May 2016 13:55:49 -0700 (PDT)
Received: from US01WEHTC1.internal.synopsys.com (10.12.239.235) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Thu, 12 May 2016 13:55:49 -0700
Received: from [10.10.161.91] (10.10.161.91) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Thu, 12 May 2016 13:55:49 -0700
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
To:     Christian Lamparter <chunkeey@googlemail.com>,
        John Youn <John.Youn@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <2856271.3aAGK3LarU@debian64>
 <5734CE1C.8070208@synopsys.com> <50455529.fZie4vOnRh@debian64>
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
Message-ID: <5734EDD5.7030204@synopsys.com>
Date:   Thu, 12 May 2016 13:55:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <50455529.fZie4vOnRh@debian64>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.91]
Return-Path: <John.Youn@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53417
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

On 5/12/2016 1:39 PM, Christian Lamparter wrote:
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
> Yes I think I can do that. But I would really like to get the
> regression out of the way. So for that: I back Arnd's patch.
> It explains the problem much better and doesn't kill MIPS 
> like the revert I was doing in my initial post to the MLs.
> Also, another bonus: his patch is suited to port to stable.
> 
> The auto-detection approach is not that easy to get right,
> given all the stuff that's going on with BE8, LE4, ... So
> can we have your "blessing" for Arnd's patch for now? since
> that way, I can base my patch on top of his work about the
> issues of endiannes? (Just say: ACK :) )
> 

I agree Arnd's patch is best for stable. We can also apply it to
mainline until we get the autodection working as well.

Unless Felipe has objections.


> Arnd: do you have a version with the #ifdef lower/uppercase
> fix? Or should I give it a try (and fail in a different way ;) )
>  
>>>> Felipe just had another idea, to change the endianess of the dwc2
>>>> block by setting a registers (if that exists). That would indeed
>>>> be preferable, then we can just revert the broken change that
>>>> went into 4.4 and backport that fix instead.
>>> Just a quick reply. I have the docs for the thing. There's something
>>> like that in GAHBCFG at Bit 24... BUT it only switches the endiannes
>>> for the DMA descriptors (which is not always used, there are devices
>>> with PIO only)! It doesn't deal with the MMIO access at all. 
>>
>> That's correct. It only affects descriptor endianness for DMA
>> descriptor mode of operation.
> 
> Ok. The funny thing is that for the MyBook Live Duo this setting might
> be important since the PLB_DMA engine is not part of the DWC library...
> Instead it's from IBM and operates in: Big Endian :-D.
> 

Are you sure the controller is using descriptor DMA? It's more likely
using buffer DMA which this setting doesn't affect. DWC2 doesn't
support Descriptor DMA in device mode on mainline yet. If it's a host
then it might be.

Regards,
John
