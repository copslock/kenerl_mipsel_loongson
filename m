Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 08:01:08 +0200 (CEST)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34303 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007649AbbGNGBHXNTHo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 08:01:07 +0200
Received: by wgkl9 with SMTP id l9so42043034wgk.1;
        Mon, 13 Jul 2015 23:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JBYQMrLtDnwImZ586QwNw7OibgQEZzRqiL0O4UPdSqQ=;
        b=kc5M6At0X+zhfFXZ1h3nCTcspxeQBr8f5IWqROY0rjWDO/Z+cJxPDhE+KZyaGadMDz
         m+942Mpll5PSCz54R/9iOVms9urMcxQFYf9TJcn15AbK8T4GmnONscK12hTCmTszoBWH
         UKacb0LO4W5oQH8WwhsAmLsxRSIPdRrrzupM8pdZJVew3PAZFXa7LOS/VrFShgkKwHW3
         r0+n/4Zrm/wZpGj7pEwXtqu1saBT5BibXrAaTDAAeh+KPGeMN06vEgS6vqB3AWxnVpKT
         bq9G33BvATwusgjgB/oYEz4858EWpzx+8uFxZyBGsmff++t/Tk26CQAJkAfByCTeEvGc
         OW5w==
X-Received: by 10.180.77.200 with SMTP id u8mr1923291wiw.70.1436853661650;
 Mon, 13 Jul 2015 23:01:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.248.193 with HTTP; Mon, 13 Jul 2015 23:00:22 -0700 (PDT)
In-Reply-To: <20150713200715.113667554@linutronix.de>
References: <20150713200602.799079101@linutronix.de> <20150713200715.113667554@linutronix.de>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Tue, 14 Jul 2015 08:00:22 +0200
Message-ID: <CAOLZvyEEzWRU2RoMODPg13TMgi9jLGOUmp=AuBUA230KmgKODQ@mail.gmail.com>
Subject: Re: [patch 08/12] MIPS/alchemy: Remove pointless irqdisable/enable
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Jul 13, 2015 at 10:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> bcsr_csc_handler() is a cascading interrupt handler. It has a
> disable_irq_nosync()/enable_irq() pair around the generic_handle_irq()
> call. The value of this disable/enable is zero because its a complete
> noop:
>
> disable_irq_nosync() merily increments the disable count without
> actually masking the interrupt. enable_irq() soleley decrements the
> disable count without touching the interrupt chip. The interrupt
> cannot arrive again because the complete call chain runs with
> interrupts disabled.
>
> Remove it.

Is there another patch this one depends on?  The DB1300 board doesn't
boot (i.e. interrupts from the cpld aren't serviced) with this patch applied:
(irq 136 is the first serviced by the bcsr cpld):

irq 136: nobody cared (try booting with the "irqpoll" option)
CPU: 0 PID: 50 Comm: kworker/u2:2 Not tainted
4.1.0-db1xxx-12807-g1ced2d0-dirty #8
Workqueue: events_unbound async_run_entry_fn
Stack : 8090c3ec 8090c3c4 00000000 809d0000 00000000 80153668 80908814 00000032
          80a03828 8090c3c4 8093b2fc 8fb736e4 80908814 807e7f3c
00000000 8013f8dc
          00000000 00000000 8fb736e4 8fb73704 80908814 8013726c
00000000 00000002
          00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
          6e657665 755f7374 756f626e 0000646e 00000000 00000000
8fc32500 8fc32c00
          ...
Call Trace:
[<8010ee6c>] show_stack+0x64/0x7c
[<801571c4>] __report_bad_irq.isra.0+0x40/0x100
[<801574d8>] note_interrupt+0x1e0/0x338
[<80154d3c>] handle_irq_event_percpu+0xe8/0x1a0
[<80154e34>] handle_irq_event+0x40/0x6c
[<80157c8c>] handle_level_irq+0xac/0x16c
[<801543e8>] generic_handle_irq+0x44/0x5c
[<801543e8>] generic_handle_irq+0x44/0x5c
[<801543e8>] generic_handle_irq+0x44/0x5c
[<8010bd04>] do_IRQ+0x18/0x24
[<8010a018>] ret_from_irq+0x0/0x4
[<801d95fc>] kmem_cache_alloc+0x0/0xf8
[<80216b38>] alloc_buffer_head+0x1c/0x70
[<80216cb0>] alloc_page_buffers+0xbc/0x134
[<80216d4c>] create_empty_buffers+0x24/0x14c
[<80216ee0>] create_page_buffers+0x6c/0x94
[<8021896c>] block_read_full_page+0x48/0x4b8
[<8019dac8>] do_read_cache_page+0xac/0x278
[<8019dcb4>] read_cache_page+0x20/0x2c
[<803da774>] read_dev_sector+0x34/0xc0
[<803dc7ec>] read_lba.isra.0+0xe8/0x200
[<803dcb80>] is_gpt_valid+0x27c/0x318
[<803dcd40>] efi_partition+0x124/0xb44
[<803db9b4>] check_partition+0x108/0x254
[<803dae84>] rescan_partitions+0x104/0x384
[<8021cc8c>] __blkdev_get+0x318/0x440
[<8021d8d0>] blkdev_get+0x11c/0x330
[<803d8c08>] add_disk+0x380/0x488
[<8048e350>] sd_probe_async+0x100/0x228
[<8013d7ec>] async_run_entry_fn+0x4c/0x118
[<80135080>] process_one_work+0x130/0x40c
[<801354c8>] worker_thread+0x16c/0x5a8
[<8013af04>] kthread+0xd4/0xec
[<8010a068>] ret_from_kernel_thread+0x14/0x1c

handlers:
[<804ab75c>] ata_sff_interrupt
Disabling IRQ #136


Manuel
