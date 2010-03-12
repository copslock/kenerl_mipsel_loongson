Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 17:46:13 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18528 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492250Ab0CLQqJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Mar 2010 17:46:09 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b9a6fd70003>; Fri, 12 Mar 2010 08:46:15 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 12 Mar 2010 08:36:15 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 12 Mar 2010 08:36:15 -0800
Message-ID: <4B9A6D79.6040306@caviumnetworks.com>
Date:   Fri, 12 Mar 2010 08:36:09 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: tracing: Optimize the implementation
References: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com> <20100312085053.GB6364@alpha.franken.de>
In-Reply-To: <20100312085053.GB6364@alpha.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2010 16:36:15.0105 (UTC) FILETIME=[2215AF10:01CAC202]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/12/2010 12:50 AM, Thomas Bogendoerfer wrote:
> On Fri, Mar 12, 2010 at 02:07:37AM +0800, Wu Zhangjin wrote:
>> +/*
>> + * If the Instruction Pointer is in module space (0xc0000000), return ture;
>> + * otherwise, it is in kernel space (0x80000000), return false.
>> + */
>> +#define in_module(ip) (unlikely((ip)&  0x40000000))
>> +
>
> looks broken for 64bit, but maybe this is a 32bit only feature...
>

I initially thought the same thing.  However for 64-bit kernels linked 
in ckseg0 it is still true.  If we use the -msym32 optimization, we are 
forced to be in the ckseg space, so for most cases it works.

David Daney.
