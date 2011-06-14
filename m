Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 18:55:51 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11278 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab1FNQzr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2011 18:55:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4df792d30000>; Tue, 14 Jun 2011 09:56:51 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 14 Jun 2011 09:55:45 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 14 Jun 2011 09:55:45 -0700
Message-ID: <4DF7928C.7010004@caviumnetworks.com>
Date:   Tue, 14 Jun 2011 09:55:40 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Linux 2.6.39 on Cavium CN38xx
References: <1307653714.8271.130.camel@groeck-laptop> <4DF13E25.2060502@caviumnetworks.com> <20110609220614.GA13583@ericsson.com> <4DF15068.30906@caviumnetworks.com> <1307751642.8271.315.camel@groeck-laptop> <20110612164155.GA30615@ericsson.com> <4DF67CAE.1040804@caviumnetworks.com> <20110613215111.GA3484@ericsson.com> <20110614033403.GA4582@ericsson.com>
In-Reply-To: <20110614033403.GA4582@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2011 16:55:45.0606 (UTC) FILETIME=[E75D3660:01CC2AB3]
X-archive-position: 30377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11713

On 06/13/2011 08:34 PM, Guenter Roeck wrote:
> On Mon, Jun 13, 2011 at 05:51:11PM -0400, Guenter Roeck wrote:
> [ ... ]
>>>>
>>>> The actual interrupt causing trouble and spurious interrupts in my case is,
>>>> oddly enough, STATUSF_IP0. So far I have been unable to track down how that
>>>> is triggered; I don't see the bit being set set in C0_CAUSE anywhere.
>>>>
>>>> Are there any means to trigger an IP0 interrupt other than by writing STATUSF_IP0
>>>> into the C0_CAUSE register ?
>>>>
>>>
>>> No.  Nothing that I know of ever uses IP0 and IP1, so they should always
>>> be cleared.
>>>
>> Exactly what I figured, yet I still get those spurious interrupts if IP0 is enabled.
>> Something odd is definitely going on in my system.
>>
>> Besides the above, my hopefully final problem is that timer interrupts are only
>> received by CPU 0. Any idea what to look for to fix this problem ?
>>
> Found the problem. Apparently the BIOS resets CvmCtl[IPTI] to 0.

That is clearly erroneous behavior.  Although you can set any value, the 
HRM clearly states that 2..7 are the only legal values.

The Cavuim/Octeon u-boot just leave it at the default value of 7, and 
the kernel basically expects it to be 7, and never explicitly sets it.

We do set the IPPCI to 6 in the kernel, and for performance reasons, 
expect it to have a different value than IPTI.  IP{2,3,4} are basically 
reserved for use by the system interrupt controller, so really these 
things must be on one of IP{5,6,7}.

David Daney
