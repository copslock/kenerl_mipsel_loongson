Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 21:17:04 +0100 (CET)
Received: from amalthea.cedarwireless.com ([IPv6:2620:26:c000:1001:0:1:6:44]:38768
        "EHLO amalthea.cedarwireless.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992312AbdJaUQ5a0-zA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 21:16:57 +0100
Received: from localhost (localhost [127.0.0.1])
        by amalthea.cedarwireless.com (Postfix) with ESMTP id 7C61571D
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 13:16:47 -0700 (PDT)
X-Virus-Scanned: amavisd-new at cedarwireless.com
Received: from amalthea.cedarwireless.com ([127.0.0.1])
        by localhost (amalthea.cedarwireless.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id blPtXiE3kpeF for <linux-mips@linux-mips.org>;
        Tue, 31 Oct 2017 13:15:20 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smtprelay)
        by amalthea.cedarwireless.com (Postfix) with ESMTPSA id 8264E38
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 13:15:20 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id m72so1195771wmc.1
        for <linux-mips@linux-mips.org>; Tue, 31 Oct 2017 13:15:20 -0700 (PDT)
X-Gm-Message-State: AMCzsaXrrrlkD2wuGdfMllWl7x4RMA/tY+M+J0DR4IlbEBkH2+FntGjm
        QvtOKyG8lYuIrQq/w+PZp6wZa7knyggn6PrtVrs=
X-Google-Smtp-Source: ABhQp+SYTJz2/fG2QAgKaY4WyQfzxhFXMVU5q/u93O8CWMjBma1gtitE3A8nNfDldQAXoxFZ4ogJQYa5Faprb+3OTuU=
X-Received: by 10.28.91.65 with SMTP id p62mr2581602wmb.126.1509480917647;
 Tue, 31 Oct 2017 13:15:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.163.3 with HTTP; Tue, 31 Oct 2017 13:15:17 -0700 (PDT)
In-Reply-To: <3d272dc1-4012-c7ed-7c34-876265afb25e@caviumnetworks.com>
References: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
 <3d272dc1-4012-c7ed-7c34-876265afb25e@caviumnetworks.com>
From:   Gabriel Kuri <gkuri@ieee.org>
Date:   Tue, 31 Oct 2017 13:15:17 -0700
X-Gmail-Original-Message-ID: <CAO3KpR1VGFYdY-Mxb+Xx6yzKhzXAycizEm_7f9LT5GdXcLbkDQ@mail.gmail.com>
Message-ID: <CAO3KpR1VGFYdY-Mxb+Xx6yzKhzXAycizEm_7f9LT5GdXcLbkDQ@mail.gmail.com>
Subject: Re: Octeon CN5010 - Kernel 4.4.92
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <gkuri@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60614
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

> With some kernels, not all memory is allocated to the kernel unless you pass
> "mem=0" on the command line.
>
> Since special Octeon code consumes the "mem=..." parameter, it isn't
> available in userspace after the kernel is booted, so you must look at what
> is done in u-boot.

Well, that didn't work out too well (see below).

Do I need to tweak the device tree or
'arch/mips/cavium-octeon/setup.c' for my specific board?

Allocated memory for ELF segment: addr: 0x1100000, size 0x2628a48
Loading .text @ 0x81100000 (0x35ca1c bytes)
Loading __ex_table @ 0x8145ca20 (0x57c0 bytes)
Loading .rodata @ 0x81463000 (0xca880 bytes)
Loading .pci_fixup @ 0x8152d880 (0x1db8 bytes)
Loading __ksymtab @ 0x8152f638 (0xbdd0 bytes)
Loading __ksymtab_gpl @ 0x8153b408 (0x6710 bytes)
Loading __ksymtab_strings @ 0x81541b18 (0x14cfd bytes)
Loading __param @ 0x81556818 (0x988 bytes)
Clearing __modver @ 0x815571a0 (0xe60 bytes)
Loading .data @ 0x81558000 (0x3bbd8 bytes)
Loading .data..page_aligned @ 0x81594000 (0x4000 bytes)
Loading .init.text @ 0x81598000 (0x278b4 bytes)
Loading .init.data @ 0x815bf8c0 (0x12390 bytes)
Loading .data..percpu @ 0x815d2000 (0x3eb0 bytes)
Clearing .bss @ 0x816e0000 (0x2048a48 bytes)
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
[    0.000000]  memory: 0000000000800000 @ 0000000003800000 (usable)
[    0.000000]  memory: 0000000002628a48 @ 0000000001100000 (usable)
[    0.000000] Wasting 243712 bytes for tracking 4352 unused pages
[    0.000000] Using internal Device Tree.
[    0.000000] bootmem alloc of 8388608 bytes failed!
[    0.000000] Kernel panic - not syncing: Out of memory
[    0.000000] Rebooting in 1 seconds..
