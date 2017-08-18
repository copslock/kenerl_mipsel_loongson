Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 16:11:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22359 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994924AbdHROLeuOsnK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 16:11:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3DAA66A24F066;
        Fri, 18 Aug 2017 15:11:22 +0100 (IST)
Received: from [192.168.154.107] (192.168.154.107) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 15:11:25 +0100
Subject: Re: [PATCH] MIPS: dts: ralink: Add Mediatek MT7628A SoC
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <1502814530-40604-1-git-send-email-harvey.hunt@imgtec.com>
 <20170817213426.34shgxwnjowcg4sk@rob-hp-laptop>
 <97c83648-3710-cb9a-a065-9fbe8dd1b734@imgtec.com>
 <CAL_Jsq+NZWkvibcL+CFWD8curFDKF2=bBzyCVsRyyiFOFwNBbg@mail.gmail.com>
From:   Harvey Hunt <Harvey.Hunt@imgtec.com>
Message-ID: <73251933-33bf-416d-cf2a-0fad0337a512@imgtec.com>
Date:   Fri, 18 Aug 2017 15:11:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+NZWkvibcL+CFWD8curFDKF2=bBzyCVsRyyiFOFwNBbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.107]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Harvey.Hunt@imgtec.com
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

Hi Rob,

On 18/08/17 15:04, Rob Herring wrote:
> On Fri, Aug 18, 2017 at 4:42 AM, Harvey Hunt <Harvey.Hunt@imgtec.com> wrote:
>> Hi Rob,
>>
>> Thanks for the review.
>>
>>
>> On 17/08/17 22:34, Rob Herring wrote:
>>>
>>> On Tue, Aug 15, 2017 at 05:28:50PM +0100, Harvey Hunt wrote:
>>>>
>>>> The MT7628A is the successor to the MT7620 and pin compatible with the
>>>> MT7688A, although the latter supports only a 1T1R antenna rather than
>>>> a 2T2R antenna.
> 
> [...]
> 
>>>> +               uartlite@c00 {
>>>
>>>
>>> serial@c00
>>>
>>> And so on. IOW, use standard, generic node names as defined in the DT
>>> spec.
>>
>>
>>
>> The clocks for the UARTs are using the device names "uartlite", "uart1" and
>> "uart2" (as defined in arch/mips/ralink/mt7620.c).
> 
> You can't add clocks to the DT? Looks like mt76x8 at least should be
> pretty easy with some fixed clocks.
> 
> Depending if backwards compatibility (old dtb working on new kernel)
> is a concern on these platforms, you could just change all the names
> both in the kernel and dts.

I don't think backwards compatibility will matter - the bootloaders I've 
come across don't ship DTBs with them and I don't think there are any 
ralink devices using the upstream MT7620 DT.

John might have some thoughts on backwards compat though.

> 
>> Changing the name of the DT nodes causes the serial driver to bail as it
>> can't find the clock for the device.
>>
>> arch/mips/boot/dts/ralink/mt7620a.dtsi is already using the uartlite name,
>> although it hasn't been documented...
> 
> Generally the kernel shouldn't care what the names are (though you can
> match by name, it's not widely used).
> 
> In any case, I guess fixing this can be done later.
> 
> Rob
> 

Shall I respin this patch with the earlier nodes (intc etc) renamed and 
then send a patch later to rename the serial ports in the DT and kernel 
(assuming there are no backwards compatibility issues)?

Thanks,

Harvey
