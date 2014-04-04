Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 10:12:25 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55554 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822271AbaDDIMSDKq0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 10:12:18 +0200
Received: by mail-pd0-f182.google.com with SMTP id y10so3000522pdj.13
        for <multiple recipients>; Fri, 04 Apr 2014 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cLFOwOCpnKSLQH4fKwTWhSYBzWHVCYs1tBmuSdlYq+U=;
        b=Q6f4Iv9i+OJwuv4PaKNRB/PG2OU6uKaOAO8TBBEvLNb70Ns+JS4nCcVxBsEGfF8DDi
         41sLXy3gCwtC+HL3g0Yvc6EUWQX0mjypQ1zn5CZ6o4MOFREjZxoCdY7plqGA+SVXl2K6
         uYjXWrhROP7p04ZrloO58xFSiiSnSH71mXLhfss6V46e5/oJD6VHUJC9GTIYCVNsI2ye
         6R4vaLcGMBm7hpB9TS5/Tgbxr9TvVVkb/5y0CkRRU0L95o0qPG496eGS5zKxFrDoieJX
         daLbv4d1wC+ZsoQPDMxehYhW+9z2CFhleeWunjMOV2P6DdIGS6PqQcoesLtzhHR9gDJo
         25nQ==
X-Received: by 10.69.8.225 with SMTP id dn1mr13476876pbd.46.1396599129650;
        Fri, 04 Apr 2014 01:12:09 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id pe3sm16066819pbc.23.2014.04.04.01.12.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 01:12:09 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 00/12] MIPS: Loongson-3: Add NUMA and Loongson-3B support
Date:   Fri,  4 Apr 2014 16:11:35 +0800
Message-Id: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39640
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

Huacai Chen(9):
 MIPS: Support hard limit of cpu count (nr_cpu_ids).
 MIPS: Support CPU topology files in sysfs.
 MIPS: Loongson: Modify ChipConfig register definition.
 MIPS: Add NUMA support for Loongson-3.
 MIPS: Add numa api support.
 MIPS: Add Loongson-3B support.
 MIPS: Loongson: Make CPU name more clear.
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
 arch/mips/kernel/cpu-probe.c                       |   12 +-
 arch/mips/kernel/proc.c                            |    1 +
 arch/mips/kernel/scall32-o32.S                     |    4 +-
 arch/mips/kernel/scall64-64.S                      |    4 +-
 arch/mips/kernel/scall64-n32.S                     |    6 +-
 arch/mips/kernel/scall64-o32.S                     |    6 +-
 arch/mips/kernel/setup.c                           |   20 +-
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
 37 files changed, 995 insertions(+), 158 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mmzone.h
 create mode 100644 arch/mips/include/asm/mach-loongson/topology.h
 create mode 100644 arch/mips/loongson/loongson-3/cop2-ex.c
 create mode 100644 arch/mips/loongson/loongson-3/numa.c
--
1.7.7.3
