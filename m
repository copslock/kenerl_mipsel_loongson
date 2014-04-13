Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2014 02:25:01 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33681 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822082AbaDMAYtCb3pi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Apr 2014 02:24:49 +0200
Received: by mail-pa0-f41.google.com with SMTP id fa1so6898435pad.0
        for <multiple recipients>; Sat, 12 Apr 2014 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lNhmaeIofetGKbJELOfS0/Zzrp5QuUUgieGN2q+6k20=;
        b=Ts8M0k7YKIWup/emBeMIR43IuVBg1PI81fpb3mlBr5Yk2iaGstyIqzUOAVomeXMrzg
         uLoeip4cq3z12wq3m/AxBDgOG/bCgS7Ai5cuTBtq1WfTShp0F1wTxs8X0WFe290UtvPf
         G4DBxUtPP7bJBg0qCq3K8iwW6AMGH/3XcpAUBvDAo2byGecVa1xV6ls9Tix99aLRAM2t
         IrJqAhaCc00UmT8EfCqO65pmPOXr3VLi5j31COPxLFbEvF+IdnAv85YwxQH0Hy6a6oUg
         ZwIpF/p6tX8anLJApxInGvJ8kRWZ0y5ThzJEK37voFEvsvdTgmMvtNcPSnkm/cZzbklr
         Zi1Q==
X-Received: by 10.66.146.170 with SMTP id td10mr35928926pab.105.1397348682310;
        Sat, 12 Apr 2014 17:24:42 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id sh5sm24474879pbc.21.2014.04.12.17.24.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 17:24:41 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V2 0/8] MIPS: Loongson-3: Add NUMA and Loongson-3B support
Date:   Sun, 13 Apr 2014 08:24:14 +0800
Message-Id: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39783
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

This patchset is prepared for the next 3.16 release for Linux/MIPS. In
this series we add NUMA and Loongson-3B support. Multiple Loongson-3A
chips can be interconnected with HT0-bus. This is a CC-NUMA system that
every chip (node) has its own local memory and cache coherency is
maintained by hardware. Loongson-3B is a 8-cores processor which looks
like there are two Loongson-3A integrated in one chip: 8 cores are
separated into two groups (two NUMA node).

V1 -> V2:
1, Rework the first patch.
2, Use compat numa-related syscall for N32/O32 ABI.
3, Drop the patch "MIPS: Loongson: Make CPU name more clear".

Huacai Chen(8):
 MIPS: Support hard limit of cpu count (nr_cpu_ids).
 MIPS: Support CPU topology files in sysfs.
 MIPS: Loongson: Modify ChipConfig register definition.
 MIPS: Add NUMA support for Loongson-3.
 MIPS: Add numa api support.
 MIPS: Add Loongson-3B support.
 MIPS: Loongson-3: Enable the COP2 usage.
 MIPS: Loongson: Rename CONFIG_LEMOTE_MACH3A to CONFIG_LOONGSON_MACH3X.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com> 
---
 arch/mips/Kconfig                                  |    7 +-
 arch/mips/configs/loongson3_defconfig              |    2 +-
 arch/mips/include/asm/addrspace.h                  |    6 +
 arch/mips/include/asm/cop2.h                       |    8 +
 arch/mips/include/asm/cpu-info.h                   |    1 +
 arch/mips/include/asm/cpu.h                        |    2 +
 arch/mips/include/asm/mach-loongson/boot_param.h   |    4 +
 .../include/asm/mach-loongson/kernel-entry-init.h  |   51 +++
 arch/mips/include/asm/mach-loongson/loongson.h     |   11 +-
 arch/mips/include/asm/mach-loongson/machine.h      |    4 +-
 arch/mips/include/asm/mach-loongson/mmzone.h       |   51 +++
 arch/mips/include/asm/mach-loongson/topology.h     |   23 ++
 arch/mips/include/asm/smp.h                        |    6 +
 arch/mips/include/asm/sparsemem.h                  |    5 +
 arch/mips/kernel/cpu-probe.c                       |    6 +
 arch/mips/kernel/proc.c                            |    1 +
 arch/mips/kernel/scall32-o32.S                     |    4 +-
 arch/mips/kernel/scall64-64.S                      |    4 +-
 arch/mips/kernel/scall64-n32.S                     |   10 +-
 arch/mips/kernel/scall64-o32.S                     |    8 +-
 arch/mips/kernel/setup.c                           |   22 +-
 arch/mips/kernel/smp.c                             |   26 ++-
 arch/mips/loongson/Kconfig                         |    9 +-
 arch/mips/loongson/Platform                        |    2 +-
 arch/mips/loongson/common/env.c                    |   49 +++-
 arch/mips/loongson/common/init.c                   |    4 +
 arch/mips/loongson/common/pm.c                     |    8 +-
 arch/mips/loongson/lemote-2f/clock.c               |    4 +-
 arch/mips/loongson/lemote-2f/reset.c               |    2 +-
 arch/mips/loongson/loongson-3/Makefile             |    4 +-
 arch/mips/loongson/loongson-3/cop2-ex.c            |   63 ++++
 arch/mips/loongson/loongson-3/irq.c                |   26 +-
 arch/mips/loongson/loongson-3/numa.c               |  290 +++++++++++++++
 arch/mips/loongson/loongson-3/smp.c                |  387 +++++++++++++++-----
 arch/mips/loongson/loongson-3/smp.h                |   37 +-
 arch/mips/pci/Makefile                             |    2 +-
 drivers/cpufreq/loongson2_cpufreq.c                |    6 +-
 37 files changed, 997 insertions(+), 158 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mmzone.h
 create mode 100644 arch/mips/include/asm/mach-loongson/topology.h
 create mode 100644 arch/mips/loongson/loongson-3/cop2-ex.c
 create mode 100644 arch/mips/loongson/loongson-3/numa.c
--
1.7.7.3
