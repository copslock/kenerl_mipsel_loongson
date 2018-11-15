Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 08:56:10 +0100 (CET)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:42476
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeKOHySrTCI4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 08:54:18 +0100
Received: by mail-pl1-x642.google.com with SMTP id x21-v6so6368117pln.9;
        Wed, 14 Nov 2018 23:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Eo3m0AsPVwTqj/k7bTOlWtk09rdzjSF1BQEYBmygNUM=;
        b=frQfQ4WIZb0sgO3yvmccN49mIy2H51rV3RQkX2GEgA9hQCizmO6mv94DGwfeaG7eDA
         o7CME+wvshRiZQscpKp8gRIskGGjUke0yIkDBBs8/vUMjAmPDt7m3h0bldOVWLyHpxgw
         LoSYLagGpqUHBq5Ba9zkz1A2YVD0H0dhQs0ab2sqnpezPMuUK98JQ+td7ZZbqnZuzLfP
         yIWbCCohvC2G6L+6kCY2Bsm77ddIf8phYavbNYyp4eaYANkka49CovJSHD1llLV7rBNh
         orJ3NpHOw9GT5URSRD0ddEjbyIIq30M+6+YUpYEAgAJ8m0tgf1neomuFpM34hMtYFMQn
         467g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Eo3m0AsPVwTqj/k7bTOlWtk09rdzjSF1BQEYBmygNUM=;
        b=Q2zsHQlWrpbDDPgJ6ONzMMgNI9xSii5L9DhX4detYfsVNn9pQ8esiZWQmMVoxUUDiz
         6y+MnZy2H4gePDX0G0OA8scje2P3yR/ZWPgo2Hs/EOq2xUBMCGDeO0uMQHIT5cXWKTei
         yBv+nurPx3RXVmbR5Vl0PZj8xC+dL28YevoeIKC6hMELtD9MCsnMSxrjGH3lZj4FJWos
         cg17gqIzuZ1euKTNKJeu0MsabGCuXX/FdlCD8ZRK4IbFoFTXu1S5M1bwHelTqmMgzMYV
         KWjvsRNKGBEVmeZCMLZQMBaQoj97SLDZ8J+wVJNiWUvYWXEAl7ETgenaomJegWyjnzg7
         AghA==
X-Gm-Message-State: AGRZ1gIliaj9UjyHgJc9jvRjv5UBMUDaaHcHz9T0sYRh9tyTBLH0ogb/
        vHwuCgBxfJ9EvtPEA4vQHdWmBr/30iw=
X-Google-Smtp-Source: AJdET5cqQAecmCFiSd0YHEkdoOyqoH/TyYvhtWEQd0s63PIxJgclKzbL3EfzP+8V1FQPL117dwlrWg==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38-v6mr5339977pln.180.1542268457500;
        Wed, 14 Nov 2018 23:54:17 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id k24sm10366286pfj.13.2018.11.14.23.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 23:54:16 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V5 0/8] MIPS: Loongson: new features and improvements
Date:   Thu, 15 Nov 2018 15:53:51 +0800
Message-Id: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67305
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

This patchset is prepared for the next 4.21 release for Linux/MIPS. It
add Loongson-3A R2.1 basic support, adds "model name" and "CPU MHz"
knobs in /proc/cpuinfo which is needed by some userspace tools, adds
Loongson-3 kexec/kdump support, and introduces WAR_LLSC_MB to improve
stability.

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

V4 -> V5:
1, Remove merged patches.
2, Add Loongson-3A R2.1 support.
3, Improve kexec/kdump support.
4, Sync the code to upstream.

Huacai Chen(8):
 MIPS: Loongson: Add Loongson-3A R2.1 basic support.
 MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3.
 MIPS: Ensure pmd_present() returns false after pmd_mknotpresent().
 MIPS: Add __cpu_full_name[] to make CPU names more human-readable.
 MIPS: Align kernel load address to 64KB.
 MIPS: Reserve extra memory for crash dump.
 MIPS: Loongson: Add kexec/kdump support.
 MIPS: Loongson: Introduce and use WAR_LLSC_MB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |  7 +-
 arch/mips/include/asm/atomic.h                     | 36 ++++++--
 arch/mips/include/asm/barrier.h                    |  6 ++
 arch/mips/include/asm/bitops.h                     | 15 ++++
 arch/mips/include/asm/cmpxchg.h                    |  9 +-
 arch/mips/include/asm/cpu-info.h                   |  2 +
 arch/mips/include/asm/cpu.h                        |  3 +-
 arch/mips/include/asm/edac.h                       |  5 +-
 arch/mips/include/asm/futex.h                      | 18 ++--
 arch/mips/include/asm/local.h                      | 10 ++-
 arch/mips/include/asm/mach-loongson64/boot_param.h |  1 +
 .../asm/mach-loongson64/kernel-entry-init.h        |  4 +-
 arch/mips/include/asm/mach-loongson64/mmzone.h     |  1 +
 arch/mips/include/asm/mmzone.h                     |  8 ++
 arch/mips/include/asm/pgtable-64.h                 |  5 ++
 arch/mips/include/asm/pgtable.h                    |  5 +-
 arch/mips/include/asm/r4kcache.h                   | 21 +++++
 arch/mips/include/asm/time.h                       |  2 +
 arch/mips/kernel/cpu-probe.c                       | 28 +++++--
 arch/mips/kernel/idle.c                            |  2 +-
 arch/mips/kernel/proc.c                            |  6 ++
 arch/mips/kernel/relocate_kernel.S                 | 26 ++++++
 arch/mips/kernel/setup.c                           | 51 ++++++++++++
 arch/mips/kernel/syscall.c                         |  2 +
 arch/mips/kernel/time.c                            |  2 +
 arch/mips/loongson64/Platform                      |  3 +
 arch/mips/loongson64/common/env.c                  | 23 +++++-
 arch/mips/loongson64/common/reset.c                | 95 ++++++++++++++++++++++
 arch/mips/loongson64/loongson-3/smp.c              |  9 +-
 arch/mips/loongson64/loongson-3/smp.h              |  1 +
 arch/mips/mm/c-r4k.c                               | 46 +++++++++--
 arch/mips/mm/tlbex.c                               | 11 +++
 drivers/platform/mips/cpu_hwmon.c                  |  3 +-
 33 files changed, 421 insertions(+), 45 deletions(-)
--
2.7.0
