Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 12:54:20 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:59770 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903418Ab2FOKyQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 12:54:16 +0200
Received: by pbbrq13 with SMTP id rq13so5371009pbb.36
        for <multiple recipients>; Fri, 15 Jun 2012 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5waUvXzCXiT/ZcZa2raCM7L/pxrSZX6oKxL3jOwSKko=;
        b=OqXmR9k4h2Ans1iWKd5r9sU/gwVdVkRSDBkrXfjsMhw0NEDXqw73JG3A4s3s417h+K
         V253W0FnaRVU5Z/lHGGuiCFlWX8bNtFq0Lzv37tNvGt6OowRpg2u3JHD8611tte6cOHS
         +tAaH33k/Z7bE1EzOd274PD7vtXvl628LkdFMpOpXq/tCMUqqusC/1gKFBvLQ0MMHMap
         G3KJEDDreEBpLHTN/zCsX1/qHHKMcErCeLC4gP82zGYSYjs6JDmE9f8S9PK9VbQdC7Qm
         FkgIh6RkKJmF+9Dj4JrtuSe4HZZ7VUZEJqdilpDQH+lut9l2Hculjhy2TYXqE2ZkABzz
         dGgw==
Received: by 10.68.213.7 with SMTP id no7mr16598093pbc.3.1339757649680;
        Fri, 15 Jun 2012 03:54:09 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id gj8sm12873641pbc.39.2012.06.15.03.54.01
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 03:54:08 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     wuzhangjin@gmail.com, zhzhl555@gmail.com,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V7 0/4] MIPS: Add support for Loongson1B
Date:   Fri, 15 Jun 2012 18:53:33 +0800
Message-Id: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 33655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

These patches add support for Loongson1B.

Changelog:

V7: USB support for Loongson1B has been accepted and available since Linux-3.4.
    RTC support for Loongson1B has been accepted and available since Linux-3.4.
    So, remove the two parts from previous patches.

V6: Add USB support for Loongson1B.

V5: Add IS_ENABLED() macro for platform devices.

V4: Split the RTC patch, and merge the arch/mips parts into patch 2/4.
   Use 'KSEG1ADDR' instead of 'ioremap()' in registers definitions.

V3: Add RTC support for Loongson1B.

V2: Add Ethernet support for Loongson1B.

V1: Add basic support for Loongson1B.
---

Kelvin Cheung (4):
  MIPS: Add CPU support for Loongson1B
  MIPS: Add board support for Loongson1B
  MIPS: Add Makefile and Kconfig for Loongson1B
  MIPS: Add defconfig for Loongson1B

 arch/mips/Kbuild.platforms                       |    1 +
 arch/mips/Kconfig                                |   31 ++++
 arch/mips/configs/ls1b_defconfig                 |  108 ++++++++++++++
 arch/mips/include/asm/cpu.h                      |    3 +-
 arch/mips/include/asm/mach-loongson1/irq.h       |   73 ++++++++++
 arch/mips/include/asm/mach-loongson1/loongson1.h |   44 ++++++
 arch/mips/include/asm/mach-loongson1/platform.h  |   23 +++
 arch/mips/include/asm/mach-loongson1/prom.h      |   24 +++
 arch/mips/include/asm/mach-loongson1/regs-clk.h  |   33 +++++
 arch/mips/include/asm/mach-loongson1/regs-wdt.h  |   22 +++
 arch/mips/include/asm/mach-loongson1/war.h       |   25 ++++
 arch/mips/include/asm/module.h                   |    2 +
 arch/mips/kernel/cpu-probe.c                     |   15 ++
 arch/mips/kernel/perf_event_mipsxx.c             |    5 +
 arch/mips/kernel/traps.c                         |    1 +
 arch/mips/loongson1/Kconfig                      |   21 +++
 arch/mips/loongson1/Makefile                     |   11 ++
 arch/mips/loongson1/Platform                     |    7 +
 arch/mips/loongson1/common/Makefile              |    5 +
 arch/mips/loongson1/common/clock.c               |  165 ++++++++++++++++++++++
 arch/mips/loongson1/common/irq.c                 |  147 +++++++++++++++++++
 arch/mips/loongson1/common/platform.c            |  130 +++++++++++++++++
 arch/mips/loongson1/common/prom.c                |   87 ++++++++++++
 arch/mips/loongson1/common/reset.c               |   45 ++++++
 arch/mips/loongson1/common/setup.c               |   29 ++++
 arch/mips/loongson1/ls1b/Makefile                |    5 +
 arch/mips/loongson1/ls1b/board.c                 |   39 +++++
 arch/mips/oprofile/common.c                      |    1 +
 arch/mips/oprofile/op_model_mipsxx.c             |    4 +
 29 files changed, 1105 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/configs/ls1b_defconfig
 create mode 100644 arch/mips/include/asm/mach-loongson1/irq.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/loongson1.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/platform.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/prom.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-clk.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-wdt.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/war.h
 create mode 100644 arch/mips/loongson1/Kconfig
 create mode 100644 arch/mips/loongson1/Makefile
 create mode 100644 arch/mips/loongson1/Platform
 create mode 100644 arch/mips/loongson1/common/Makefile
 create mode 100644 arch/mips/loongson1/common/clock.c
 create mode 100644 arch/mips/loongson1/common/irq.c
 create mode 100644 arch/mips/loongson1/common/platform.c
 create mode 100644 arch/mips/loongson1/common/prom.c
 create mode 100644 arch/mips/loongson1/common/reset.c
 create mode 100644 arch/mips/loongson1/common/setup.c
 create mode 100644 arch/mips/loongson1/ls1b/Makefile
 create mode 100644 arch/mips/loongson1/ls1b/board.c
