Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 00:19:52 +0100 (CET)
Received: from amalthea.cedarwireless.com ([IPv6:2620:26:c000:1001:0:1:6:44]:54918
        "EHLO amalthea.cedarwireless.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991550AbdJaXTpia2fn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 00:19:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by amalthea.cedarwireless.com (Postfix) with ESMTP id A8B9A994
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 16:19:35 -0700 (PDT)
X-Virus-Scanned: amavisd-new at cedarwireless.com
Received: from amalthea.cedarwireless.com ([127.0.0.1])
        by localhost (amalthea.cedarwireless.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tfiG7UUXJvbp for <linux-mips@linux-mips.org>;
        Tue, 31 Oct 2017 16:19:03 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smtprelay)
        by amalthea.cedarwireless.com (Postfix) with ESMTPSA id 8957F77
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 16:19:02 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id s66so1771163wmf.5
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 16:19:02 -0700 (PDT)
X-Gm-Message-State: AMCzsaW13Mvl76A8ZUgUD8cDTlbIURxMLjdpNi7HLOR5yAyVphO3fKle
        wTHD6Y+EmR67ueU++oZIdiDkDTUfAcqXAHjpG9o=
X-Google-Smtp-Source: ABhQp+Qhp/KrkPnzq74jNkP2GyuKfHao0sYWkatcY8zRO7cn/K8urOHncz2kTOYa7tTiBMT1tS1p13Si27BzQxijIzs=
X-Received: by 10.28.92.208 with SMTP id q199mr2872848wmb.96.1509491940664;
 Tue, 31 Oct 2017 16:19:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.163.3 with HTTP; Tue, 31 Oct 2017 16:19:00 -0700 (PDT)
In-Reply-To: <148da245-c31e-03e9-3d19-f7d125507b96@caviumnetworks.com>
References: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
 <3d272dc1-4012-c7ed-7c34-876265afb25e@caviumnetworks.com> <CAO3KpR1VGFYdY-Mxb+Xx6yzKhzXAycizEm_7f9LT5GdXcLbkDQ@mail.gmail.com>
 <c726a4ab-632a-0788-1147-c3de26ab6b75@caviumnetworks.com> <CAO3KpR2oYGY89utWTpwd0+hzXQ8xJCsNpxLaX7fxV6hWiFbtNQ@mail.gmail.com>
 <148da245-c31e-03e9-3d19-f7d125507b96@caviumnetworks.com>
From:   Gabriel Kuri <gkuri@ieee.org>
Date:   Tue, 31 Oct 2017 16:19:00 -0700
X-Gmail-Original-Message-ID: <CAO3KpR1MRHr=1_2g=UT3P8Jq1fEA3XbEf=-rA6nk4mBHdU5CDg@mail.gmail.com>
Message-ID: <CAO3KpR1MRHr=1_2g=UT3P8Jq1fEA3XbEf=-rA6nk4mBHdU5CDg@mail.gmail.com>
Subject: Re: Octeon CN5010 - Kernel 4.4.92
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <gkuri@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkuri@ieee.org
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

> Interesting.  It sounds like a fun project.

Yep, should be fun.

> Try:
>
>   >  bootoctlinux $(loadaddr) endbootargs mem=0 console=ttyS0,9600
>
>
> When booting Octeon Linux, it is important to use the bootoctlinux command.

I had to hard code the command line before compiling the kernel, it
wouldn't take the argument in their U-Boot.

But now it panics saying "Incorrect memory mapping". See below.

It seems it thinks it has 0 RAM at location 0x0 according to the output below.

Is there anyway to tell it via the command line to use 64M @ 0x0 ?



APBoot 1.0.8.3 (build 20343)
Built: 2008-12-27 at 17:03:46

Model: AP-12x
CPU:   OCTEON CN50XX-SCP revision: 1
Clock: 500 MHz, DDR clock: 333 MHz (666 Mhz data rate)
Power: POE
POST1: passed
POST2: passed
DRAM:  64 MB
Flash: 16 MB
Clear: done
BIST:  passed
PCI:   PCI 32-bit; scanning bus 0 ...
       dev fn venID devID class  rev    MBAR0    MBAR1    MBAR2    MBAR3
       03  00  168c  ff1d 00002   01 80000000 00000000 00000000 00000000
       04  00  168c  ff1d 00002   01 80010000 00000000 00000000 00000000
Net:   en0, en1
Radio: ar9160#0, ar9160#1
apboot> bootoctlinux bed00000
ELF file is 64 bit
Allocated memory for ELF segment: addr: 0x1100000, size 0x16186c8
Loading .text @ 0x81100000 (0x34e614 bytes)
Loading __ex_table @ 0x8144e620 (0x57c0 bytes)
Loading .rodata @ 0x81454000 (0xc8280 bytes)
Loading .pci_fixup @ 0x8151c280 (0x1db8 bytes)
Loading __ksymtab @ 0x8151e038 (0xbdc0 bytes)
Loading __ksymtab_gpl @ 0x81529df8 (0x6710 bytes)
Loading __ksymtab_strings @ 0x81530508 (0x14ceb bytes)
Loading __param @ 0x815451f8 (0x898 bytes)
Clearing __modver @ 0x81545a90 (0x570 bytes)
Loading .data @ 0x81546000 (0x3d7d8 bytes)
Loading .data..page_aligned @ 0x81584000 (0x4000 bytes)
Loading .init.text @ 0x81588000 (0x2665c bytes)
Loading .init.data @ 0x815ae660 (0x12300 bytes)
Loading .data..percpu @ 0x815c1000 (0x3eb0 bytes)
Clearing .bss @ 0x816d0000 (0x10486c8 bytes)
## Loading OS kernel with entry point: 0x81107920 ...
Bootloader: Done loading app on coremask: 0x1
[    0.000000] Linux version 4.4.92 (gkuri@galileo) (gcc version 5.4.0
(LEDE GCC 5.4.0 r3560-79f57e4227
[    0.000000] CVMSEG size: 2 cache lines (256 bytes)
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 000d0601 (Cavium Octeon+)
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000001800000 @ 0000000002800000 (usable)
[    0.000000]  memory: 00000000016186c8 @ 0000000001100000 (usable)
[    0.000000] User-defined physical RAM map:
[    0.000000]  memory: 0000000000000000 @ 0000000000000000 (usable)
[    0.000000] Kernel panic - not syncing: Incorrect memory mapping !!!
[    0.000000] Rebooting in 1 seconds..
