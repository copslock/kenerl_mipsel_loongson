Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 21:05:33 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6988 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491137Ab1ASUF1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 21:05:27 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3744350000>; Wed, 19 Jan 2011 12:06:13 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 19 Jan 2011 12:05:24 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 19 Jan 2011 12:05:24 -0800
Message-ID: <4D3743FF.1080201@caviumnetworks.com>
Date:   Wed, 19 Jan 2011 12:05:19 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Optimize TLB handlers for Octeon CPUs
References: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com> <1293502077-9196-3-git-send-email-ddaney@caviumnetworks.com> <AANLkTinZZ2TziwkiBfhqV-3-VfXwU+EPx3OHsnTRVChT@mail.gmail.com> <4D373E5B.5010303@caviumnetworks.com> <AANLkTi=aZSwQCVudjZrUoOZYGJscER8R3vOsRcgadw-_@mail.gmail.com>
In-Reply-To: <AANLkTi=aZSwQCVudjZrUoOZYGJscER8R3vOsRcgadw-_@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2011 20:05:24.0650 (UTC) FILETIME=[357E08A0:01CBB814]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/19/2011 11:46 AM, Jonas Gorski wrote:
> On 19 January 2011 20:41, David Daney<ddaney@caviumnetworks.com>  wrote:
>> On 01/19/2011 11:35 AM, Jonas Gorski wrote:
>>>
>>> On 28/12/2010, David Daney<ddaney@caviumnetworks.com>    wrote:
>>>>
>>>> +#if defined(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE)&&    \
>>>> +    CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE>    0
>>>> (...)
>>>> +#else
>>>> +static bool scratchpad_available(void)
>>>> +{
>>>> +       return false;
>>>> +}
>>>> +static int scratchpad_offset(int i)
>>>> +{
>>>> +       BUG();
>>>> +}
>>>> +#endif
>>>
>>> This seems to have broken the build for any non-octeon mips build:
>>>
>>>    CC      arch/mips/mm/tlbex.o
>>> cc1: warnings being treated as errors
>>> arch/mips/mm/tlbex.c: In function 'scratchpad_offset':
>>> arch/mips/mm/tlbex.c:112: error: no return statement in function
>>> returning non-void
>>>
>>
>> Can you tell me which version of GCC you are using?
>>
>> I tested it with gcc-4.5.x, BUG() may have problems if builtin_unreachable
>> is not available.
>
> That's probably it, It's a 4.3.3 (with code sourcery extensions, the
> OpenWrt default one).
>

It is a bug in GCC-4.3.  The proper fix is to add 'return 0;' after that 
BUG() statement.

I will prepare a patch.

David Daney
