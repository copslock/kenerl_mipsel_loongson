Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 02:47:44 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:37807
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992827AbeAXBrfFx3LZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 02:47:35 +0100
Received: by mail-qt0-x244.google.com with SMTP id d54so6610555qtd.4;
        Tue, 23 Jan 2018 17:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CsMI8Lgk40ekGb2PI/KluvXkvjE+8nvy7VxgH9l2yr4=;
        b=lApeyOYqC/fdG2ROt8fe61qdSDDXAbVPxPqobtfP7XLes1BtV14zhEvTuWZaa4aO/J
         CHauYPB+XBEwwxFfep2STjn9gGHFAhw/PwO78asmDeJsUQV1ObVAUW/jdFL15zI/ZyNf
         7geeWShk1yOhJ4YRga9ZCphDFu6/etd/R+q5Ms5q4UL/lWgKrTiZ9zS40qty/xIynuW3
         Y4iRNFziXL6enfXcr3FVoiF03meNBKVUUeJim6DklT0CSfbKvtIl//JCgWaoc6q4xLI3
         oV0DTPx5nbRHDFKJj0yusvKzOo7opicczRy/kxyms5UsQxLgaaFTDqgCZkBhCLZG2rYY
         jHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CsMI8Lgk40ekGb2PI/KluvXkvjE+8nvy7VxgH9l2yr4=;
        b=o2FjdyDRENzBEzv/RgxM3djU/5NWucRx1BYSLkiBgLaFFQNU8XOSfZU3Tdi4xXLb86
         i6Krod1W/7qN77MMHHzA07yjyvLKnmjouulWpan2K0a7baRWKG8MAqNbh0KOAiIFqN62
         1TMXcmIgQv1iMd4cUsdmXLzqBu38lzenattGO9FyKjgi9dX6dp85JHMJDNARN47BjRXl
         ylKoTQGNMKTtslvB3En0wOw0qodvkjVrfBV3t9rVJeAzocbVdlVqCQjMx2KJd+HTaxIP
         v6KoRzjC1+iDEA7B+Fzcbq+FHKpQMPCJnw1VdIeWrS1F0yFP0T7ZEfXNjY6pvUO1sLdO
         KjsA==
X-Gm-Message-State: AKwxytd1aGa86GIiqn78UInq2axgEzuUtDvUH9xZWgPLYgIad9IzJJ1O
        PJsJbVLVjTroKPSjOVvTvXYiDRk4
X-Google-Smtp-Source: AH8x226cpVQMbclfnfPpgvfvPHqtonlFr2C1e1zp2kq3g8pD9hlMaZEH/d/UhhwQtQWAvi9wJrbyWA==
X-Received: by 10.200.44.116 with SMTP id e49mr6969879qta.183.1516758448478;
        Tue, 23 Jan 2018 17:47:28 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x7sm1465605qtx.51.2018.01.23.17.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jan 2018 17:47:27 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 0/6] MIPS: Broadcom eXtended KSEG0/1 support
Date:   Tue, 23 Jan 2018 17:47:00 -0800
Message-Id: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi all,

This patch series brings Broadcom's eXtended KSEG0/1 to the upstream
Linux/MIPS kernel. The intent is that on a lot of BMIPS-based STB chips
we have between 512MB, 1Gb and 2GB of RAM available, and because of the
inflexibility of the unmapped area we access more than 256MB of RAM, which
is inefficient since w need to use the TLB for the upper memory region.

With these changes, we no longer have to, we can access up to 1GB of DRAM
through KSEG0/1 along with specific processor extensions.

I have tried my best to make this as runtime based as possible, and surprisingly, did not run into many places where KSEG0/1 would be referenced from assembly.

Unfortunately, after forward porting these changes from our downstream kernel
to the upstream kernel, I am now seeing the following early crash, any
pointers/clues welcome!

Anything up to patch 5 should not break other platforms, if it does, that's
bad and it needs to be fixed.

Original work from Kevin Cernekee (hey!)

[    0.000000] Linux version 4.15.0-rc7+ (ff944844@stbirv-lnx-1) (gcc version 6.3.0 (crosstool-NG )) #60 SMP Tue Jan 23 17:29:41 PST 2018
[    0.000000] CPU0 revision is: 00025a11 (Broadcom BMIPS5000)
[    0.000000] FPU revision is: 00130001
[    0.000000] MIPS: machine is Broadcom BCM97425SVMB
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 10000000 @ 00000000 (usable)
[    0.000000]  memory: 30000000 @ 20000000 (usable)
[    0.000000]  memory: 40000000 @ 90000000 (usable)
[    0.000000] earlycon: ns16550a0 at MMIO32 0x10406b00 (options '')
[    0.000000] bootconsole [ns16550a0] enabled
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, no aliases, linesize 32 bytes
[    0.000000] MIPS secondary cache 256kB, 8-way, linesize 128 bytes.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000004fffffff]
[    0.000000]   HighMem  [mem 0x0000000050000000-0x00000000cfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000004fffffff]
[    0.000000]   node   0: [mem 0x0000000090000000-0x00000000cfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000cfffffff]
[    0.000000] random: get_random_bytes called from start_kernel+0xa4/0x4f8 with crng_init=0
[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s35216 r8192 d22128 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 521728
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 2042464K/2097152K available (7879K kernel code, 301K rwdata, 1564K rodata, 17000K init, 288K bss, 54688K reserved, 0K cma-reserved, 1048576K highmem)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Kernel bug detected[#1]:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc7+ #60
[    0.000000] $ 0   : 00000000 10000000 00000000 00000000
[    0.000000] $ 4   : cfc03700 cfc03700 ffffffff cfc03704
[    0.000000] $ 8   : 00000000 807b6330 00000110 00000114
[    0.000000] $12   : 00000001 00000000 ffffff80 00000000
[    0.000000] $16   : cfc03600 81c87060 cfc03700 cfc06000
[    0.000000] $20   : cfc03700 80960000 80960000 ffffffec
[    0.000000] $24   : 00000010 00000340                  
[    0.000000] $28   : 8094c000 8094dd70 cfc06000 8005a93c
[    0.000000] Hi    : 00000090
[    0.000000] Lo    : 0000000d
[    0.000000] epc   : 80148fb8 kfree+0x23c/0x240
[    0.000000] ra    : 8005a93c apply_wqattrs_prepare+0x12c/0x1f4
[    0.000000] Status: 10000002 KERNEL EXL 
[    0.000000] Cause : 00808024 (ExcCode 09)
[    0.000000] PrId  : 00025a11 (Broadcom BMIPS5000)
[    0.000000] Modules linked in:
[    0.000000] Process swapper/0 (pid: 0, threadinfo=(ptrval), task=(ptrval), tls=00000000)
[    0.000000] *HwTLS: 77f06490
[    0.000000] Stack : cfc06000 81a34348 80960000 8005a698 cfc06000 01400000 80960000 cfc03600
[    0.000000]         cfc03680 cfc03380 cfc06000 cfc03700 80960000 8005a93c 80892f3e 8095fa80
[    0.000000]         80960000 834b2744 80960000 cfc06000 cfc06008 81a34340 01400000 8005aa4c
[    0.000000]         80915270 00000000 8095faa0 80960000 80960000 8005aed0 00000200 00000002
[    0.000000]         cfc06060 80892f30 01400000 cfc03380 80960000 cfc06010 00000002 8005c828
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] [<(ptrval)>] kfree+0x23c/0x240
[    0.000000] [<(ptrval)>] apply_wqattrs_prepare+0x12c/0x1f4
[    0.000000] [<(ptrval)>] apply_workqueue_attrs_locked+0x48/0xb8
[    0.000000] [<(ptrval)>] apply_workqueue_attrs+0x34/0x60
[    0.000000] [<(ptrval)>] __alloc_workqueue_key+0x180/0x518
[    0.000000] [<(ptrval)>] workqueue_init_early+0x298/0x398
[    0.000000] [<(ptrval)>] start_kernel+0x2e0/0x4f8
[    0.000000] [<(ptrval)>] kernel_entry+0x20/0x60
[    0.000000] Code: 30420001  1440ffed  00000000 <000c000d> 27bdffc8  afb20024  afb10020  afbf0034  afb50030 
[    0.000000] 
[    0.000000] ---[ end trace 08e528f695e5791e ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!


Florian Fainelli (6):
  MIPS: Allow board to override TLB initialization
  MIPS: Allow platforms to override mapping/unmapping coherent
  MIPS: BMIPS: Avoid referencing CKSEG1
  MIPS: Prepare for supporting eXtended KSEG0/1
  MIPS: BMIPS: Handshake with CFE
  MIPS: BMIPS: Add support for eXtended KSEG0/1 (XKS01)

 arch/mips/Kconfig                                  |   2 +
 arch/mips/bmips/Makefile                           |   2 +-
 arch/mips/bmips/memory.c                           | 427 +++++++++++++++++++++
 arch/mips/bmips/setup.c                            |  78 ++++
 arch/mips/include/asm/addrspace.h                  |   8 +
 arch/mips/include/asm/cpu-features.h               |   8 +
 arch/mips/include/asm/cpu.h                        |   1 +
 arch/mips/include/asm/io.h                         |  18 +-
 arch/mips/include/asm/mach-bmips/dma-coherence.h   |   6 +
 arch/mips/include/asm/mach-bmips/ioremap.h         |  26 +-
 .../include/asm/mach-bmips/kernel-entry-init.h     |  18 +
 arch/mips/include/asm/mach-bmips/spaces.h          | 102 +++++
 arch/mips/include/asm/mach-generic/dma-coherence.h |  16 +
 arch/mips/include/asm/page.h                       |   4 +
 arch/mips/include/asm/traps.h                      |   1 +
 arch/mips/kernel/bmips_vec.S                       |   6 +-
 arch/mips/kernel/cpu-probe.c                       |   3 +-
 arch/mips/kernel/traps.c                           |   6 +-
 arch/mips/mm/dma-default.c                         |  10 +-
 arch/mips/mm/ioremap.c                             |  16 +-
 20 files changed, 712 insertions(+), 46 deletions(-)
 create mode 100644 arch/mips/bmips/memory.c
 create mode 100644 arch/mips/include/asm/mach-bmips/kernel-entry-init.h

-- 
2.7.4
