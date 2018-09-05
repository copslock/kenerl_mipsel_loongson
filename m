Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:32:46 +0200 (CEST)
Received: from mail-pl1-x644.google.com ([IPv6:2607:f8b0:4864:20::644]:41570
        "EHLO mail-pl1-x644.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeIEJclmJTWC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:32:41 +0200
Received: by mail-pl1-x644.google.com with SMTP id b12-v6so3017950plr.8;
        Wed, 05 Sep 2018 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AblIMhXSkj9pLMj/wZdcry2D4QyB9x3o2Ug10664k/M=;
        b=kHV4GbBl1DrCJv20Uyx78cMdENq4M1hYBwvHDV0gS1f03CLg0rjm9EkyIb/9eoBll1
         KwBaWSIRk7wD8ke5V73+Oy4Vph5B7HdvIEhWgV2FgrmPpmIpiJ0ywEFuN/Vtz7xVyEdp
         +e66x2sUc/gM8b3/x0CvC6FrTrB9I1gwfXalTmmY2nzEAtp1daf1+L851zsRZ3mrxw1u
         LaBjrOx6XDKkF3uBw9L56mfrrcRD4MjFv97yfVQMffgzfidjDgZsJTinuE9xqFk+pJXG
         n+1FWFaSXIRMMEVlJqWAT/8BEAx0jZIQ1H1djWm4hu9FE/xBVmtLElDKjJEHLvHaXiJB
         +FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AblIMhXSkj9pLMj/wZdcry2D4QyB9x3o2Ug10664k/M=;
        b=NLjIExs1pRsCvxjW02amlWkGSuYyD4zxXTMmEgS1gFkbgMgWRSojiqdnCLeDSmdMwq
         uErhiHBZLYWXibUy37I+KajHT2G5adEAS+j9yY1JGb5RbDbDHIs6IcAh6AFmTUJfhGIO
         HB78A+iFH5uYb3W7AVPCQTgtif0Y3atmZd1AAqLwn3I1/nBFlBT4JIfPNoxs3yG37mvF
         n2oob58LKH9hUL7to5y4+G/uLi+D/FwH1TXc0eC/lzffYMubP22huGa1sFKcRXSLaVbZ
         y4VfGHZCIq1mAlPgN8maZJN5bSogeKzPHcvX7LL4Uui9oz6wr5Yo97chd5xT2KbDWEJk
         pCRg==
X-Gm-Message-State: APzg51BeZJvCkkpqUCcv6MCIznWVk9tPmDbg+X6z9vug192bN9L+6E4h
        AOQ3hFyU5qrJCxr+mTMOhIb8JpFOl+k=
X-Google-Smtp-Source: ANB0VdYC/pvW1G7gjuJo0ROVIwWxn9kYz8tiQZh90XjkgqzUSdOYjkpSPEO/F9M+XOmPeeywQlbEBQ==
X-Received: by 2002:a17:902:a613:: with SMTP id u19-v6mr38431090plq.234.1536139954913;
        Wed, 05 Sep 2018 02:32:34 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:32:34 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4 00/10] MIPS: Loongson: new features and improvements
Date:   Wed,  5 Sep 2018 17:33:00 +0800
Message-Id: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This patchset is prepared for the next 4.20 release for Linux/MIPS. It
enable Loongson-3's SFB at runtime, adds "model name" and "CPU MHz"
knobs in /proc/cpuinfo which is needed by some userspace tools, adds
Loongson-3 kexec/kdump support, fixes CPU UART and BRIDGE irq delivery
problem, and introduces WAR_LLSC_MB to improve stability.

V1 -> V2:
1, Add Loongson-3A R3.1 basic support.
2, Fix CPU UART irq delivery problem.
3, Improve code and descriptions (Thank James Hogan).
4, Sync the code to upstream.

V2 -> V3:
1, Remove merged patches.
2, Improve code and descriptions (Thank James Hogan).
3, Sync the code to upstream.

V3 -> V4:
1, Remove merged patches.
2, Improve kdump support.
3, Sync the code to upstream.

Huacai Chen(10):
 MIPS: Loongson-3: Enable Store Fill Buffer at runtime.
 MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3.
 MIPS: Ensure pmd_present() returns false after pmd_mknotpresent().
 MIPS: Add __cpu_full_name[] to make CPU names more human-readable.
 MIPS: Align kernel load address to 64KB.
 MIPS: Reserve extra memory for crash dump.
 MIPS: Loongson: Add kexec/kdump support.
 MIPS: Loongson-3: Fix CPU UART irq delivery problem.
 MIPS: Loongson-3: Fix BRIDGE irq delivery problem.
 MIPS: Loongson: Introduce and use WAR_LLSC_MB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   7 +-
 arch/mips/include/asm/atomic.h                     |  36 +++++--
 arch/mips/include/asm/barrier.h                    |   6 ++
 arch/mips/include/asm/bitops.h                     |  15 +++
 arch/mips/include/asm/cmpxchg.h                    |   9 +-
 arch/mips/include/asm/cpu-info.h                   |   2 +
 arch/mips/include/asm/edac.h                       |   5 +-
 arch/mips/include/asm/futex.h                      |  18 ++--
 arch/mips/include/asm/io.h                         |   2 +-
 arch/mips/include/asm/kexec.h                      |  15 +++
 arch/mips/include/asm/local.h                      |  10 +-
 arch/mips/include/asm/mach-loongson64/boot_param.h |   1 +
 arch/mips/include/asm/mach-loongson64/irq.h        |   2 +-
 .../asm/mach-loongson64/kernel-entry-init.h        |  16 ++-
 arch/mips/include/asm/mach-loongson64/mmzone.h     |   1 +
 arch/mips/include/asm/mmzone.h                     |   8 ++
 arch/mips/include/asm/pgtable-64.h                 |   5 +
 arch/mips/include/asm/pgtable.h                    |   5 +-
 arch/mips/include/asm/r4kcache.h                   |  25 +++++
 arch/mips/include/asm/time.h                       |   2 +
 arch/mips/kernel/cpu-probe.c                       |  25 +++--
 arch/mips/kernel/proc.c                            |   7 ++
 arch/mips/kernel/relocate_kernel.S                 |  26 +++++
 arch/mips/kernel/setup.c                           |  55 ++++++++++
 arch/mips/kernel/syscall.c                         |   2 +
 arch/mips/kernel/time.c                            |   2 +
 arch/mips/loongson64/Platform                      |   3 +
 arch/mips/loongson64/common/env.c                  |  20 ++++
 arch/mips/loongson64/common/reset.c                | 120 +++++++++++++++++++++
 arch/mips/loongson64/loongson-3/irq.c              |  56 ++--------
 arch/mips/loongson64/loongson-3/smp.c              |   6 ++
 arch/mips/loongson64/loongson-3/smp.h              |   1 +
 arch/mips/mm/c-r4k.c                               |  44 ++++++--
 arch/mips/mm/tlbex.c                               |  11 ++
 34 files changed, 476 insertions(+), 92 deletions(-)
--
2.7.0
