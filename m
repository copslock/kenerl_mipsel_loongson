Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 18:16:16 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2679 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903565Ab2C1QQK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2012 18:16:10 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f7339b10000>; Wed, 28 Mar 2012 09:17:53 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Mar 2012 09:15:45 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Mar 2012 09:15:44 -0700
Message-ID: <4F733945.6000804@cavium.com>
Date:   Wed, 28 Mar 2012 09:16:05 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com> <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com> <4F711E69.1080302@gmail.com> <4F7205F3.3000108@cavium.com> <4F7239A4.7070905@gmail.com> <4F723FDD.4080708@cavium.com> <4F731E69.8030907@gmail.com>
In-Reply-To: <4F731E69.8030907@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2012 16:15:44.0934 (UTC) FILETIME=[076BBC60:01CD0CFE]
X-archive-position: 32805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/28/2012 07:21 AM, Rob Herring wrote:
> On 03/27/2012 05:31 PM, David Daney wrote:
>> On 03/27/2012 03:05 PM, Rob Herring wrote:
>>> On 03/27/2012 01:24 PM, David Daney wrote:
>>>> On 03/26/2012 06:56 PM, Rob Herring wrote:
>>>>> On 03/26/2012 02:31 PM, David Daney wrote:
>>>>>> From: David Daney<david.daney@cavium.com>
>>>> [...]
>>>>>> +static bool octeon_irq_ciu_is_edge(unsigned int line, unsigned int
>>>>>> bit)
>>>>>> +{
>>>>>> +    bool edge = false;
>>>>>> +
>>>>>> +    if (line == 0)
>>>>>> +        switch (bit) {
>>>>>> +        case 48 ... 49: /* GMX DRP */
>>>>>> +        case 50: /* IPD_DRP */
>>>>>> +        case 52 ... 55: /* Timers */
>>>>>> +        case 58: /* MPI */
>>>>>> +            edge = true;
>>>>>> +            break;
>>>>>> +        default:
>>>>>> +            break;
>>>>>> +        }
>>>>>> +    else /* line == 1 */
>>>>>> +        switch (bit) {
>>>>>> +        case 47: /* PTP */
>>>>>> +            edge = true;
>>>>>> +            break;
>>>>>> +        default:
>>>>>> +            break;
>>>>>> +        }
>>>>>> +    return edge;
>>>>>
>>>>> Moving in the right direction, but I still don't get why this is not in
>>>>> the CIU binding as a 3rd cell?
>>>>
>>>> There are a several reasons, in no particular order they are:
>>>>
>>>> o There is no 3rd cell.  The bindings were discussed with Grant here:
>>>>     http://www.linux-mips.org/archives/linux-mips/2011-05/msg00355.html
>>>>
>>>
>>> Then add one.
>>
>> I can't.  The dtb is already programmed into the bootloader ROMs,
>> changing the kernel code will not change that.  It is fait accompli.
>>
>>>
>>>> o The edge/level thing cannot be changed, and the irq lines don't leave
>>>> the SOC, so hard coding it is possible.
>>>
>>> Right, but DT describes h/w connections and this is an aspect of the
>>> connection. This may be fixed for the SOC, but it's not fixed for the
>>> CIU (i.e. could change in future chips), right?
>>
>> In theory yes.  However:
>>
>> 1) The chip designers will not change it.
>>
>> 2) There will likely be no more designs with either CIU or CIU2, so we
>> know what all the different possibilities are today.
>>
>> When CIU3 is deployed, we will use the lessons we have learned to do
>> things the Right Way.
>>
>>>
>>> There's 2 reasons why you would not put this into DTS:
>>>
>>> - All irq lines' trigger type are the same, fixed and known.
>>> - You can read a register to tell you the trigger type.
>>>
>>> Even if it's not going to change ever, it's still worth putting into the
>>> DTS as it is well suited for holding that data and it is just data.
>>
>> Agreed that it could be in the DTS, and retrospect it probably should
>> have been put in the DTS, but it wasn't.  So I think what we have now is
>> a workable solution, and has the added attraction of working with
>> already deployed boards.
>
> Aren't you building in the dtb to the kernel?

No.  This seems like a bit of a disconnect in this discussion.  From the 
cover-letter:

o A device tree template is statically linked into the kernel image.
   Based on SOC type and board type, legacy configuration probing code
   is used to prune and patch the device tree template.

o New SOCs and boards will directly use a device tree passed by the
   bootloader.


>
> It could be argued it doesn't matter what you deployed without upstream
> review.

A moot point, as all the bindings were reviewed with Grant Likely 
precisely for the reason of minimizing surprises when merging upstream. 
  In the intervening months, we have found a few rough edges like this, 
but we cannot say that there was no upstream review.


> But as long as this contained then this one is fine with me.
> However, this needs to be understood for each binding as I'm sure there
> must be some blocks which will get reused.

Yes, there will be reuse.  There has in fact been reuse since the 
bindings were created, and for the most part things are going smoothly.


Thanks,
David Daney
