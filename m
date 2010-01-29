Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 18:18:36 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:13774 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492734Ab0A2RSc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2010 18:18:32 +0100
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b63171f0000>; Fri, 29 Jan 2010 12:13:03 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 29 Jan 2010 12:18:30 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 29 Jan 2010 09:11:47 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 29 Jan 2010 09:11:47 -0800
Message-ID: <4B6316D2.1060006@caviumnetworks.com>
Date:   Fri, 29 Jan 2010 09:11:46 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com>
In-Reply-To: <20100129151220.GA3882@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2010 17:11:47.0820 (UTC) FILETIME=[23EEAAC0:01CAA106]
X-archive-position: 25739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19005

Guenter Roeck wrote:
> On Fri, Jan 29, 2010 at 08:24:07AM -0500, Ralf Baechle wrote:
>> On Thu, Jan 28, 2010 at 07:55:14AM -0800, Guenter Roeck wrote:
>>> I get the following kernel crash when running a 2.6.32.6 kernel on a bcm1480 cpu.
>>> It only happens if I configure a page size of 16k or 64k; 4k page size is fine.
>>>
>>> A similar problem was recently fixed for ppc. It turned out to be a problem in ppc
>>> specific memory management code, so that fix won't help here.
>>>
>>> Has anyone else seen this before ? Any idea where to start looking for the problem ?
>> Supposedly this was working for SB1.  I suggest you find an older kernel
>> version that works for your with 16k pages then use git bisect to find
>> the problem.
>>
> It used to work with 2.6.27.
> 
> However, bisect won't work, because the code in question (per cpu memory allocation) was
> completely rewritten since then.
> 
> The new percpu code tries to allocate memory just below VMALLOC_END. This works on sb1 for
> a page size of 4k, but not for a page size of 16k and 64k. The value of VMALLOC_END depends
> on the page size.
> 
> ppc had a similar problem. It had nothing to do with the new percpu memory allocation code,
> but with memory alocation close to VMALLOC_END. In other words, it was a day-one bug which
> was never noticed because allocating memory in that address space is highly unlikely.
> 
> I suspect the same is the case here. I could write some code for 2.6.27, to test the same
> memory allocation there, but I am quite sure the problem is going to show up there as well.
> 
> So first question would be: Has anyone successfully loaded a 64 bit mips kernel with 2.6.32 
> and a page size of 16k or 64k ? This would at least help me reducing the problem to sb1.
> 

Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and 
2.6.33-rc*.  I have not seen any crashes that can not be easily explained.

David Daney.
