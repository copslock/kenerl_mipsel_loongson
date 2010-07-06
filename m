Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2010 09:03:28 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:39086 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491055Ab0GFHDY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jul 2010 09:03:24 +0200
Received: by pwj5 with SMTP id 5so2839215pwj.36
        for <linux-mips@linux-mips.org>; Tue, 06 Jul 2010 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qRty7QUsP42pB43eScq4ySEzkHU6eaySXlJ08L00miU=;
        b=Wsj+oVgoN23FFK3QxwQKJadAWZUpptuVHqZR7OHw89NsFuiFg8eFLQAy0ezavJsRkB
         OI/rftYZaxTQNFgRytChExN89xalNaKQZbHphEtsG26W2MDtvivJbNPRrm8JSEy4Bd1h
         0YwQ0unhlBHj3tjaJ43n3rxX9yBVIwiFhw2Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=qBGmf5OuJIwO0LL7msWEXqpdvCltiIESWuYVyKH12mT4HTehIg1Cb2qmURet0DhvfA
         Ah4m9rUtzgj87WZwXEUcjVz+CkpVvrWM9yKzb4NC0vve9JmBfvq5uBVQpkc4BxwwmVop
         szkXlkauBocW13XsowJqLv+EhRNIwGQ49OmR8=
MIME-Version: 1.0
Received: by 10.142.132.12 with SMTP id f12mr4865274wfd.223.1278399794295; 
        Tue, 06 Jul 2010 00:03:14 -0700 (PDT)
Received: by 10.143.155.15 with HTTP; Tue, 6 Jul 2010 00:03:14 -0700 (PDT)
In-Reply-To: <AANLkTinW5hF4W5hRUsOcXxTqE2O0EfLbyo5nVSI5870o@mail.gmail.com>
References: <AANLkTinW5hF4W5hRUsOcXxTqE2O0EfLbyo5nVSI5870o@mail.gmail.com>
Date:   Tue, 6 Jul 2010 09:03:14 +0200
X-Google-Sender-Auth: 3kwB-1jsL218XIoefNYkxOrnloE
Message-ID: <AANLkTintwKWlLbJOZ7vk1dnGZ_9nLBp6pFZYf3A8Hr63@mail.gmail.com>
Subject: Re: why I receive tlb exception in kernel mode?
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 6, 2010 at 08:24, loody <miloody@gmail.com> wrote:
> If I remember correctly, the copy_from_user will translate the user
> mode address by tlb.

Indeed...

> But why my usb kernel driver will get user mode address as 0x00000070?
>
> below is the kernel dump happen on my machine.
>
> ehci ehci.0: irq status c028 Async Periodic IAA FLR
> ehci ehci.0: itd_submit 1 urb 87f20c00 ep1in len 98304, 32 pkts 1
> uframes [87b48280]
> ehci ehci.0: schedule devp 1 ep1in-iso period 1 start 46.0
> ehci ehci.0: itd_submit 1 urb 87f20800 ep1in len 98304, 32 pkts 1
> uframes [87b48280]
> ehci ehci.0: irq status c009 Async Periodic FLR INT
> CPU 0 Unable to handle kernel paging request at virtual address
                         ^^^^^^
... but this one is about a bad kernel address.

> 00000070, epc == c045e8ac, ra == c045e610

Looks like an offset in a struct pointed to by a NULL pointer.

> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 00000001 00000000 00000007
> $ 4   : a7b430bc 00000000 00000000 00000000
> $ 8   : 00000008 00000002 8c005400 0000000f
> $12   : ffffffff 00000008 70000000 ffffffee
> $16   : 00000000 00000001 a7b45100 40000000
> $20   : 20000000 00000000 87387ec0 87387e00
> $24   : ffffffb1 ffffffc1
> $28   : 87268000 872697a0 87b460bc c045e610
> Hi    : 00000178
> Lo    : 00000000
> epc   : c045e8ac ehci_work+0x640/0xcb4 [ehci_hcd]
>    Not tainted
> ra    : c045e610 ehci_work+0x3a4/0xcb4 [ehci_hcd]
> Status: 11000002    KERNEL EXL
> Cause : 40801408
> BadVA : 00000070
> PrId  : 00019655 (MIPS 24Kc)
> Modules linked in: uvcvideo ehci_hcd usbcore
> Process a.out (pid: 823, threadinfo=87268000, task=8726a530, tls=00000000)
> Stack : 87387ec0 00000050 35303830 61376234 00000000 00000000 00000178 0000003a
>        000000bc 87387efc 000001d6 0000002f 00000800 a7b430bc 00000000 00000004
>        87387ed0 0000c009 87387ec0 87387e00 00000000 00000002 ffffffff 00000001
>        00010039 c0465474 81102200 c0466e7c 87893300 87269818 20717269 74617473
>        63207375 20393030 6e797341 65502063 646f6972 46206369 4920524c 0000544e
>        ...
> Call Trace:
> [<c045e8ac>] ehci_work+0x640/0xcb4 [ehci_hcd]
> [<c0465474>] ehci_irq+0x108/0x524 [ehci_hcd]
> [<c020ee2c>] usb_hcd_irq+0x50/0xfc [usbcore]
> [<801687cc>] handle_IRQ_event+0x90/0x188
> [<8016a7a0>] handle_percpu_irq+0x54/0xbc
> [<80109f90>] irq_dispatch+0x40/0x6c
> [<8010040c>] ret_from_irq+0x0/0x4
> [<8013b88c>] __do_softirq+0x7c/0x164
> [<8013b9f0>] do_softirq+0x7c/0x84
> [<80109f98>] irq_dispatch+0x48/0x6c
> [<8010040c>] ret_from_irq+0x0/0x4
> [<80135d38>] vprintk+0x31c/0x458
> [<8010555c>] printk+0x24/0x30
> [<c0462e24>] ehci_urb_enqueue+0x5dc/0x13d8 [ehci_hcd]
> [<c02107b4>] usb_hcd_submit_urb+0x110/0xc5c [usbcore]
> [<c054b514>] uvc_init_video+0x258/0x494 [uvcvideo]
> [<c054a2d0>] uvc_v4l2_do_ioctl+0x8f0/0x12c0 [uvcvideo]
> [<802e5908>] video_usercopy+0x240/0x424
> [<801b2d9c>] vfs_ioctl+0xbc/0xcc
> [<801b2e40>] do_vfs_ioctl+0x94/0x7a0
> [<801b3594>] sys_ioctl+0x48/0xc0
> [<80102150>] stack_done+0x20/0x3c
>
>
> Code: 00061100  00e21021  24c30007 <8c440070> 00031900  00e31821
> 7ca24c00  00822023  ac640004
> Disabling lock debugging due to kernel taint
> Kernel panic - not syncing: Fatal exception in interrupt

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
