Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 03:32:28 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:43901
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeJMBcYxXaiy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 03:32:24 +0200
Received: by mail-pf1-x443.google.com with SMTP id p24-v6so6998241pff.10
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 18:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tt52pA472dSwsAAwQJ939rJwzTfqkSaNx9EwvICru0=;
        b=aZ2XsHZUVMUuO5DvSG7J3SKtJwMjFPFkNKSdOTMVPxEWZUBHqCq91bWsY5lJSZ5abW
         MspF88SV9xG3kBt1cxNpgjwLM9fjqG9Qr8THIveYjgxWMmIJI/3CsoQ1euVVO+u9jU3b
         84AjE6qoveKMUd+TSCAUYFppegkJuFE12F9Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tt52pA472dSwsAAwQJ939rJwzTfqkSaNx9EwvICru0=;
        b=rQFqUrZHhfVcm2T2E5TnaYs67bDalYDmVsncl3C2E2h2zkrtq0hfDRuLRCfh//QR8E
         XGVp9pYHnoAKozglCktW9dhcozR8TboK+r29FlYE1qYfqE09b4mIQKciaJ+dtoBLao8v
         aNGshxqn6wvfwlP8MU3uOmdAYfMsthB3i1aOk2/SuIfNBdoE5wTqXvq61JNUhHmzJ1sD
         1UfT9uszqKcxIF9lyWQsF2Vz1yHFLfJKL6CC472vsPII3W5Ms9T5iIMkOqbwna+iIGf8
         eVadgJrl79toTPe82Q3m3RjvKrOHAvI/UU4m2IJixNCwXun429cmEdEo4W0kM3UQkpZG
         siqQ==
X-Gm-Message-State: ABuFfoiRppGG4RZvkBt9rSS0wzqwyt0Pon7hFeiUK0CRgopHlzCUXtCP
        NtRYlnxAGV7zuQY4zhfi9X0x8Q==
X-Google-Smtp-Source: ACcGV63QPVBHwSaBapNX/Xe3if6+zBlb78Rh0S4DGfzofyGyhDp7+M5q3Vlq+GIpXS8LG6/GNUgmRw==
X-Received: by 2002:a63:ae4d:: with SMTP id e13-v6mr7685442pgp.315.1539394337561;
        Fri, 12 Oct 2018 18:32:17 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q7-v6sm6507828pfd.164.2018.10.12.18.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 18:32:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        mhocko@kernel.org, minchan@kernel.org,
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
Subject: [PATCH 0/4] Add support for fast mremap
Date:   Fri, 12 Oct 2018 18:31:56 -0700
Message-Id: <20181013013200.206928-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66803
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
Here is the latest "fast mremap" series. The main change in this submission is
to enable the fast mremap optimization on a per-architecture basis to prevent
possible issues with architectures that may not behave well with such change.

x86: select HAVE_MOVE_PMD for faster mremap (v1)

arm64: select HAVE_MOVE_PMD for faster mremap (v1)

mm: speed up mremap by 500x on large regions (v2)
v1->v2: Added support for per-arch enablement (Kirill Shutemov)

treewide: remove unused address argument from pte_alloc functions (v2)
v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
        update changelog with manual fixups for m68k and microblaze.

Joel Fernandes (Google) (4):
  treewide: remove unused address argument from pte_alloc functions (v2)
  mm: speed up mremap by 500x on large regions (v2)
  arm64: select HAVE_MOVE_PMD for faster mremap (v1)
  x86: select HAVE_MOVE_PMD for faster mremap (v1)

 arch/Kconfig                                 |  5 ++
 arch/alpha/include/asm/pgalloc.h             |  6 +-
 arch/arc/include/asm/pgalloc.h               |  5 +-
 arch/arm/include/asm/pgalloc.h               |  4 +-
 arch/arm64/Kconfig                           |  1 +
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
 mm/memory.c                                  | 17 +++--
 mm/migrate.c                                 |  2 +-
 mm/mremap.c                                  | 67 +++++++++++++++++++-
 mm/userfaultfd.c                             |  2 +-
 virt/kvm/arm/mmu.c                           |  2 +-
 47 files changed, 169 insertions(+), 147 deletions(-)

-- 
2.19.0.605.g01d371f741-goog
