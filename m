Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 23:11:32 +0200 (CEST)
Received: from smtprelay.synopsys.com ([198.182.60.111]:44292 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028477AbcEIVLbFCRzF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 23:11:31 +0200
Received: from us02secmta2.synopsys.com (us02secmta2.synopsys.com [10.12.235.98])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9D02010C07CF;
        Mon,  9 May 2016 14:11:24 -0700 (PDT)
Received: from us02secmta2.internal.synopsys.com (us02secmta2.internal.synopsys.com [127.0.0.1])
        by us02secmta2.internal.synopsys.com (Service) with ESMTP id 904F155F15;
        Mon,  9 May 2016 14:11:24 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by us02secmta2.internal.synopsys.com (Service) with ESMTP id 46CAF55F13;
        Mon,  9 May 2016 14:11:24 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 278998A2;
        Mon,  9 May 2016 14:11:24 -0700 (PDT)
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 02B4989D;
        Mon,  9 May 2016 14:11:24 -0700 (PDT)
Received: from US01WEHTC1.internal.synopsys.com (10.12.239.235) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Mon, 9 May 2016 14:11:23 -0700
Received: from [10.10.161.101] (10.10.161.101) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Mon, 9 May 2016 14:11:23 -0700
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
To:     Arnd Bergmann <arnd@arndb.de>, John Youn <John.Youn@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <4162108.qmr2GZCaDN@wuerfel>
 <5730F198.2080105@synopsys.com> <18362907.sI27LBpJPE@wuerfel>
From:   John Youn <John.Youn@synopsys.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "benh@au1.ibm.com" <benh@au1.ibm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <5730FCFB.5050005@synopsys.com>
Date:   Mon, 9 May 2016 14:11:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <18362907.sI27LBpJPE@wuerfel>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.101]
Return-Path: <John.Youn@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53328
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

On 5/9/2016 1:39 PM, Arnd Bergmann wrote:
> On Monday 09 May 2016 13:22:48 John Youn wrote:
>> On 5/9/2016 3:36 AM, Arnd Bergmann wrote:
>>> On Monday 09 May 2016 10:23:22 Benjamin Herrenschmidt wrote:
>>>> On Sun, 2016-05-08 at 13:44 +0200, Christian Lamparter wrote:
>>>>> On Sunday, May 08, 2016 08:40:55 PM Benjamin Herrenschmidt wrote:
>>>>>>
>>>>>> On Sun, 2016-05-08 at 00:54 +0200, Christian Lamparter via Linuxppc-dev 
>>>>>> wrote:
>>>>>>>
>>>>>>> I've been looking in getting the MyBook Live Duo's USB OTG port
>>>>>>> to function. The SoC is a APM82181. Which has a PowerPC 464 core
>>>>>>> and related to the supported canyonlands architecture in
>>>>>>> arch/powerpc/.
>>>>>>>
>>>>>>> Currently in -next the dwc2 module doesn't load: 
>>>>>> Smells like the APM implementation is little endian. You might need to
>>>>>> use a flag to indicate what endian to use instead and set it
>>>>>> appropriately based on some DT properties.
>>>>> I tried. As per common-properties[0], I added little-endian; but it has no
>>>>> effect. I looked in dwc2_driver_probe and found no way of specifying the
>>>>> endian of the device. It all comes down to the dwc2_readl & dwc2_writel
>>>>> accessors. These - sadly - have been hardwired to use __raw_readl and
>>>>> __raw_writel. So, it's always "native-endian". While common-properties
>>>>> says little-endian should be preferred.
>>>>
>>>> Right, I meant, you should produce a patch adding a runtime test inside
>>>> those functions based on a device-tree property, a bit like we do for
>>>> some of the HCDs like OHCI, EHCI etc...
>>>>
>>>>
>>>
>>> The patch that caused the problem had multiple issues:
>>>
>>> - it broke big-endian ARM kernels: any machine that was working
>>>   correctly with a little-endian kernel is no longer using byteswaps
>>>   on big-endian kernels, which clearly breaks them.
>>
>>
>> I'm a bit confused about how this is supposed to work. My
>> understanding was that the readl() and writel() are defined as little
>> endian. So byte-swapping was performed if the architecture is big
>> endian. And the raw versions never swapped, always using the "native"
>> endianness.
>>
>> dwc2 is always treating the result of readl/writel as if it was read
>> in native endian. So it needs to read the registers in big-endian on
>> big-endian systems.
> 
> The hardware has no idea of what endianess the CPU uses at any
> given time, it's fixed by the SoC design, so there is no such
> thing as "native" endianess for a random IP block.
> 
> The readl/writel accessors accomodate for that by swapping the
> data on big-endian kernels, because most SoC designers tend to
> pick little-endian device registers by default.
> 
>> This was the premise on which this patch was made.
>>
>> So for big endian systems, isn't what we want is to read in big-endian
>> without any byteswapping to little-endian? But your saying this breaks
>> big-endian ARM systems as well. Am I missing something?
> 
> The systems are not a particular endianess, only the current state
> of the CPU is, and that may change independent of the way the
> hardware block got synthesized. We don't support swapping endianess
> at runtime in Linux, but the system normally doesn't care what we
> run.
> 
> The normal behavior is for the register contents to be read as
> little-endian, and then swapped on big-endian kernel builds to
> match what the kernel expects.
> 
> MIPS is a special case here, because the endianess of the CPU
> core is fixed in hardware (or using a strapping pin) and is often
> tied to the endianess of all the IP blocks. There are a couple
> of other architectures like this (e.g. ARM ixp4xx, but none of the
> modern ARM systems).

Ok thanks. What you're saying is clear now.

Is there a standard way to handle this? Must all drivers either check
some endianness configuration or do a runtime check?

Regards,
John
