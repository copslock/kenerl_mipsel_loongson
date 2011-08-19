Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 19:10:42 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8239 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491816Ab1HSRKd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 19:10:33 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e4e994a0000>; Fri, 19 Aug 2011 10:11:38 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 19 Aug 2011 10:10:29 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 19 Aug 2011 10:10:28 -0700
Message-ID: <4E4E9902.10304@cavium.com>
Date:   Fri, 19 Aug 2011 10:10:26 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     guenter.roeck@ericsson.com
CC:     Jason Kwon <jason.kwon@ericsson.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Problems booting 3.0.3 kernel on Octeon CN58XX board
References: <4E4DA9DA.60305@ericsson.com>  <4E4E9036.9000802@cavium.com> <1313773248.3235.87.camel@groeck-laptop>
In-Reply-To: <1313773248.3235.87.camel@groeck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2011 17:10:28.0587 (UTC) FILETIME=[E4ECEBB0:01CC5E92]
X-archive-position: 30919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14578

On 08/19/2011 10:00 AM, Guenter Roeck wrote:
> On Fri, 2011-08-19 at 12:32 -0400, David Daney wrote:
>> On 08/18/2011 05:10 PM, Jason Kwon wrote:
>>> Attempting to boot a 3.0.3 kernel on a CN58XX board produced the
>>> following oops:
>>>
>>> CPU 4 Unable to handle kernel paging request at virtual address
>>> 0000000001c00000, epc == ffffffff811aa9f4, ra == ffffffff811aaa98
>>> Oops[#1]:
>>> Cpu 4
>>> $ 0 : 0000000000000000 0000000010008ce0 ffffffff821d2b80 0000000001c00000
>>> $ 4 : 0000000001c00038 000000000000017c 0000000000080000 0000000000080072
>>> $ 8 : 0000000000000008 0000000000000002 0000000000000003 a800000002284520
>>> $12 : 0000000000000002 ffffffff8186ee80 ffffffffffffff80 0000000000000030
>>> $16 : 0000000000080072 0000000000000001 0000000001bfa8f0 0000000001bfa928
>>> $20 : a800000003aff8f0 00000000000f0000 ffffffff8186ee80 ffffffff821d2a80
>>> $24 : 0000000000000001 0000000000000038
>>> $28 : a80000041fc48000 a80000041fc4bd90 fffffffffffffffc ffffffff811aaa98
>>> Hi : 0000000000000000
>>> Lo : 0000000000000000
>>> epc : ffffffff811aa9f4 setup_per_zone_wmarks+0x19c/0x2d8
>>> Not tainted
>>> ra : ffffffff811aaa98 setup_per_zone_wmarks+0x240/0x2d8
>>> Status: 10008ce2 KX SX UX KERNEL EXL
>>> Cause : 40808408
>>> BadVA : 0000000001c00000
>>> PrId : 000d0301 (Cavium Octeon+)
>>> Modules linked in:
>>> Process swapper (pid: 1, threadinfo=a80000041fc48000,
>>> task=a80000041fc44038, tls=0000000000000000)
>>> Stack : 0000000000000000 000000000006f75d ffffffff8186eec0 0000000000000001
>>> 0000000000000547 ffffffff81825598 ffffffff81a80000 ffffffff818b3e68
>>> ffffffff818a40ac 0000000000000000 ffffffff81a80000 0000000000000000
>>> 0000000000000000 0000000000000000 0000000000000000 ffffffff818a40f0
>>> ffffffff81a80000 ffffffff81100438 ffffffff818b4198 ffffffff818b3e68
>>> ffffffff818b46c8 0000000000000000 0000000000000000 ffffffff818721d0
>>> 0000000000000000 0000000000000000 0000000000000000 ffffffff81109bb0
>>> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>> 0000000000000000 0000000000000000 0000000000000000 ffffffff818720f8
>>> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>> ...
>>> Call Trace:
>>> [<ffffffff811aa9f4>] setup_per_zone_wmarks+0x19c/0x2d8
>>> [<ffffffff818a40f0>] init_per_zone_wmark_min+0x44/0xe0
>>> [<ffffffff81100438>] do_one_initcall+0x38/0x160
>>> [<ffffffff818721d0>] kernel_init+0xd8/0x178
>>> [<ffffffff81109bb0>] kernel_thread_helper+0x10/0x18
>>>
>>
>> It appears to be related to use of physical memory above the 16GB
>> barrier.  You could try reducing the amount of memory allocated to the
>> kernel by passing 'mem=1700M' on the kernel command line.
>>
>
> Hi David,
>
> are you sure ?
>
> This is what I see with our own boards (not the reference design board):
>
> Works:
>
> Linux version 3.0.3-423-gfa07d39 (groeck@rbos-pc-13) (gcc version 4.4.1
> (Debian 4.4.1-1) ) #2 SMP PREEMPT Thu Aug 18 14:09:53 PDT 2011
> [ ... ]
> CPU revision is: 000d030b (Cavium Octeon+)
> Checking for the multiply/shift bug... no.
> Checking for the daddiu bug... no.
> Determined physical RAM map:
>   memory: 00000000001fa000 @ 000000000160b000 (usable)
>   memory: 000000000e400000 @ 0000000001900000 (usable)
>   memory: 00000000d0000000 @ 0000000020000000 (usable)
>   memory: 000000000ffff000 @ 00000000f0001000 (usable)
>   memory: 0000000010000000 @ 0000000410000000 (usable)
>
> Crashes:
>
> Linux version 3.0.3-423-gfa07d39 (groeck@rbos-pc-13) (gcc version 4.4.1
> (Debian 4.4.1-1) ) #2 SMP PREEMPT Thu Aug 18 14:09:53 PDT 2011
> [ ... ]
> CPU revision is: 000d0003 (Cavium Octeon)
> Checking for the multiply/shift bug... no.
> Checking for the daddiu bug... no.
> Determined physical RAM map:
>   memory: 00000000001fa000 @ 000000000160b000 (usable)
>   memory: 000000000e400000 @ 0000000001900000 (usable)
>   memory: 0000000060000000 @ 0000000020000000 (usable)
>   memory: 0000000010000000 @ 0000000410000000 (usable)
>
> The memory at 0000000410000000 is there for both CPUs, yet the crash is
> only seen on the board with CN38xx. From a SW perspective, only
> difference besides the CPU type is that the working board has more
> memory.
>

That's right, I normally run on boards with 4GB of memory so I was not 
seeing it.  When I reduce the memory to 2GB, I can see it on most boards.

Sometimes (but not always) I see this:
.
.
.
Movable zone start PFN for each node
early_node_map[5] active PFN ranges
     0: 0x0000056a -> 0x00000578
     0: 0x000005c0 -> 0x00001fc0
     0: 0x00002080 -> 0x00003f80
     0: 0x00008000 -> 0x00020000
     0: 0x00104000 -> 0x00104900
   Normal zone: 2808 pages exceeds realsize 2304

^^^^^^^^^ Is a warning message indicating that something is not right in 
the memory initialization, which is exactly where things are going wrong.

I am retesting on the HEAD and trying to figure out where it is going wrong.

David Daney
