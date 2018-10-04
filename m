Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 18:57:26 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:16450 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994077AbeJDQ5VyzStS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2018 18:57:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7F9E03F878;
        Thu,  4 Oct 2018 18:57:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cdbzGdF1Rw-1; Thu,  4 Oct 2018 18:57:20 +0200 (CEST)
Received: from localhost (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B49BF3F855;
        Thu,  4 Oct 2018 18:57:20 +0200 (CEST)
Date:   Thu, 4 Oct 2018 18:57:20 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Subject: Re: [PATCH] TC: Set DMA masks for devices
Message-ID: <20181004165720.GA2361@sx-9>
References: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Maciej,

> Fix a TURBOchannel support regression with commit 205e1b7f51e4 
> ("dma-mapping: warn when there is no coherent_dma_mask") that caused 
> coherent DMA allocations to produce a warning such as:
> 
> defxx: v1.11 2014/07/01  Lawrence V. Stefani and others
> tc1: DEFTA at MMIO addr = 0x1e900000, IRQ = 20, Hardware addr = 08-00-2b-a3-a3-29
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 dfx_dev_register+0x670/0x678
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.0-rc6 #2
> Stack : ffffffff8009ffc0 fffffffffffffec0 0000000000000000 ffffffff80647650
>         0000000000000000 0000000000000000 ffffffff806f5f80 ffffffffffffffff
>         0000000000000000 0000000000000000 0000000000000001 ffffffff8065d4e8
>         98000000031b6300 ffffffff80563478 ffffffff805685b0 ffffffffffffffff
>         0000000000000000 ffffffff805d6720 0000000000000204 ffffffff80388df8
>         0000000000000000 0000000000000009 ffffffff8053efd0 ffffffff806657d0
>         0000000000000000 ffffffff803177f8 0000000000000000 ffffffff806d0000
>         9800000003078000 980000000307b9e0 000000001e900000 ffffffff80067940
>         0000000000000000 ffffffff805d6720 0000000000000204 ffffffff80388df8
>         ffffffff805176c0 ffffffff8004dc78 0000000000000000 ffffffff80067940
>         ...
> Call Trace:
> [<ffffffff8004dc78>] show_stack+0xa0/0x130
> [<ffffffff80067940>] __warn+0x128/0x170
> ---[ end trace b1d1e094f67f3bb2 ]---
> 
> This is because the TURBOchannel bus driver fails to set the coherent 
> DMA mask for devices enumerated.

Interesting! This warning is also triggered by the PS2 OHCI driver. Robin
Murphy proposed the patch

https://lkml.org/lkml/2018/7/3/507

that relaxed it and a related warning. Half of the patch was merged in
commit d27fb99f62af7 while the other half (related to this warning) was
rejected by Christoph Hellwig. The PS2 OHCI triggers the following trace:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 62 at ./include/linux/dma-mapping.h:516 ohci_setup+0x41c/0x424 [ohci_hcd]
Modules linked in: ohci_ps2(+) ohci_hcd usbcore usb_common sd_mod iop iop_fio iop_module iop_memory sif
CPU: 0 PID: 62 Comm: modprobe Not tainted 4.16.0+ #1533
Stack : 00000000 00000000 80747392 00000037 81c6eb0c 804f32e7 80493b24 0000003e
        80743498 00000204 00000001 c01c0000 802a2fa0 10058c00 81ea5a68 804facc0
        00000000 00000000 80740000 00000007 00000000 00000060 00000000 00000000
        3a6d6d6f 00000000 0000005f 646f6d20 80000000 00000000 c01e66e8 c01e813c
        00000009 00000204 00000001 c01c0000 00000018 80278fe0 0007579f 00000001
        ...
Call Trace:
[<8001d6e4>] show_stack+0x74/0x104
[<800323a8>] __warn+0x118/0x120
[<8003246c>] warn_slowpath_null+0x44/0x58
[<c01e66e8>] ohci_setup+0x41c/0x424 [ohci_hcd]
[<c01f209c>] ohci_ps2_reset+0x30/0x70 [ohci_ps2]
[<c01a8aec>] usb_add_hcd+0x2d4/0x89c [usbcore]
[<c01f2360>] ohci_hcd_ps2_probe+0x284/0x2a4 [ohci_ps2]
[<802a8a74>] platform_drv_probe+0x2c/0x68
[<802a70b4>] driver_probe_device+0x22c/0x2e4
[<802a71f0>] __driver_attach+0x84/0xc8
[<802a53fc>] bus_for_each_dev+0x60/0x90
[<802a6580>] bus_add_driver+0x1b8/0x200
[<802a7980>] driver_register+0xc0/0x100
[<800106bc>] do_one_initcall+0x17c/0x190
[<800841f4>] do_init_module+0x74/0x1f0
[<80082f30>] load_module+0x1680/0x2044
[<80083adc>] SyS_finit_module+0xa0/0xb8
[<8002190c>] syscall_common+0x34/0x58
---[ end trace e71738b5fa6bf9aa ]---

> Set the regular and coherent DMA masks for TURBOchannel devices then, 
> observing that the bus protocol supports a 34-bit (16GiB) DMA address 
> space, by interpreting the value presented in the address cycle across 
> the 32 `ad' lines as a 32-bit word rather than byte address[1].  The 
> architectural size of the TURBOchannel DMA address space exceeds the 
> maximum amount of RAM any actual TURBOchannel system in existence may 
> have, hence both masks are the same.

A complication with the PS2 OHCI is that DMA addresses 0-0x200000 map to
0x1c000000-0x1c200000 as seen by the kernel. Robin suggested that the mask
might correspond to the effective addressing capability, which would be
DMA_BIT_MASK(21), but it does not seem to be entirely clear, since his
commit message said that

    A somewhat similar line of reasoning also applies at the other end for
    the mask check in dma_alloc_attrs() too - indeed, a device which cannot
    access anything other than its own local memory probably *shouldn't*
    have a valid mask for the general coherent DMA API.

A special circumstance here is the use of HCD_LOCAL_MEM that is a kind of
DMA bounce buffer. Are you using anything similar with your DEFTA driver?

Fredrik
