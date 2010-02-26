Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 12:41:48 +0100 (CET)
Received: from bby1mta03.pmc-sierra.com ([216.241.235.118]:44908 "EHLO
        bby1mta03.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492050Ab0BZLlo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Feb 2010 12:41:44 +0100
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id E1F9A107006C
        for <linux-mips@linux-mips.org>; Fri, 26 Feb 2010 03:41:32 -0800 (PST)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta03.pmc-sierra.bc.ca (Postfix) with SMTP id D8944107006B
        for <linux-mips@linux-mips.org>; Fri, 26 Feb 2010 03:41:32 -0800 (PST)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 26 Feb 2010 03:41:32 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: blast_dcache32 problem with PREEMPT kernel
Date:   Fri, 26 Feb 2010 03:41:34 -0800
Message-ID: <A7DEA48C84FD0B48AAAE33F328C020140497CB0F@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <6ec4247d1002251934h2168a03fqdcb8e6f0132aa547@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: blast_dcache32 problem with PREEMPT kernel
Thread-Index: Acq2lLkpzdnh1eOFT7Gknz8fsHfT3gAQu6Eg
References: <4B861890.6090002@gmail.com>         <201002250852.09638.florian@openwrt.org>         <6ec4247d1002251312h37f409bdp2384d7fcbddbb321@mail.gmail.com>         <4B872904.6070208@metafoo.de> <6ec4247d1002251934h2168a03fqdcb8e6f0132aa547@mail.gmail.com>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 26 Feb 2010 11:41:32.0773 (UTC) FILETIME=[A4CF7150:01CAB6D8]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi list,

I am hitting following bug with CONFIG_PREEMP enabled VSMP kernel (
2.6.24) compiled for mips34K core.


BUG: using smp_processor_id() in preemptible [00000001] code:
usb-storage/190
caller is blast_dcache32+0x30/0x25c
Call Trace:
[<8012f338>] vprintk+0x2e8/0x584
[<8012f354>] vprintk+0x304/0x584
[<801111a0>] blast_dcache32+0x30/0x25c
[<80387d5c>] debug_smp_processor_id+0xcc/0xe0
[<801111a0>] blast_dcache32+0x30/0x25c
[<80387d5c>] debug_smp_processor_id+0xcc/0xe0
[<801111a0>] blast_dcache32+0x30/0x25c
[<8010d9e4>] dma_map_sg+0x128/0x144
[<80410a84>] urb_destroy+0x0/0x38
[<801827b0>] kfree+0x8c/0x20c
[<80411944>] usb_sg_init+0x310/0x324
[<8042a708>] usb_stor_bulk_transfer_sg+0xd0/0x174
[<8042a914>] usb_stor_Bulk_transport+0x168/0x324
[<80121a94>] enqueue_entity+0xcc/0x130
[<8042a3f4>] usb_stor_invoke_transport+0x38/0x27c
[<80149ee8>] remove_wait_queue+0x1c/0x60
[<8054568c>] _spin_unlock_irqrestore+0x24/0x44
[<805425fc>] __down_interruptible+0x144/0x1e4
[<801239f0>] default_wake_function+0x0/0x8
[<8042bd58>] usb_stor_control_thread+0x268/0x320
[<801497c0>] kthread+0x0/0xa4
[<80149800>] kthread+0x40/0xa4
[<801241d8>] complete+0x4c/0x6c
[<8042baf0>] usb_stor_control_thread+0x0/0x320
[<80149818>] kthread+0x58/0xa4
[<8010476c>] kernel_thread_helper+0x10/0x18

Any pointers to debug this / fix this will be greatly appreciated.

Thanking you,

Anoop
