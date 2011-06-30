Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2011 01:58:25 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15883 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491186Ab1F3X6M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jul 2011 01:58:12 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e0d0dd50000>; Thu, 30 Jun 2011 16:59:17 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 30 Jun 2011 16:58:09 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 30 Jun 2011 16:58:09 -0700
Message-ID: <4E0D0D8C.7000200@cavium.com>
Date:   Thu, 30 Jun 2011 16:58:04 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Close races in TLB modify handlers.
References: <1309473062-11041-1-git-send-email-david.daney@cavium.com> <alpine.LFD.2.00.1106302358550.29709@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1106302358550.29709@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2011 23:58:09.0598 (UTC) FILETIME=[902B7DE0:01CC3781]
X-archive-position: 30574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 144

On 06/30/2011 04:34 PM, Maciej W. Rozycki wrote:
> Hi David,
>
>> Page table entries are made invalid by writing a zero into the the PTE
>> slot in a page table.  This creates a race condition with the TLB
>> modify handlers when they are updating the PTE.
>>
>> CPU0                              CPU1
>>
>> Test for _PAGE_PRESENT
>> .                                 set to not _PAGE_PRESENT (zero)
>> Set to _PAGE_VALID
>>
>> So now the page not present value (zero) is suddenly valid and user
>> space programs have access to physical page zero.
>>
>> We close the race by putting the test for _PAGE_PRESENT and setting of
>> _PAGE_VALID into an atomic LL/SC section.  This requires more
>> registers than just K0 and K1 in the handlers, so we need to save some
>> registers to a save area and then restore them when we are done.
>
>   Hmm, good catch, but doesn't your change pessimise the UP case?

It may, It is really just a first version of the patch.  I am looking 
for feedback and testing.

> It looks
> to me like you save&  restore the scratch registers even though the race
> does not apply to UP (you can't interrupt a TLB handler, not at this
> stage).

That's right.  I will look at trying to generate the old code sequences 
for non-SMP.

Thanks,
David Daney
