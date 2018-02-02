Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:55:20 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:39604
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeBBDzJOtP00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:09 +0100
Received: by mail-lf0-x242.google.com with SMTP id w27so29441460lfd.6;
        Thu, 01 Feb 2018 19:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f+1HQs9Jf1Wyst/ZlsQjlMxEpiCTYKnrNjh8wNXLwWw=;
        b=rcQ56s4BEEfub/kBk4w94X9hvIZeUPvzYbitS3yrABC3sN4W4TdLvauOZKFgNmZUy8
         in+0LvoHhpDN4fD3f9/OMDtvg2m+jnN8EFyFVxTkq//tlVlve+4HF1Gb4Az283xXACgY
         bunHJohIIQBlPb05VMoWWhGPutu2/SBc29tNsrq0HC/PX24qkqqz3Ec2aJvYc7xBNBv7
         qSO0LOYrdjYlQk5T+Og3Ic63Yiva9lj+ZUTs21wtV89k4HH5y4YHTcL+HBaRgK41aHRn
         8YoyHbEZF5oUkVZVbjo3oijNYBXwyMw4VavkSp2ppacEJ+p2GVWIXjTKymiCc/h1ysT8
         2JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f+1HQs9Jf1Wyst/ZlsQjlMxEpiCTYKnrNjh8wNXLwWw=;
        b=CE/ASupdbAT8I84mcjvKoCbw9o3Gqp8bNFdUWpRNjL+4fUOZfMSAtS8dTsx2+q54mq
         0N+UJuIFZ2Im4ePZtioUBc/zxK0bFo0EMldqC7nLNnZPAbd8ObGtX8xNF7GnomDCpfoL
         BUHwUA+6mB3scQGveEpVML06pDw5y366rz3GBlgQ7lU4IJHirdz/4N8ujRvhAsr0F+od
         TcNaPbqDIzMM8usEL2fbBhSwY5W3t5cMUpYOxS8rKZqOeWShx9e80uCwIHniN/0AJhqd
         1z6UbJSJT2XDE8pvfnJunKDx3sG6ziTDvfvqe1rcrD1Q5O7YKQ65UwznnT12dDZcE/LU
         NcBQ==
X-Gm-Message-State: AKwxyteKf0YIUz/m+9kC54BYbE/K5WuDtpt1Jhp+KqmkiFbVh2K+/wQU
        W5T2UvZ8ApG2lwo2v7+S/j5RmuGH
X-Google-Smtp-Source: AH8x227LPD4ldnHOOmaSLEF6WiOK7TpoB7wo7isKbuUDqEs5YQv8+v3C3JuY+HkxG1tdzJZ4yYbyMg==
X-Received: by 10.25.202.9 with SMTP id a9mr23401732lfg.144.1517543703202;
        Thu, 01 Feb 2018 19:55:03 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:02 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 00/15] MIPS: memblock: Switch arch code to NO_BOOTMEM
Date:   Fri,  2 Feb 2018 06:54:43 +0300
Message-Id: <20180202035458.30456-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Even though it's common to see the architecture code using both
bootmem and memblock early memory allocators, it's not good for
multiple reasons. First of all, it's redundant to have two
early memory allocator while one would be more than enough from
functionality and stability points of view. Secondly, some new
features introduced in the kernel utilize the methods of the most
modern allocator ignoring the older one. It means the architecture
code must keep the both subsystems up synchronized with information
about memory regions and reservations, which leads to the code
complexity increase, that obviously increases bugs probability.
Finally it's better to keep all the architectures code unified for
better readability and code simplification. All these reasons lead
to one conclusion - arch code should use just one memory allocator,
which is supposed to be memblock as the most modern and already
utilized by the most of the kernel platforms. This patchset is
mostly about it.

One more reason why the MIPS arch code should finally move to
memblock is a BUG somewhere in the initialization process, when
CMA is activated:

[    0.248762] BUG: Bad page state in process swapper/0  pfn:01f93
[    0.255415] page:8205b0ac count:0 mapcount:-127 mapping:  (null) index:0x1
[    0.263172] flags: 0x40000000()
[    0.266723] page dumped because: nonzero mapcount
[    0.272049] Modules linked in:
[    0.275511] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.88-module #5
[    0.282900] Stack : 00000000 00000000 80b6dd6a 0000003a 00000000 00000000 80930000 8092bff4
          86073a14 80ac88c7 809f21ac 00000000 00000001 80b6998c 00000400 00000000
          80a00000 801822e8 80b6dd68 00000000 00000002 00000000 809f8024 86077ccc
          80b80000 801e9328 809fcbc0 00000000 00000400 00010000 86077ccc 86073a14
          00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
          ...
[    0.323148] Call Trace:
[    0.325935] [<8010e7c4>] show_stack+0x8c/0xa8
[    0.330859] [<80404814>] dump_stack+0xd4/0x110
[    0.335879] [<801f0bc0>] bad_page+0xfc/0x14c
[    0.340710] [<801f0e04>] free_pages_prepare+0x1f4/0x330
[    0.346632] [<801f36c4>] __free_pages_ok+0x2c/0x104
[    0.352154] [<80b23a40>] init_cma_reserved_pageblock+0x5c/0x74
[    0.358761] [<80b29390>] cma_init_reserved_areas+0x1b4/0x240
[    0.365170] [<8010058c>] do_one_initcall+0xe8/0x27c
[    0.370697] [<80b14e60>] kernel_init_freeable+0x200/0x2c4
[    0.376828] [<808faca4>] kernel_init+0x14/0x104
[    0.381939] [<80107598>] ret_from_kernel_thread+0x14/0x1c

The bugus pfn seems to be the one allocated for bootmem allocator
pages and hasn't been freed before letting the CMA working with its
areas. Anyway the bug is solved by this patchset.

Another reason why this patchset is useful is that it fixes the fdt
reserved-memory nodes functionality for MIPS. Really it's bug to have
the fdt reserved nodes scanning before the memblock is
fully initialized (calling early_init_fdt_scan_reserved_mem before
bootmem_init is called). Additionally no-map flag of the
reserved-memory node hasn't been taking into account. This patchset
fixes all of these.

As you probably remember I already did another attempt to merge a
similar functionality into the kernel. This time the patchset got
to be less complex (14 patches vs 21 last time) and fixes the
platform code like SGI IP27 and Loongson3, which due to being
NUMA introduce its own memory initialization process. Although
I have much doubt in SGI IP27 code operability in the first place,
since it got prom_meminit() method of early memory initialization,
which hasn't been called at any other place in the kernel. It must
have been left there unrenamed after arch/mips/mips-boards/generic
code had been discarded.

Here are the list of folks, who agreed to perform some tests of
the patchset:
Alexander Sverdlin <alexander.sverdlin@nokia.com> - Octeon2
Matt Redfearn <matt.redfearn@mips.com> - Loongson3, etc
Joshua Kinard <kumba@gentoo.org> - IP27
Marcin Nowakowski <marcin.nowakowski@mips.com>
Thanks to you all and to everybody, who will be involved in reviewing
and testing.

The patchset is applied on top of kernel 4.15-rc8 and can be found
submitted at my repo:
https://github.com/fancer/Linux-kernel-MIPS-memblock-project

So far the patchset has been successfully tested on the platforms:
UTM8 (Cavium Octeon III)
Creator CI20
Creator CI40
Loongson3a
MIPS Boston
MIPS Malta
MIPS SEAD3
Octeon2

Changelog v2:
- Hide mem_print_kmap_info() behind CONFIG_DEBUG_KERNEL and replace
  %pK with %px there (requested by Matt Redfearn)
- Drop relocatable fixup from reservation_init (patch from Matt Redfearn)
- Move __maybe_unused change from patch 7 to patch 8 (requested by Marcin Nowakowski)
- Add tested platforms to the cover letter

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Matt Redfearn <matt.redfearn@mips.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Matt Redfearn (1):
  MIPS: KASLR: Drop relocatable fixup from reservation_init

Serge Semin (14):
  MIPS: memblock: Add RESERVED_NOMAP memory flag
  MIPS: memblock: Surely map BSS kernel memory section
  MIPS: memblock: Reserve initrd memory in memblock
  MIPS: memblock: Discard bootmem initialization
  MIPS: memblock: Add reserved memory regions to memblock
  MIPS: memblock: Reserve kdump/crash regions in memblock
  MIPS: memblock: Mark present sparsemem sections
  MIPS: memblock: Simplify DMA contiguous reservation
  MIPS: memblock: Allow memblock regions resize
  MIPS: memblock: Perform early low memory test
  MIPS: memblock: Print out kernel virtual mem layout
  MIPS: memblock: Discard bootmem from Loongson3 code
  MIPS: memblock: Discard bootmem from SGI IP27 code
  MIPS: memblock: Deactivate bootmem allocator

 arch/mips/Kconfig                      |   2 +-
 arch/mips/include/asm/bootinfo.h       |   1 +
 arch/mips/kernel/prom.c                |   8 +-
 arch/mips/kernel/setup.c               | 239 +++++++++++++--------------------
 arch/mips/loongson64/loongson-3/numa.c |  16 +--
 arch/mips/mm/init.c                    |  49 +++++++
 arch/mips/sgi-ip27/ip27-memory.c       |   9 +-
 7 files changed, 154 insertions(+), 170 deletions(-)

-- 
2.12.0
