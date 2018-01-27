Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:12:28 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:40729
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeA0DMUQnjRB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:12:20 +0100
Received: by mail-pl0-x242.google.com with SMTP id g18so157884plo.7;
        Fri, 26 Jan 2018 19:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=+PF+99+oOxKQFehx2Sun3wtHhJbGENVX0ICVDP7YZ1k=;
        b=HUzuTO/6HRiQDTDZ9H0J66s3opl+YGyOl3TJ/6uHq0TT4NI4bFAcwmZuhHBGIHzu/a
         thfe8cTePKpTDLkkSK31KymSCqtUpHc3LTd7ihjmNfrID1X52VYKVAFMj5Kk+6fl8d7v
         VQsxVVnCgvIZB2ocRUFMaML+LvW9yW8mFN4l9oZHj8DuYZbqLM2T9hXShbP5+f7wJHVo
         79Xp4zEVxRfjUfdk1WcM4jdgGor0D1dGOpRsDhQikqenRRfBmrVwOAfe0HuJjEN+DFh3
         6DlsQvb2qVSSKhurFMWyqUJkEvo9a/xDMVM4PwPACysdQ95eg8NEDeZMebKRjA23WaUG
         O+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=+PF+99+oOxKQFehx2Sun3wtHhJbGENVX0ICVDP7YZ1k=;
        b=QMgLYaIOa+rbck/6nQGS0iIIndBrxudome3yiQiDnRl8QAtK88xMU7mSIHgSadtdl/
         qfPzIu6L2lDX/ZTkx0cdMTN/e3KaX4nGd1VlVWD/4Lyi4FdyBZOLteMHMkiAbK15SuTx
         9VK1NS1Av7tkaIS09f74kd2cmugNkPbxiLHVfGyl4kg/tJNSoMFHynRXewY/N1Wg2GZx
         sazqtiSAN3IEL9rZvLg9ljL/nGFqKejsPDVK9ndcDKQge0RFSdZw0+pozNH+YzNStnD/
         ojo4DYGgacbLoL2ZVQDIiKYlSrhyknjaJzPzw98FWL+2cvk1/hxeiSbHipfkx4Qohu/0
         Uo2A==
X-Gm-Message-State: AKwxytcAy6ytVvK2z4W80aFRT/lgRKrlIWgswL0c7h28Z5HH0HV471MO
        VJNEJ1z0wC1Gk9haYO5akz2oOw==
X-Google-Smtp-Source: AH8x22712LjFqK9ROjPQOH73ZfenskP0sNnVVzGGk+7uD2zbU4PLY0hVGAjdJUeba65KO5L67MeeNA==
X-Received: by 2002:a17:902:968b:: with SMTP id n11-v6mr16024354plp.168.1517022731871;
        Fri, 26 Jan 2018 19:12:11 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id w16sm4775884pfk.18.2018.01.26.19.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:12:11 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 00/12] MIPS: Loongson: new features and improvements
Date:   Sat, 27 Jan 2018 11:12:20 +0800
Message-Id: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62343
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

This patchset is prepared for the next 4.16 release for Linux/MIPS. It
add Loongson-3A R3.1 support, enable Loongson-3's SFB at runtime, adds
"model name" and "CPU MHz" knobs in /proc/cpuinfo which is needed by
some userspace tools, adds Loongson-3 kexec/kdump and CPUFreq support,
fixes CPU UART irq delivery problem, and introduces WAR_LLSC_MB to
improve stability.

V1 -> V2:
1, Add Loongson-3A R3.1 basic support.
2, Fix CPU UART irq delivery problem.
3, Improve code and descriptions (Thank James Hogan).
4, Sync the code to upstream.

Huacai Chen(12):
 MIPS: Loongson: Add Loongson-3A R3.1 basic support.
 MIPS: Loongson-3: Define and use some CP0 registers.
 MIPS: Loongson-3: Enable Store Fill Buffer at runtime.
 MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3.
 MIPS: Loongson fix name confict - MEM_RESERVED.
 MIPS: Ensure pmd_present() returns false after pmd_mknotpresent().
 MIPS: Add __cpu_full_name[] to make CPU names more human-readable.
 MIPS: Align kernel load address to 64KB.
 MIPS: Loongson: Add kexec/kdump support.
 MIPS: Loongson: Make CPUFreq usable for Loongson-3.
 MIPS: Loongson-3: Fix CPU UART irq delivery problem.
 MIPS: Loongson: Introduce and use WAR_LLSC_MB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   5 +-
 arch/mips/include/asm/atomic.h                     |  18 +-
 arch/mips/include/asm/barrier.h                    |   6 +
 arch/mips/include/asm/bitops.h                     |  15 ++
 arch/mips/include/asm/cmpxchg.h                    |   9 +-
 arch/mips/include/asm/cpu-info.h                   |   2 +
 arch/mips/include/asm/cpu.h                        |  51 ++---
 arch/mips/include/asm/edac.h                       |   5 +-
 arch/mips/include/asm/futex.h                      |  18 +-
 arch/mips/include/asm/io.h                         |   2 +-
 arch/mips/include/asm/local.h                      |  10 +-
 arch/mips/include/asm/mach-loongson64/boot_param.h |   3 +-
 .../asm/mach-loongson64/kernel-entry-init.h        |  38 ++--
 arch/mips/include/asm/mach-loongson64/loongson.h   |   1 +
 arch/mips/include/asm/mipsregs.h                   |   2 +
 arch/mips/include/asm/pgtable-64.h                 |   5 +
 arch/mips/include/asm/pgtable.h                    |   5 +-
 arch/mips/include/asm/r4kcache.h                   |  34 +++
 arch/mips/include/asm/time.h                       |   2 +
 arch/mips/kernel/cpu-probe.c                       |  28 ++-
 arch/mips/kernel/proc.c                            |   7 +
 arch/mips/kernel/relocate_kernel.S                 |  30 +++
 arch/mips/kernel/smp.c                             |   3 +-
 arch/mips/kernel/syscall.c                         |   2 +
 arch/mips/kernel/time.c                            |   2 +
 arch/mips/loongson64/Kconfig                       |   1 +
 arch/mips/loongson64/Platform                      |   3 +
 arch/mips/loongson64/common/env.c                  |  24 ++-
 arch/mips/loongson64/common/mem.c                  |   2 +-
 arch/mips/loongson64/common/platform.c             |  13 +-
 arch/mips/loongson64/common/reset.c                | 119 +++++++++++
 arch/mips/loongson64/loongson-3/Makefile           |   2 +-
 arch/mips/loongson64/loongson-3/clock.c            | 191 +++++++++++++++++
 arch/mips/loongson64/loongson-3/irq.c              |  41 +---
 arch/mips/loongson64/loongson-3/numa.c             |   2 +-
 arch/mips/loongson64/loongson-3/smp.c              |   8 +-
 arch/mips/loongson64/loongson-3/smp.h              |   1 +
 arch/mips/mm/c-r4k.c                               |  42 +++-
 arch/mips/mm/tlbex.c                               |  11 +
 drivers/cpufreq/Kconfig                            |  13 ++
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/loongson3_cpufreq.c                | 236 +++++++++++++++++++++
 drivers/platform/mips/cpu_hwmon.c                  |   3 +-
 43 files changed, 893 insertions(+), 123 deletions(-)
 create mode 100644 arch/mips/loongson64/loongson-3/clock.c
 create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
--
2.7.0
