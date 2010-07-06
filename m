Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2010 08:24:26 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:39672 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491054Ab0GFGYW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jul 2010 08:24:22 +0200
Received: by gwaa18 with SMTP id a18so1076331gwa.36
        for <linux-mips@linux-mips.org>; Mon, 05 Jul 2010 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=zQ9U6FGa2Ir5q9NZ/ZYSa8vk8aBV1oqmBRUwzizLEXE=;
        b=hfhDFuamDUx5a3R454ScoTA6/HFBzYt7vx+oblpMVBHPLHaL9AfdgkHMj24GMF/25X
         wFBo1k+qwJe9XaJVOavAwghFSGtpJkHe5YNn4k2X4zV7+n31v5rN4Sm0NrASW95ytlO4
         HS4/ofEVTmuyx4yts5sgfTO5d8KNDIpZyLyAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=kGjvXXcQELPopZuvTm849bpgwd2yM2x5DElLAdmNri2GAuIEth86CJaVTYa2p4VuyN
         +P9iR4Ffe3ZJNAgnCQrtuOd1cm+blAwBromem+IDsUlqwjnmUdrEfn46Q/wCXG+CwEIX
         OUZwjm8GqK0PyCR1k0HpZRgoEWfR35tBfIlR8=
MIME-Version: 1.0
Received: by 10.90.63.13 with SMTP id l13mr4407323aga.57.1278397455534; Mon, 
        05 Jul 2010 23:24:15 -0700 (PDT)
Received: by 10.90.56.11 with HTTP; Mon, 5 Jul 2010 23:24:15 -0700 (PDT)
Date:   Tue, 6 Jul 2010 14:24:15 +0800
Message-ID: <AANLkTinW5hF4W5hRUsOcXxTqE2O0EfLbyo5nVSI5870o@mail.gmail.com>
Subject: why I receive tlb exception in kernel mode?
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
If I remember correctly, the copy_from_user will translate the user
mode address by tlb.
But why my usb kernel driver will get user mode address as 0x00000070?

below is the kernel dump happen on my machine.

ehci ehci.0: irq status c028 Async Periodic IAA FLR
ehci ehci.0: itd_submit 1 urb 87f20c00 ep1in len 98304, 32 pkts 1
uframes [87b48280]
ehci ehci.0: schedule devp 1 ep1in-iso period 1 start 46.0
ehci ehci.0: itd_submit 1 urb 87f20800 ep1in len 98304, 32 pkts 1
uframes [87b48280]
ehci ehci.0: irq status c009 Async Periodic FLR INT
CPU 0 Unable to handle kernel paging request at virtual address
00000070, epc == c045e8ac, ra == c045e610
Oops[#1]:
Cpu 0
$ 0   : 00000000 00000001 00000000 00000007
$ 4   : a7b430bc 00000000 00000000 00000000
$ 8   : 00000008 00000002 8c005400 0000000f
$12   : ffffffff 00000008 70000000 ffffffee
$16   : 00000000 00000001 a7b45100 40000000
$20   : 20000000 00000000 87387ec0 87387e00
$24   : ffffffb1 ffffffc1
$28   : 87268000 872697a0 87b460bc c045e610
Hi    : 00000178
Lo    : 00000000
epc   : c045e8ac ehci_work+0x640/0xcb4 [ehci_hcd]
    Not tainted
ra    : c045e610 ehci_work+0x3a4/0xcb4 [ehci_hcd]
Status: 11000002    KERNEL EXL
Cause : 40801408
BadVA : 00000070
PrId  : 00019655 (MIPS 24Kc)
Modules linked in: uvcvideo ehci_hcd usbcore
Process a.out (pid: 823, threadinfo=87268000, task=8726a530, tls=00000000)
Stack : 87387ec0 00000050 35303830 61376234 00000000 00000000 00000178 0000003a
        000000bc 87387efc 000001d6 0000002f 00000800 a7b430bc 00000000 00000004
        87387ed0 0000c009 87387ec0 87387e00 00000000 00000002 ffffffff 00000001
        00010039 c0465474 81102200 c0466e7c 87893300 87269818 20717269 74617473
        63207375 20393030 6e797341 65502063 646f6972 46206369 4920524c 0000544e
        ...
Call Trace:
[<c045e8ac>] ehci_work+0x640/0xcb4 [ehci_hcd]
[<c0465474>] ehci_irq+0x108/0x524 [ehci_hcd]
[<c020ee2c>] usb_hcd_irq+0x50/0xfc [usbcore]
[<801687cc>] handle_IRQ_event+0x90/0x188
[<8016a7a0>] handle_percpu_irq+0x54/0xbc
[<80109f90>] irq_dispatch+0x40/0x6c
[<8010040c>] ret_from_irq+0x0/0x4
[<8013b88c>] __do_softirq+0x7c/0x164
[<8013b9f0>] do_softirq+0x7c/0x84
[<80109f98>] irq_dispatch+0x48/0x6c
[<8010040c>] ret_from_irq+0x0/0x4
[<80135d38>] vprintk+0x31c/0x458
[<8010555c>] printk+0x24/0x30
[<c0462e24>] ehci_urb_enqueue+0x5dc/0x13d8 [ehci_hcd]
[<c02107b4>] usb_hcd_submit_urb+0x110/0xc5c [usbcore]
[<c054b514>] uvc_init_video+0x258/0x494 [uvcvideo]
[<c054a2d0>] uvc_v4l2_do_ioctl+0x8f0/0x12c0 [uvcvideo]
[<802e5908>] video_usercopy+0x240/0x424
[<801b2d9c>] vfs_ioctl+0xbc/0xcc
[<801b2e40>] do_vfs_ioctl+0x94/0x7a0
[<801b3594>] sys_ioctl+0x48/0xc0
[<80102150>] stack_done+0x20/0x3c


Code: 00061100  00e21021  24c30007 <8c440070> 00031900  00e31821
7ca24c00  00822023  ac640004
Disabling lock debugging due to kernel taint
Kernel panic - not syncing: Fatal exception in interrupt

appreciate your help,
miloody
