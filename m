Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 20:40:46 +0200 (CEST)
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43788 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027861AbcELSkochSJK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 20:40:44 +0200
Received: from us02secmta2.synopsys.com (us02secmta2.synopsys.com [10.12.235.98])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4522610C0E82;
        Thu, 12 May 2016 11:40:36 -0700 (PDT)
Received: from us02secmta2.internal.synopsys.com (us02secmta2.internal.synopsys.com [127.0.0.1])
        by us02secmta2.internal.synopsys.com (Service) with ESMTP id 2A4C955F13;
        Thu, 12 May 2016 11:40:36 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by us02secmta2.internal.synopsys.com (Service) with ESMTP id C81D455F02;
        Thu, 12 May 2016 11:40:35 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id A056B152;
        Thu, 12 May 2016 11:40:35 -0700 (PDT)
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 238E9136;
        Thu, 12 May 2016 11:40:34 -0700 (PDT)
Received: from US01WEHTC1.internal.synopsys.com (10.12.239.235) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Thu, 12 May 2016 11:40:33 -0700
Received: from [10.9.139.177] (10.9.139.177) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Thu, 12 May 2016 11:40:28 -0700
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
To:     Christian Lamparter <chunkeey@googlemail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <4231696.iL6nGs74X8@debian64> <7745292.ZB3149zIk7@debian64>
 <2924514.Pic5Z1NUsc@wuerfel> <2856271.3aAGK3LarU@debian64>
From:   John Youn <John.Youn@synopsys.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "John.Youn@synopsys.com" <John.Youn@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <5734CE1C.8070208@synopsys.com>
Date:   Thu, 12 May 2016 11:40:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <2856271.3aAGK3LarU@debian64>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.9.139.177]
Return-Path: <John.Youn@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53414
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

On 5/12/2016 6:30 AM, Christian Lamparter wrote:
> On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
>> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
>>>>>> Detecting the endianess of the
>>>>>> device is probably the best future-proof solution, but it's also
>>>>>> considerably more work to do in the driver, and comes with a
>>>>>> tiny runtime overhead.
>>>>>
>>>>> The runtime overhead is probably non-measurable compared with the cost
>>>>> of the actual MMIOs.
>>>>
>>>> Right. The code size increase is probably measurable (but still small),
>>>> the runtime overhead is not.
>>>
>>> Ok, so no rebuts or complains have been posted.
>>>
>>> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
>>> and it works: 
>>>
>>> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
>>>
>>> So, how do we go from here? There is are two small issues with the
>>> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
>>> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
>>>
>>> Arnd, can you please respin and post it (cc'd stable as well)?
>>> So this is can be picked up? Or what's your plan?
>>
>> (I just realized my reply was stuck in my outbox, so the patch
>> went out first)
>>
>> If I recall correctly, the rough consensus was to go with your longer
>> patch in the future (fixed up for the comments that BenH and
>> I sent), and I'd suggest basing it on top of a fixed version of
>> my patch.
> Well, but it comes with the "overhead"! So this was just as I said:
> "Let's look at it and see if it's any good"... And I think it isn't
> since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
> archs etc...

I slightly prefer the more general patch for future kernel versions.
The overhead will probably be negligible, but we can perform some
testing to make sure.

Can you resubmit with all gathered feedback?

>  
>> Felipe just had another idea, to change the endianess of the dwc2
>> block by setting a registers (if that exists). That would indeed
>> be preferable, then we can just revert the broken change that
>> went into 4.4 and backport that fix instead.
> Just a quick reply. I have the docs for the thing. There's something
> like that in GAHBCFG at Bit 24... BUT it only switches the endiannes
> for the DMA descriptors (which is not always used, there are devices
> with PIO only)! It doesn't deal with the MMIO access at all. 

That's correct. It only affects descriptor endianness for DMA
descriptor mode of operation.

Regards,
John
