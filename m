Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 18:05:00 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6070 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab0BXRE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 18:04:56 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b855c400003>; Wed, 24 Feb 2010 09:05:04 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 24 Feb 2010 08:55:18 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 24 Feb 2010 08:55:17 -0800
Message-ID: <4B8559F0.6080908@caviumnetworks.com>
Date:   Wed, 24 Feb 2010 08:55:12 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Optimize spinlocks.
References: <1265311909-1679-1-git-send-email-ddaney@caviumnetworks.com> <20100224155336.GA5130@linux-mips.org>
In-Reply-To: <20100224155336.GA5130@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2010 16:55:17.0987 (UTC) FILETIME=[24AFA330:01CAB572]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/24/2010 07:53 AM, Ralf Baechle wrote:
> On Thu, Feb 04, 2010 at 11:31:49AM -0800, David Daney wrote:
>
>> The current locking mechanism uses a ll/sc sequence to release a
>> spinlock.  This is slower than a wmb() followed by a store to unlock.
>>
>> The branching forward to .subsection 2 on sc failure slows down the
>> contended case.  So we get rid of that part too.
>>
>> Since we are now working on naturally aligned u16 values, we can get
>> rid of a masking operation as the LHU already does the right thing.
>> The ANDI are reversed for better scheduling on multi-issue CPUs
>>
>> On a 12 CPU 750MHz Octeon cn5750 this patch improves ipv4 UDP packet
>> forwarding rates from 3.58*10^6 PPS to 3.99*10^6 PPS, or about 11%.
>
> And in your benchmarking patch you wrote:
>
>> 		spin_single	spin_multi
>> base		  106885	247941
>> spinlock_patch  75194		219465
>
> I did some benchmarking on an IP27 (180MHz, 2 CPU, needs LL/SC workaround):
>
> 		spin_single	spin_multi
> base		229341		3505690
> spinlock_patch	177847		3615326
>
> So about 22% speedup for spin_single but 3% slowdown for spin_multi.
>

It is possible that by choosing a better nudge_writes() implementation 
for R10K, that the 3% degradation could be erased.  Perhaps:

#define nudge_writes() do { } while (0)

Basically you want something that is fast, but that also forces the 
write to be globally visible as soon as possible.  Some processors have 
a prefetch instruction that does this.  On other processors a NOP is 
optimal as they don't combine writes in the write back buffer.

There is a wbflush() function that could potentially be used, but its 
implementation is too heavy on Octeon.


> Disabling the R10k LL/SC workaround btw. gives another 23% speedup for
> spin_single and marginal 0.3% for spin_multi; the latter may well be
> statistical noise.
>
>    Ralf
>
