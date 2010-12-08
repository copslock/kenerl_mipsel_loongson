Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2010 14:49:26 +0100 (CET)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:37498 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491164Ab0LHNtX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Dec 2010 14:49:23 +0100
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id D3D578E00BC
        for <linux-mips@linux-mips.org>; Wed,  8 Dec 2010 05:49:06 -0800 (PST)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (bby1exg02 [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id C76298E00B9
        for <linux-mips@linux-mips.org>; Wed,  8 Dec 2010 05:49:06 -0800 (PST)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.159]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 8 Dec 2010 05:49:07 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: SMTC support status in latest git head.
Date:   Wed, 8 Dec 2010 05:48:48 -0800
Message-ID: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMTC support status in latest git head.
Thread-Index: AcuW3qPRrYkCuXj/TUWpvOZEokZpAQ==
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 08 Dec 2010 13:49:07.0010 (UTC) FILETIME=[AED21220:01CB96DE]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi list,

Any body is aware of SMTC support status in latest git sources?. I have tried testing SMTC kernel for malta in qemu / OVP without any success ( emulators not working for 34k). 

I am trying to bring up SMTC Linux support for an mips34K based soc ( MSP71xx family).

While booting , kernel getting hung on calibrate loop delay. I am getting only one interrupt from timer. With similar smtc platform support file (  changed to map smp_ops structure)  2.6.24-stable branch kernel ( where latest timer structure introduced) boots fine. 

[    0.000000] Linux version 2.6.37-rc1-pmc-00197-g5bfd3ba-dirty (paanoop1@paanoop1-desktop) (gcc version 4.5.1 (GCC) ) #168 SMP PREEMPT Wed Dec 8 19:19:490
[    0.000000] DSPRAM0: PA=1c100000,Size=00008000,enabled
[    0.000000] UART clock set to 50000000
[    0.000000] CPU revision is: 00019548 (MIPS 34Kc)
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 00001000 @ 00000000 (reserved)
[    0.000000]  memory: 000ff000 @ 00001000 (usable)
[    0.000000]  memory: 003f2000 @ 00100000 (reserved)
[    0.000000]  memory: 0fad9200 @ 004f2000 (usable)
[    0.000000] Wasting 32 bytes for tracking 1 unused pages
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0000ffcb
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000ffcb
[    0.000000] 6 available secondary CPU TC(s)
[    0.000000] PERCPU: Embedded 7 pages/cpu @81203000 s6464 r8192 d14016 u32768
[    0.000000] pcpu-alloc: s6464 r8192 d14016 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64971
[    0.000000] Kernel command line: console=ttyS0,57600
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
[    0.000000] Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
[    0.000000] Writing ErrCtl register=00000000
[    0.000000] Readback ErrCtl register=00000000
[    0.000000] Memory: 254360k/257888k available (3081k kernel code, 3528k reserved, 653k data, 200k init, 0k highmem)
[    0.000000] Preemptable hierarchical RCU implementation.
[    0.000000] NR_IRQS:128
[    0.000000] console [ttyS0] enabled
[    0.000000] Clock rate set to 600000000
[    0.000000] Calibrating delay loop...

Any idea to debug the issue ?.

Thanks,
Anoop
