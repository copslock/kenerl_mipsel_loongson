Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:18:40 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:40659
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbeD1DScuvQiZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:18:32 +0200
Received: by mail-pg0-x241.google.com with SMTP id l2-v6so2822842pgc.7;
        Fri, 27 Apr 2018 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=RSrCipXxmVARRNGd/Ba4yebPvodpjTpW3Jc3MTtCvdg=;
        b=LVWzL/gjPSVb+QqXHP0YvzUcUkgEsHfkAzbOkjEE8FOFkfa6VkCJH9PMlA+u5zEt7+
         n1ykB3PTRUg2HR2clIxaGy4Z5kNquj4LIh3yqSIB8ff4JQOxlm7XZeFZHArPyGt3dMrc
         Jj/AAE1uhrC8nV+YomAjzQjUsFf4nWLNeLGyJY0b2eCKmuIUhmd5oai5qptv1M2g75uQ
         P6tgEQI7WqF+z2AU8LifThqgRh43Vx+yj9+dWn/qRiSEqWc5cLtrpcnZByHU3msLH1E3
         2LeW5qW1ZYyBSojcDX9EqQh3eHC9tp4MI0ERvXtOO0Zxu0kdS1oG38SiGImiXzn1Q0FK
         UqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=RSrCipXxmVARRNGd/Ba4yebPvodpjTpW3Jc3MTtCvdg=;
        b=bmNOEWWviKq2OiTWSTEQbxJ8hDllgxjxgTp/UvE9C9UwD1lihTyP0yzVstG72TAHtA
         crvRug/vnnmBzgwuBl4kBatRXT9hly9MvfpysVvAp4Pqz2nlt2b4oSQo7+2RCaGFPMAG
         0SFQF0CjYsh3y+ioJffHC4m9DzuYaThqUt7Q1sEbaitqBj1qVEMrex0P+DOPa2fyKwws
         OG/+GIGDTM4+S/geRsy4Iv10R8jZliMWHsYwUmPWXk2hmnpCdvNeihNqOWMtHBQhm6hD
         7frWI09Pe2iZfIkfhIs0CPfzEFffw0NXgJTdipSl1iyjrLWwgpysvs7e81gv+qrUDm67
         cJFQ==
X-Gm-Message-State: ALQs6tCzgq/49aMVTZVQFx5TsCOtFK+tx/foyxTqfcxSghhF5vM4PiMR
        CLqklBHsSaSb4egqrLyo45DPXg==
X-Google-Smtp-Source: AB8JxZqXjGw5CwE7t14Erv9n8FM658lQuJ+Hr1NqZj2Upv22wAuOe2nLt6MSkVJTb6tt3FFJb/d/Kg==
X-Received: by 2002:a63:7547:: with SMTP id f7-v6mr4136552pgn.204.1524885505950;
        Fri, 27 Apr 2018 20:18:25 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:18:24 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 00/10] MIPS: Loongson: new features and improvements
Date:   Sat, 28 Apr 2018 11:21:24 +0800
Message-Id: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63818
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

This patchset is prepared for the next 4.18 release for Linux/MIPS. It
add Loongson-3A R3.1 support, enable Loongson-3's SFB at runtime, adds
"model name" and "CPU MHz" knobs in /proc/cpuinfo which is needed by
some userspace tools, adds Loongson-3 kexec/kdump support, fixes CPU
UART irq delivery problem, and introduces WAR_LLSC_MB to improve
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

Huacai Chen(10):
 MIPS: Loongson: Add Loongson-3A R3.1 basic support.
 MIPS: Loongson-3: Define and use some CP0 registers.
 MIPS: Loongson-3: Enable Store Fill Buffer at runtime.
 MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3.
 MIPS: Ensure pmd_present() returns false after pmd_mknotpresent().
 MIPS: Add __cpu_full_name[] to make CPU names more human-readable.
 MIPS: Align kernel load address to 64KB.
 MIPS: Loongson: Add kexec/kdump support.
 MIPS: Loongson-3: Fix CPU UART irq delivery problem.
 MIPS: Loongson: Introduce and use WAR_LLSC_MB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   7 +-
 arch/mips/include/asm/atomic.h                     |  18 +++-
 arch/mips/include/asm/barrier.h                    |   6 ++
 arch/mips/include/asm/bitops.h                     |  15 +++
 arch/mips/include/asm/cmpxchg.h                    |   9 +-
 arch/mips/include/asm/cpu-info.h                   |   2 +
 arch/mips/include/asm/cpu.h                        |  51 ++++-----
 arch/mips/include/asm/edac.h                       |   5 +-
 arch/mips/include/asm/futex.h                      |  18 ++--
 arch/mips/include/asm/io.h                         |   2 +-
 arch/mips/include/asm/kexec.h                      |  15 +++
 arch/mips/include/asm/local.h                      |  10 +-
 arch/mips/include/asm/mach-loongson64/boot_param.h |   1 +
 .../asm/mach-loongson64/kernel-entry-init.h        |  40 ++++---
 arch/mips/include/asm/mach-loongson64/mmzone.h     |   1 +
 arch/mips/include/asm/mipsregs.h                   |   2 +
 arch/mips/include/asm/mmzone.h                     |   8 ++
 arch/mips/include/asm/pgtable-64.h                 |   5 +
 arch/mips/include/asm/pgtable.h                    |   5 +-
 arch/mips/include/asm/r4kcache.h                   |  25 +++++
 arch/mips/include/asm/time.h                       |   2 +
 arch/mips/kernel/cpu-probe.c                       |  28 +++--
 arch/mips/kernel/proc.c                            |   7 ++
 arch/mips/kernel/relocate_kernel.S                 |  26 +++++
 arch/mips/kernel/syscall.c                         |   2 +
 arch/mips/kernel/time.c                            |   2 +
 arch/mips/loongson64/Platform                      |   3 +
 arch/mips/loongson64/common/env.c                  |  23 +++-
 arch/mips/loongson64/common/reset.c                | 120 +++++++++++++++++++++
 arch/mips/loongson64/loongson-3/irq.c              |  41 +------
 arch/mips/loongson64/loongson-3/smp.c              |   9 +-
 arch/mips/loongson64/loongson-3/smp.h              |   1 +
 arch/mips/mm/c-r4k.c                               |  44 ++++++--
 arch/mips/mm/tlbex.c                               |  11 ++
 drivers/platform/mips/cpu_hwmon.c                  |   3 +-
 35 files changed, 452 insertions(+), 115 deletions(-)
--
2.7.0
