Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OIr8Rw005202
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 11:53:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OIr82n005201
	for linux-mips-outgoing; Wed, 24 Jul 2002 11:53:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OIqxRw005190
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 11:52:59 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA02800;
	Wed, 24 Jul 2002 11:53:50 -0700
Message-ID: <3D3EF5BD.60802@mvista.com>
Date: Wed, 24 Jul 2002 11:45:17 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krishna Kondaka <krishna@Sanera.net>
CC: linux-mips@oss.sgi.com
Subject: Re: kernel BUG at slab.c:1073!
References: <200207241834.g6OIYDi28110@icarus.sanera.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.5 required=5.0 tests=PLING version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Krishna Kondaka wrote:
> Hi,
> 
> 	My system panics with the following message, when I do insmod of a
> 	driver.
> 	
> kernel BUG at slab.c:1073!
> Unable to handle kernel paging request at virtual address 00000000, epc == 
> 80131490, ra == 80131490
> Oops in fault.c:do_page_fault, line 172:
> $0 : 00000000 10009f00 0000001b 0000000a
> $4 : 80282ab0 00000001 00000001 00000000
> $8 : 802a2f42 b0060170 0000001b 0000000d
> $12: 00000000 0000001b 10009f00 0000000a
> $16: 00000000 000000f0 8fe40600 000000f0
> $20: 00000001 1002d948 00000060 8fdd4ec0
> $24: 802a2f27 ffffffff
> $28: 8f3b6000 8f3b7df8 00000008 80131490
> epc    : 0000000080131490
> Status : 10009f03
> Cause  : 1080000c
> 
> BadAddr: 000000008fdd4ec0Process insmod (pid: 67, stackpage=8f3b6000)
> Stack: 8022a860 8022a878 00000431 8fe40600 8fe40600 000000f0 ffffffff ffffffea
>        8f1b7000 80131988 0000003e 0000003c 00000059 80116110 00000000 00000000
>        00000000 c0021538 10009f01 ffffffea 00000008 c001f000 10033338 ffffffea
>        00000008 c001f000 10033338 ffffffea c0021b68 c0021b58 c00244b4 c00244a8
>        00000043 00000002 00000000 c001f000 80117678 80116f98 80101c00 00030002
>        80135e80 ...
> Call Trace: [<8022a860>] [<8022a878>] [<80131988>] [<80116110>] [<c0021538>] 
> [<c001f000>]
>  [<c001f000>] [<c0021b68>] [<c0021b58>] [<c00244b4>] [<c00244a8>] [<c001f000>]
>  [<80117678>] [<80116f98>] [<80101c00>] [<80135e80>] [<c0014000>] [<c001f060>]
>  [<8010d924>] [<c001f060>]
> 
> Code: 24a5a878  0c0457ca  24060431 <ae000000> 24020020  126200c4  24140001  
> 40056000  34a10001 
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> Rebooting in 5 seconds..swarm_linux_exit called...passing control back to CFE
> 
> slab.c : line 1072-1073 is        
> 
> if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
>                 BUG();
> 
> The driver being loaded is a small proprietary driver. The init routine of
> the driver is doing kmalloc() with GFP_KERNEL as the second argument. I know
> that I can fix my driver to use GFP_ATOMIC if running in interrupt context.
> 
> My question is why is the "insmod" command running in interrupt context?
> 

I don't think insmod should have interrupt context set.

Do you have preemptible kernel enabled?  This problem often happens if 
preemptible kernel is enabled and there is a missing interrupt path not pre-k 
ready.

Jun
