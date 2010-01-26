Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 19:46:45 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19147 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493411Ab0AZSqm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 19:46:42 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b5f38970000>; Tue, 26 Jan 2010 10:46:47 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 26 Jan 2010 10:45:41 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 26 Jan 2010 10:45:41 -0800
Message-ID: <4B5F3856.7020006@caviumnetworks.com>
Date:   Tue, 26 Jan 2010 10:45:42 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: fix dbdma ring destruction memory   debugcheck.
References: <1264527242-9214-1-git-send-email-manuel.lauss@gmail.com>    <4B5F29EE.1060906@caviumnetworks.com>   <f861ec6f1001260958n5d011155p8dd95346b6e57239@mail.gmail.com> <f861ec6f1001261040k79588f8fy9221ac31cdb3064b@mail.gmail.com>
In-Reply-To: <f861ec6f1001261040k79588f8fy9221ac31cdb3064b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2010 18:45:41.0429 (UTC) FILETIME=[C295EE50:01CA9EB7]
X-archive-position: 25688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16865

Manuel Lauss wrote:
> David,
> 
> On Tue, Jan 26, 2010 at 6:58 PM, Manuel Lauss
> <manuel.lauss@googlemail.com> wrote:
>> On Tue, Jan 26, 2010 at 6:44 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>>> Manuel Lauss wrote:
>>>> DBDMA descriptors need to be located at 32-byte aligned addresses;
>>>> however kmalloc rarely delivers such addresses.  The dbdma code
>>>> works around that by allocating 63 bytes and re-aligning the
>>>> descriptor base afterwards.  Hoewever when freeing memory it does
>>>> not account for this adjustment and trips the kfree debugcheck:
>>>>
>>> Correct me if I am wrong, but don't kmalloc et al. return blocks aligned
>>>  boundaries of the size rounded up the the next power of two?  So if you
>>> need 32-byte aligned addresses, just use a size value of 32 or greater.  You
>>> wouldn't have to add 63 and do masking and remember the membase value as you
>>> do in the patch.
>> The description is not completely correct (I suck a writing those):
>> It allocates a number
>> of descriptor entries (64 bytes each) specified by the driver in a single block:
>>
>>        desc_base = (u32)kmalloc(entries * sizeof(au1x_ddma_desc_t),
>>                                 GFP_KERNEL|GFP_DMA);
>>        if (desc_base == 0)
>>                return 0;
>>
>>        if (desc_base & 0x1f) {
>>
>> So far the 3 users I have (mmc, spi, audio) always return true on the above
>> check (2 descriptors for audio for instance).
> 
> ... but only if CONFIG_DEBUG_SLAB is enabled.

Oh no!  I make this assumption in my drivers.  If CONFIG_DEBUG_SLAB 
causes it to not be true... Bad news.

David Daney

> You are correct in that
> kmalloc() returns aligned blocks with a non-debug slab allocator and this
> fix becomes superfluous.   I'll try to confirm this with the other
> allocators and
> resend with a fixed description.
> 
> Thank you for the pointer!
>      Manuel Lauss
> 
