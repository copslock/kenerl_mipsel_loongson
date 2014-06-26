Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 05:42:04 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:47776 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816841AbaFZDmA5SD1L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 05:42:00 +0200
Received: by mail-pa0-f45.google.com with SMTP id rd3so2577640pab.32
        for <multiple recipients>; Wed, 25 Jun 2014 20:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=mMDhi7CWLCUhTBuSdqFd/2Al6ogg6WQp4C2JYj2viAM=;
        b=wtGjBFLKZqpkyvLzncxkIHFJSKj7w/5uJcb3aebAc8vIcRMhNc5G+SWofHOPErmc5I
         HTOTsl3sUmVbZA9pDRF3lWXnzFY5DpX/2yNYHJTkoGuknCOTWEoxaJnNBI1466PUCTZh
         xtjgh3cqk86peR5KywquapLAyIeo+ZOA79nWQzyWfpVqwif+qD6PYEoDgp2m7qX462i6
         EzpmCV72ptYRifyX77EWuwVrDvN/17ekNk5i2Ms9G5ZGyVkCEyETFLEWeWAOY2pIDRGc
         sDdB9K93BS0E3dAVjGdg8VQ20loH/0qjAxZpcY1b6pJ553hSdC584ztGLanPjiz36K+e
         BsqQ==
X-Received: by 10.68.197.134 with SMTP id iu6mr17749631pbc.164.1403754114677;
        Wed, 25 Jun 2014 20:41:54 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id aa3sm5115497pbd.17.2014.06.25.20.41.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 20:41:53 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V3 0/8] MIPS: Loongson-3: Add NUMA and Loongson-3B support
Date:   Thu, 26 Jun 2014 11:41:24 +0800
Message-Id: <1403754092-26607-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40838
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

This patchset is prepared for the next 3.17 release for Linux/MIPS. In
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

V2 -> V3:
1, Rebase the code for 3.17.
2, Reviewed by Andreas Herrmann.
3, Rework the patch "MIPS: Add NUMA support for Loongson-3".

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
 arch/mips/configs/loongson3_defconfig              |    2 +-
 arch/mips/include/asm/addrspace.h                  |    2 +-
 arch/mips/include/asm/cop2.h                       |    8 +
 arch/mips/include/asm/cpu-info.h                   |    1 +
 arch/mips/include/asm/cpu.h                        |    2 +
 arch/mips/include/asm/mach-loongson/boot_param.h   |    4 +
 .../include/asm/mach-loongson/kernel-entry-init.h  |   52 +++
 arch/mips/include/asm/mach-loongson/loongson.h     |   11 +-
 arch/mips/include/asm/mach-loongson/machine.h      |    4 +-
 arch/mips/include/asm/mach-loongson/mmzone.h       |   53 +++
 arch/mips/include/asm/mach-loongson/topology.h     |   23 ++
 arch/mips/include/asm/smp.h                        |    6 +
 arch/mips/include/asm/sparsemem.h                  |    2 +-
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
 arch/mips/loongson/loongson-3/numa.c               |  291 +++++++++++++++
 arch/mips/loongson/loongson-3/smp.c                |  387 +++++++++++++++-----
 arch/mips/loongson/loongson-3/smp.h                |   37 +-
 arch/mips/pci/Makefile                             |    2 +-
 drivers/cpufreq/loongson2_cpufreq.c                |    6 +-
 36 files changed, 986 insertions(+), 159 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mmzone.h
 create mode 100644 arch/mips/include/asm/mach-loongson/topology.h
 create mode 100644 arch/mips/loongson/loongson-3/cop2-ex.c
 create mode 100644 arch/mips/loongson/loongson-3/numa.c
--
1.7.7.3
