Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 19:14:10 +0100 (CET)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:38611
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990429AbeKHSMMY19I8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 19:12:12 +0100
Received: by mail-pl1-x642.google.com with SMTP id p4-v6so7519178plo.5
        for <linux-mips@linux-mips.org>; Thu, 08 Nov 2018 10:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0gA8LsXswfrIAmbtYisG71JTJmLmakfJ+ILccJByaU=;
        b=buc3UhoKkeYLzhfy1LFvSgTevjKzuw+S/EPNcM7/J1DWFKB4AczvPH1MMD5Ak06Z9l
         1Xlxhv1dwM8hMSb36qsqIYc3EEW/DmX/L4l/q+89z1P8aLicH26pXwnG2h8/KhPOVHe+
         TvMvNwTMBp+zR1I4QvrRyuY93K0+fxHhDJoc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0gA8LsXswfrIAmbtYisG71JTJmLmakfJ+ILccJByaU=;
        b=AfCQrbfji+Br6DQG5p1vAqBlp5Om7BvWw7dDjLFRFnrI5/TEIlZMCeCzxM5Yp5MDFc
         v2NaYQZMOL31QY6hl2UHoR/QzoMZ5VkxaYAzBCGmP8nIXCK5LRPsKollJGTkU7FKiT5z
         XSAcUR96XoMf8P0S9rPjdUsQ+APJvMoQurIxoCR1N/Okh1wNcFrOrlbakP/YLcYK2W4H
         8iotmDVWU5fFLbb0SYhFN+V0D0OrJNzpwERoDON1pU1UVNaJZ+s9BW0CX1tc9qYY0oT7
         0dfCQGWSEsW1B2OUeWnc/HSkATodV3uxgwdWQH2yhr7yypvacE7zvvXnJvUP5NCXtbss
         E/vA==
X-Gm-Message-State: AGRZ1gLoSeStexOX/7vhD4IWmAbWkuEOnYzrCtinlSNzueU3fv59ZIWi
        9oBS0/tfHlYOKl3Hf7A2zwGbWQ==
X-Google-Smtp-Source: AJdET5dLCU23zzCHPNag7xR8IOaOFzKVkGtOPwTljtbBZ3ntwXCVtlPSlP8LPHJ3t2lbqbPj9+G8OQ==
X-Received: by 2002:a17:902:4583:: with SMTP id n3-v6mr5496253pld.53.1541700730786;
        Thu, 08 Nov 2018 10:12:10 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 64-v6sm10028533pfa.120.2018.11.08.10.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 10:12:09 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelaf@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Joel Fernandes <joelaf@google.com>,
        akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        kvmarm@lists.cs.columbia.edu, Ley Foon Tan <lftan@altera.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        lokeshgidra@google.com, Max Filippov <jcmvbkbc@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, minchan@kernel.org,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH -next-akpm 0/3] Add support for fast mremap
Date:   Thu,  8 Nov 2018 10:11:58 -0800
Message-Id: <20181108181201.88826-1-joelaf@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joel@joelfernandes.org
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

Hi,
Here is the "fast mremap" series. This just a repost with Kirill's Acked-bys
added and William's Reviewed-by added. Also fixed a UML build error reported
last week. I would like this to be considered for linux -next. The performance
numbers in the series are for testing on x86. The config enablement patch for
arm64 will be posted in the future after testing (see notes below).

List of patches in series:

(1) mm: select HAVE_MOVE_PMD in x86 for faster mremap

(2) mm: speed up mremap by 20x on large regions (v5)
v1->v2: Added support for per-arch enablement (Kirill Shutemov)
v2->v3: Updated commit message to state the optimization may also
	run for non-thp type of systems (Daniel Col).
v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
	Rebased ontop of Linus's master, updated perf results based
        on x86 testing. Added Kirill's Acks.
v4->v5: Added William's Reviewed-by. Fixed arch/um build error
	due to set_pmd_at not defined. Rebased on linux-next/akpm.

(3) mm: treewide: remove unused address argument from pte_alloc functions (v2)
v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
        update changelog with manual fixups for m68k and microblaze.

not included - (4) mm: select HAVE_MOVE_PMD in arm64 for faster mremap
    This patch is dropped since last posting pending further performance
    testing on arm64 with new TLB gather updates. See notes in patch
    titled "mm: speed up mremap by 500x on large regions" for more
    details.

Joel Fernandes (Google) (3):
mm: treewide: remove unused address argument from pte_alloc functions
(v2)
mm: speed up mremap by 20x on large regions (v5)
mm: select HAVE_MOVE_PMD in x86 for faster mremap

arch/Kconfig                                 |  5 ++
arch/alpha/include/asm/pgalloc.h             |  6 +-
arch/arc/include/asm/pgalloc.h               |  5 +-
arch/arm/include/asm/pgalloc.h               |  4 +-
arch/arm64/include/asm/pgalloc.h             |  4 +-
arch/hexagon/include/asm/pgalloc.h           |  6 +-
arch/ia64/include/asm/pgalloc.h              |  5 +-
arch/m68k/include/asm/mcf_pgalloc.h          |  8 +--
arch/m68k/include/asm/motorola_pgalloc.h     |  4 +-
arch/m68k/include/asm/sun3_pgalloc.h         |  6 +-
arch/microblaze/include/asm/pgalloc.h        | 19 +-----
arch/microblaze/mm/pgtable.c                 |  3 +-
arch/mips/include/asm/pgalloc.h              |  6 +-
arch/nds32/include/asm/pgalloc.h             |  5 +-
arch/nios2/include/asm/pgalloc.h             |  6 +-
arch/openrisc/include/asm/pgalloc.h          |  5 +-
arch/openrisc/mm/ioremap.c                   |  3 +-
arch/parisc/include/asm/pgalloc.h            |  4 +-
arch/powerpc/include/asm/book3s/32/pgalloc.h |  4 +-
arch/powerpc/include/asm/book3s/64/pgalloc.h | 12 ++--
arch/powerpc/include/asm/nohash/32/pgalloc.h |  4 +-
arch/powerpc/include/asm/nohash/64/pgalloc.h |  6 +-
arch/powerpc/mm/pgtable-book3s64.c           |  2 +-
arch/powerpc/mm/pgtable_32.c                 |  4 +-
arch/riscv/include/asm/pgalloc.h             |  6 +-
arch/s390/include/asm/pgalloc.h              |  4 +-
arch/sh/include/asm/pgalloc.h                |  6 +-
arch/sparc/include/asm/pgalloc_32.h          |  5 +-
arch/sparc/include/asm/pgalloc_64.h          |  6 +-
arch/sparc/mm/init_64.c                      |  6 +-
arch/sparc/mm/srmmu.c                        |  4 +-
arch/um/include/asm/pgalloc.h                |  4 +-
arch/um/kernel/mem.c                         |  4 +-
arch/unicore32/include/asm/pgalloc.h         |  4 +-
arch/x86/Kconfig                             |  1 +
arch/x86/include/asm/pgalloc.h               |  4 +-
arch/x86/mm/pgtable.c                        |  4 +-
arch/xtensa/include/asm/pgalloc.h            |  8 +--
include/linux/mm.h                           | 13 ++--
mm/huge_memory.c                             |  8 +--
mm/kasan/kasan_init.c                        |  2 +-
mm/memory.c                                  | 17 +++---
mm/migrate.c                                 |  2 +-
mm/mremap.c                                  | 64 +++++++++++++++++++-
mm/userfaultfd.c                             |  2 +-
virt/kvm/arm/mmu.c                           |  2 +-
46 files changed, 165 insertions(+), 147 deletions(-)

--
2.19.1.930.g4563a0d9d0-goog
