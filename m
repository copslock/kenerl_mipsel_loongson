Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 09:18:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20153 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008752AbcBOISGMUHBx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 09:18:06 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 3C193F0E177B2;
        Mon, 15 Feb 2016 08:17:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 15 Feb 2016 08:18:00 +0000
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 15 Feb
 2016 08:17:59 +0000
Subject: Re: [PATCH v6 2/3] MIPS: OCTEON: Rename legacy properties in internal
 device trees.
To:     David Daney <ddaney@caviumnetworks.com>
References: <1455207976-2262-1-git-send-email-matt.redfearn@imgtec.com>
 <1455207976-2262-2-git-send-email-matt.redfearn@imgtec.com>
 <56BCB7AE.2050901@gmail.com> <56BCBC90.6090805@imgtec.com>
 <56BCC64A.5040902@caviumnetworks.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <david.daney@cavium.com>,
        <aleksey.makarov@caviumnetworks.com>, <ulf.hansson@linaro.org>,
        <robh@kernel.org>, <ralf@linux-mips.org>,
        <linux-mmc@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <56C189B7.5020504@imgtec.com>
Date:   Mon, 15 Feb 2016 08:17:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <56BCC64A.5040902@caviumnetworks.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi David,

On 11/02/16 17:35, David Daney wrote:
> On 02/11/2016 08:53 AM, Matt Redfearn wrote:
>> Hi David,
>>
>> On 11/02/16 16:32, David Daney wrote:
>>> On 02/11/2016 08:26 AM, Matt Redfearn wrote:
>>>> Many OCTEON devices have been shipped in products with fixed DTBs. 
>>>> These
>>>> DTBS contain properties which are not compatible with newer kernels 
>>>> with
>>>> upstream drivers.
>>>> Therefore some mechanism is necessary to convert legacy naming into
>>>> upstream naming. In the first instance this is to support the 
>>>> OCTEON MMC
>>>> controller, which is in a later patch of this series.
>>>> This patch adds a octeon_handle_legacy_device_tree() function which is
>>>> always called from device_tree_init() to fix up the device tree so 
>>>> that
>>>> drivers need have no knowledge of the legacy naming or properties.
>>>>
>>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>>
>>> NAK...
>>>
>>> I already sent e-mail on this, but it crossed in flight.
>>
>> Yeah, unfortunate timing.
>>
>>>
>>> Basically, this patch is much more complex than the original code
>>> which was just a few lines to check the alternate "legacy" names.
>>
>> This code is functionally equivalent to the previous version, just
>> located in platform code rather than the driver itself.
>
> I know, one thing I really don't like about it, is that we are 
> modifying the kernel's view of the device that was passed in.  How 
> does that effect what is seen in /sys/firmware ?

Yes, that's true. The tree as visible in /sys/firmware is the modified 
version, because the modifications are performed on the DTB before it is 
unflattened and copied. This is what can be seen with the update:

# ls /sys/firmware/devicetree/base/soc\@0/mmc\@1180000002000/mmc-slot\@0/
bus-width  compatible  max-frequency  name  reg  voltage-ranges

>
> I would rather see code that calls mmc_of_parse(), and then, if the 
> two properties in question (bus-width, and max-frequency) have not 
> been filled in, attempt to read them with the legacy names using 
> of_property_read_u32()

OK, well we can go back to that...

>
> The implementation of mmc_of_parse() already contains support for 
> parsing legacy properties, so we could also add a couple more there, 
> which would be the simplest change of all.

Best to keep the support in the driver, I think.

>
>
>> In terms of LOC
>> it's not much different. Doing it this was does allow future flexibility
>> to change other bindings that are fixed in firmware without having to
>> support each set in the individual drivers.
>
> I think the controversy is limited to the MMC driver.  As far as I 
> know, we are in good shape with the bindings for the other drivers.
OK cool, well let's go back to that version, then.

Thanks,
Matt
>
>
>> Leaving this patch out will mean having to get any legacy bindings
>> accepted into each driver via their maintainer.
>> But for the moment we're just talking about the MMC driver - if this
>> patch is not accepted then the only way to support legacy devices is
>> with Ulf's signoff of handling both binding versions in the driver.
>>
> [...]
