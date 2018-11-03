Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Nov 2018 05:00:56 +0100 (CET)
Received: from mail-pf1-x441.google.com ([IPv6:2607:f8b0:4864:20::441]:43759
        "EHLO mail-pf1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbeKCEAt1V3sH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Nov 2018 05:00:49 +0100
Received: by mail-pf1-x441.google.com with SMTP id h4-v6so1873206pfi.10
        for <linux-mips@linux-mips.org>; Fri, 02 Nov 2018 21:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wauWrsOYZ4NO7yzxN9r9ffJEchMQCnKRjhBqfvcq730=;
        b=hQZEI/5IkmDKiwTPcEpeRj5mdJ5f2khCIYUC+tRjECkBSTU7A0nmPfUa+oKun3ZvpC
         QBKK3UGjzZVXQ1U3TcxSBsjIIEAUExiO5kioNqzsBdpusaZSc1GEsUpTdFXIZs++dzNb
         Oce3FxvhzDGCV4UEuF2dXGfauQd44vDoSo9M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wauWrsOYZ4NO7yzxN9r9ffJEchMQCnKRjhBqfvcq730=;
        b=pdGVDp9czl3RqNmyeCkzg0yAF8S8/9VoUVhIVoU7aRYJcbgoja/LSFx4Ql7A/3aLnI
         yN77/H2z1EcouPls7LpMcnIUf6BfaqjEFiW9lBmdcMGJwjjiXGj+vMXWBGcqv2GVRNii
         IpgT1siTsZW6cjCYe513575QpzIsVePv50/VzYuaXgDnhaveNQ5+VX3JioWLiN/vpqKu
         oOd/bxIB9j0hp/FKz9BBHm7/etORAmy9SxtqTnque1WYvAxWwXvGRfx9kqEe7Y/IwD5b
         vrcvgtf35b2EcIfDMU8yIRn/eBMtNEtlZiY64XYU5ZnFV7kqw/0kDdEX0CIszNwPPlHI
         BfBA==
X-Gm-Message-State: AGRZ1gK8/RCgmS3DnbG0Glj+D83743Mx7X22Y0HxTannhz+ADBY9lKBE
        e7Wdqe586kENlzq/fRgw3FNC1A==
X-Google-Smtp-Source: AJdET5cSoldQI3hr9VnkPhkTOPGPi4e4hyOBk5/0PfLyEPfalVwQIW1MKjDzIap7cLOClQG72ynqpQ==
X-Received: by 2002:a63:a441:: with SMTP id c1-v6mr13210874pgp.49.1541217647914;
        Fri, 02 Nov 2018 21:00:47 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id x36-v6sm35836232pgl.43.2018.11.02.21.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 21:00:46 -0700 (PDT)
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
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kirill@shutemov.name,
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
Subject: [PATCH -next 0/3] Add support for fast mremap
Date:   Fri,  2 Nov 2018 21:00:38 -0700
Message-Id: <20181103040041.7085-1-joelaf@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67056
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
Here is the latest "fast mremap" series. This just a repost with Kirill's
Acked-bys added. I would like this to be considered for linux -next.  I also
dropped the CONFIG enablement patch for arm64 since I am yet to test it with
the new TLB flushing code that is in very recent kernel releases. (None of my
arm64 devices run mainline right now.) so I will post the arm64 enablement once
I get to that. The performance numbers in the series are for x86.

List of patches in series:

(1) mm: select HAVE_MOVE_PMD in x86 for faster mremap

(2) mm: speed up mremap by 20x on large regions (v4)
v1->v2: Added support for per-arch enablement (Kirill Shutemov)
v2->v3: Updated commit message to state the optimization may also
	run for non-thp type of systems (Daniel Col).
v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
	Rebased ontop of Linus's master, updated perf results based
        on x86 testing. Added Kirill's Acks.

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
  mm: speed up mremap by 20x on large regions (v4)
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
 mm/mremap.c                                  | 62 +++++++++++++++++++-
 mm/userfaultfd.c                             |  2 +-
 virt/kvm/arm/mmu.c                           |  2 +-
 46 files changed, 163 insertions(+), 147 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog
