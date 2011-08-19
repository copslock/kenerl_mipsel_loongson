Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 18:33:09 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6950 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab1HSQdC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 18:33:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e4e907c0002>; Fri, 19 Aug 2011 09:34:04 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 19 Aug 2011 09:32:55 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 19 Aug 2011 09:32:55 -0700
Message-ID: <4E4E9036.9000802@cavium.com>
Date:   Fri, 19 Aug 2011 09:32:54 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Jason Kwon <jason.kwon@ericsson.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Problems booting 3.0.3 kernel on Octeon CN58XX board
References: <4E4DA9DA.60305@ericsson.com>
In-Reply-To: <4E4DA9DA.60305@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2011 16:32:55.0750 (UTC) FILETIME=[A6214660:01CC5E8D]
X-archive-position: 30917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14491

On 08/18/2011 05:10 PM, Jason Kwon wrote:
> Attempting to boot a 3.0.3 kernel on a CN58XX board produced the
> following oops:
>
> CPU 4 Unable to handle kernel paging request at virtual address
> 0000000001c00000, epc == ffffffff811aa9f4, ra == ffffffff811aaa98
> Oops[#1]:
> Cpu 4
> $ 0 : 0000000000000000 0000000010008ce0 ffffffff821d2b80 0000000001c00000
> $ 4 : 0000000001c00038 000000000000017c 0000000000080000 0000000000080072
> $ 8 : 0000000000000008 0000000000000002 0000000000000003 a800000002284520
> $12 : 0000000000000002 ffffffff8186ee80 ffffffffffffff80 0000000000000030
> $16 : 0000000000080072 0000000000000001 0000000001bfa8f0 0000000001bfa928
> $20 : a800000003aff8f0 00000000000f0000 ffffffff8186ee80 ffffffff821d2a80
> $24 : 0000000000000001 0000000000000038
> $28 : a80000041fc48000 a80000041fc4bd90 fffffffffffffffc ffffffff811aaa98
> Hi : 0000000000000000
> Lo : 0000000000000000
> epc : ffffffff811aa9f4 setup_per_zone_wmarks+0x19c/0x2d8
> Not tainted
> ra : ffffffff811aaa98 setup_per_zone_wmarks+0x240/0x2d8
> Status: 10008ce2 KX SX UX KERNEL EXL
> Cause : 40808408
> BadVA : 0000000001c00000
> PrId : 000d0301 (Cavium Octeon+)
> Modules linked in:
> Process swapper (pid: 1, threadinfo=a80000041fc48000,
> task=a80000041fc44038, tls=0000000000000000)
> Stack : 0000000000000000 000000000006f75d ffffffff8186eec0 0000000000000001
> 0000000000000547 ffffffff81825598 ffffffff81a80000 ffffffff818b3e68
> ffffffff818a40ac 0000000000000000 ffffffff81a80000 0000000000000000
> 0000000000000000 0000000000000000 0000000000000000 ffffffff818a40f0
> ffffffff81a80000 ffffffff81100438 ffffffff818b4198 ffffffff818b3e68
> ffffffff818b46c8 0000000000000000 0000000000000000 ffffffff818721d0
> 0000000000000000 0000000000000000 0000000000000000 ffffffff81109bb0
> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000 0000000000000000 ffffffff818720f8
> 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> ...
> Call Trace:
> [<ffffffff811aa9f4>] setup_per_zone_wmarks+0x19c/0x2d8
> [<ffffffff818a40f0>] init_per_zone_wmark_min+0x44/0xe0
> [<ffffffff81100438>] do_one_initcall+0x38/0x160
> [<ffffffff818721d0>] kernel_init+0xd8/0x178
> [<ffffffff81109bb0>] kernel_thread_helper+0x10/0x18
>

It appears to be related to use of physical memory above the 16GB 
barrier.  You could try reducing the amount of memory allocated to the 
kernel by passing 'mem=1700M' on the kernel command line.

David Daney
