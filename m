Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 19:01:44 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:41182 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491816Ab1HSRBj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2011 19:01:39 +0200
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id p7JH0NkT018169
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 19 Aug 2011 12:01:02 -0500
Received: from [155.53.96.104] (147.117.20.214) by
 eusaamw0711.eamcs.ericsson.se (147.117.20.179) with Microsoft SMTP Server id
 8.3.137.0; Fri, 19 Aug 2011 13:00:55 -0400
Subject: Re: Problems booting 3.0.3 kernel on Octeon CN58XX board
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: <guenter.roeck@ericsson.com>
To:     David Daney <david.daney@cavium.com>
CC:     Jason Kwon <jason.kwon@ericsson.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <4E4E9036.9000802@cavium.com>
References: <4E4DA9DA.60305@ericsson.com>  <4E4E9036.9000802@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Ericsson
Date:   Fri, 19 Aug 2011 10:00:48 -0700
Message-ID: <1313773248.3235.87.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14561

On Fri, 2011-08-19 at 12:32 -0400, David Daney wrote:
> On 08/18/2011 05:10 PM, Jason Kwon wrote:
> > Attempting to boot a 3.0.3 kernel on a CN58XX board produced the
> > following oops:
> >
> > CPU 4 Unable to handle kernel paging request at virtual address
> > 0000000001c00000, epc == ffffffff811aa9f4, ra == ffffffff811aaa98
> > Oops[#1]:
> > Cpu 4
> > $ 0 : 0000000000000000 0000000010008ce0 ffffffff821d2b80 0000000001c00000
> > $ 4 : 0000000001c00038 000000000000017c 0000000000080000 0000000000080072
> > $ 8 : 0000000000000008 0000000000000002 0000000000000003 a800000002284520
> > $12 : 0000000000000002 ffffffff8186ee80 ffffffffffffff80 0000000000000030
> > $16 : 0000000000080072 0000000000000001 0000000001bfa8f0 0000000001bfa928
> > $20 : a800000003aff8f0 00000000000f0000 ffffffff8186ee80 ffffffff821d2a80
> > $24 : 0000000000000001 0000000000000038
> > $28 : a80000041fc48000 a80000041fc4bd90 fffffffffffffffc ffffffff811aaa98
> > Hi : 0000000000000000
> > Lo : 0000000000000000
> > epc : ffffffff811aa9f4 setup_per_zone_wmarks+0x19c/0x2d8
> > Not tainted
> > ra : ffffffff811aaa98 setup_per_zone_wmarks+0x240/0x2d8
> > Status: 10008ce2 KX SX UX KERNEL EXL
> > Cause : 40808408
> > BadVA : 0000000001c00000
> > PrId : 000d0301 (Cavium Octeon+)
> > Modules linked in:
> > Process swapper (pid: 1, threadinfo=a80000041fc48000,
> > task=a80000041fc44038, tls=0000000000000000)
> > Stack : 0000000000000000 000000000006f75d ffffffff8186eec0 0000000000000001
> > 0000000000000547 ffffffff81825598 ffffffff81a80000 ffffffff818b3e68
> > ffffffff818a40ac 0000000000000000 ffffffff81a80000 0000000000000000
> > 0000000000000000 0000000000000000 0000000000000000 ffffffff818a40f0
> > ffffffff81a80000 ffffffff81100438 ffffffff818b4198 ffffffff818b3e68
> > ffffffff818b46c8 0000000000000000 0000000000000000 ffffffff818721d0
> > 0000000000000000 0000000000000000 0000000000000000 ffffffff81109bb0
> > 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000 0000000000000000 ffffffff818720f8
> > 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > ...
> > Call Trace:
> > [<ffffffff811aa9f4>] setup_per_zone_wmarks+0x19c/0x2d8
> > [<ffffffff818a40f0>] init_per_zone_wmark_min+0x44/0xe0
> > [<ffffffff81100438>] do_one_initcall+0x38/0x160
> > [<ffffffff818721d0>] kernel_init+0xd8/0x178
> > [<ffffffff81109bb0>] kernel_thread_helper+0x10/0x18
> >
> 
> It appears to be related to use of physical memory above the 16GB 
> barrier.  You could try reducing the amount of memory allocated to the 
> kernel by passing 'mem=1700M' on the kernel command line.
> 

Hi David,

are you sure ?

This is what I see with our own boards (not the reference design board):

Works:

Linux version 3.0.3-423-gfa07d39 (groeck@rbos-pc-13) (gcc version 4.4.1
(Debian 4.4.1-1) ) #2 SMP PREEMPT Thu Aug 18 14:09:53 PDT 2011
[ ... ]
CPU revision is: 000d030b (Cavium Octeon+)
Checking for the multiply/shift bug... no.
Checking for the daddiu bug... no.
Determined physical RAM map:
 memory: 00000000001fa000 @ 000000000160b000 (usable)
 memory: 000000000e400000 @ 0000000001900000 (usable)
 memory: 00000000d0000000 @ 0000000020000000 (usable)
 memory: 000000000ffff000 @ 00000000f0001000 (usable)
 memory: 0000000010000000 @ 0000000410000000 (usable)

Crashes:

Linux version 3.0.3-423-gfa07d39 (groeck@rbos-pc-13) (gcc version 4.4.1
(Debian 4.4.1-1) ) #2 SMP PREEMPT Thu Aug 18 14:09:53 PDT 2011
[ ... ]
CPU revision is: 000d0003 (Cavium Octeon)
Checking for the multiply/shift bug... no.
Checking for the daddiu bug... no.
Determined physical RAM map:
 memory: 00000000001fa000 @ 000000000160b000 (usable)
 memory: 000000000e400000 @ 0000000001900000 (usable)
 memory: 0000000060000000 @ 0000000020000000 (usable)
 memory: 0000000010000000 @ 0000000410000000 (usable)

The memory at 0000000410000000 is there for both CPUs, yet the crash is
only seen on the board with CN38xx. From a SW perspective, only
difference besides the CPU type is that the working board has more
memory.

Thanks,
Guenter
