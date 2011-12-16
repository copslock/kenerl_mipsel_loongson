Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2011 12:39:56 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:39852 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903655Ab1LPLjr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Dec 2011 12:39:47 +0100
Received: by iadk27 with SMTP id k27so3443602iad.36
        for <multiple recipients>; Fri, 16 Dec 2011 03:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nd6ypvvUbaEhNRFiIGhVdVDBlE2lb6Y2/HoMBAyNA5A=;
        b=Oc4oQYQyyHMlUeolOj1iuRM5XNKs1UprNrvuO5IIUZggIRghn31IvFbPTu1FWdTHyR
         52T9xJQ1y3pMuz3VhwkZ/jcQturfc9pIsuAJmsl8S9AX/intjosgSf21wLP9qVQFjwkA
         cXOkrHeGV61mI0N1zUB+QS4Av/Q6gmapmnbXU=
Received: by 10.50.42.166 with SMTP id p6mr8043284igl.17.1324035581310;
        Fri, 16 Dec 2011 03:39:41 -0800 (PST)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id wo4sm14335289igc.5.2011.12.16.03.39.33
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 03:39:40 -0800 (PST)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     zhzhl555@gmail.com, peppe.cavallaro@st.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V5 0/4] MIPS: Add support for Loongson1B
Date:   Fri, 16 Dec 2011 19:39:00 +0800
Message-Id: <1324035544-2373-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 32106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13172

These patches add support for Loongson1B.

Changelog:

V5: Add IS_ENABLED() macro for platform devices.

V4: Split the RTC patch, and merge the arch/mips parts into patch 2/4.
    Use 'KSEG1ADDR' instead of 'ioremap()' in registers definitions.

V3: Add RTC device for Loongson1B.

V2: Add Ethernet device for Loongson1B.

V1: Add basic support for Loongson1B.
----------------

Kelvin Cheung (4):
  MIPS: Add CPU support for Loongson1B
  MIPS: Add board support for Loongson1B
  MIPS: Add Makefile and Kconfig for Loongson1B
  MIPS: Add defconfig for Loongson1B

 arch/mips/Kbuild.platforms                       |    1 +
 arch/mips/Kconfig                                |   31 ++++
 arch/mips/configs/ls1b_defconfig                 |   90 ++++++++++++
 arch/mips/include/asm/cpu.h                      |    3 +-
 arch/mips/include/asm/mach-loongson1/irq.h       |   68 +++++++++
 arch/mips/include/asm/mach-loongson1/loongson1.h |   44 ++++++
 arch/mips/include/asm/mach-loongson1/platform.h  |   22 +++
 arch/mips/include/asm/mach-loongson1/prom.h      |   24 +++
 arch/mips/include/asm/mach-loongson1/regs-clk.h  |   33 +++++
 arch/mips/include/asm/mach-loongson1/regs-wdt.h  |   22 +++
 arch/mips/include/asm/mach-loongson1/war.h       |   25 ++++
 arch/mips/include/asm/module.h                   |    2 +
 arch/mips/kernel/cpu-probe.c                     |   15 ++
 arch/mips/kernel/perf_event_mipsxx.c             |    6 +
 arch/mips/kernel/traps.c                         |    1 +
 arch/mips/loongson1/Kconfig                      |   21 +++
 arch/mips/loongson1/Makefile                     |   11 ++
 arch/mips/loongson1/Platform                     |    7 +
 arch/mips/loongson1/common/Makefile              |    5 +
 arch/mips/loongson1/common/clock.c               |  165 ++++++++++++++++++++++
 arch/mips/loongson1/common/irq.c                 |  146 +++++++++++++++++++
 arch/mips/loongson1/common/platform.c            |  102 +++++++++++++
 arch/mips/loongson1/common/prom.c                |   87 ++++++++++++
 arch/mips/loongson1/common/reset.c               |   45 ++++++
 arch/mips/loongson1/common/setup.c               |   29 ++++
 arch/mips/loongson1/ls1b/Makefile                |    5 +
 arch/mips/loongson1/ls1b/board.c                 |   36 +++++
 arch/mips/oprofile/common.c                      |    1 +
 arch/mips/oprofile/op_model_mipsxx.c             |    4 +
 29 files changed, 1050 insertions(+), 1 deletions(-)
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
