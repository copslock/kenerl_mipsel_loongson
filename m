Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2012 06:13:30 +0100 (CET)
Received: from mail-tul01m020-f177.google.com ([209.85.214.177]:40805 "EHLO
        mail-tul01m020-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903605Ab2AQFNW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2012 06:13:22 +0100
Received: by obcuz6 with SMTP id uz6so3069952obc.36
        for <multiple recipients>; Mon, 16 Jan 2012 21:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QpvhlNJEe2itqFTXV9WmI4TVR5qiFsWyoMASyVBgo68=;
        b=jqQTJm+siEICD05rx7WTeQ57rGRnwLjGkmWPrX9fvlojhQrEwT7xhBmkNFLHZPNSSE
         zu7f2v1ODDCMra4aMNv5P6kSRoZtDQEMJXbODeC5O/R6aAr1cW6IRt1y35xJEj/DIm2M
         vEy9JwhXjSwkwMiKVvQxUtURs/fcDWTbaOPag=
Received: by 10.50.156.130 with SMTP id we2mr15798791igb.10.1326777195997;
        Mon, 16 Jan 2012 21:13:15 -0800 (PST)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id lu10sm36937638igc.0.2012.01.16.21.13.07
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 21:13:14 -0800 (PST)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org
Cc:     gregkh@suse.de, zhzhl555@gmail.com, peppe.cavallaro@st.com,
        wuzhangjin@gmail.com, linux-kernel@vger.kernel.org,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V6 0/5] MIPS: Add support for Loongson1B
Date:   Tue, 17 Jan 2012 13:12:35 +0800
Message-Id: <1326777160-9930-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 32260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

These patches add support for Loongson1B.

Changelog:

V6: Add USB support for Loongson1B.

V5: Add IS_ENABLED() macro for platform devices.

V4: Split the RTC patch, and merge the arch/mips parts into patch 2/4.
    Use 'KSEG1ADDR' instead of 'ioremap()' in registers definitions.

V3: Add RTC support for Loongson1B.

V2: Add Ethernet support for Loongson1B.

V1: Add basic support for Loongson1B.
----------------

Kelvin Cheung (5):
  MIPS: Add CPU support for Loongson1B
  MIPS: Add board support for Loongson1B
  MIPS: Add Makefile and Kconfig for Loongson1B
  USB: Add EHCI bus glue for Loongson1x SoCs
  MIPS: Add defconfig for Loongson1B

 arch/mips/Kbuild.platforms                       |    1 +
 arch/mips/Kconfig                                |   31 ++++
 arch/mips/configs/ls1b_defconfig                 |  104 +++++++++++++
 arch/mips/include/asm/cpu.h                      |    3 +-
 arch/mips/include/asm/mach-loongson1/irq.h       |   68 +++++++++
 arch/mips/include/asm/mach-loongson1/loongson1.h |   44 ++++++
 arch/mips/include/asm/mach-loongson1/platform.h  |   23 +++
 arch/mips/include/asm/mach-loongson1/prom.h      |   24 +++
 arch/mips/include/asm/mach-loongson1/regs-clk.h  |   33 ++++
 arch/mips/include/asm/mach-loongson1/regs-wdt.h  |   22 +++
 arch/mips/include/asm/mach-loongson1/war.h       |   25 +++
 arch/mips/include/asm/module.h                   |    2 +
 arch/mips/kernel/cpu-probe.c                     |   15 ++
 arch/mips/kernel/perf_event_mipsxx.c             |    6 +
 arch/mips/kernel/traps.c                         |    1 +
 arch/mips/loongson1/Kconfig                      |   21 +++
 arch/mips/loongson1/Makefile                     |   11 ++
 arch/mips/loongson1/Platform                     |    7 +
 arch/mips/loongson1/common/Makefile              |    5 +
 arch/mips/loongson1/common/clock.c               |  165 +++++++++++++++++++++
 arch/mips/loongson1/common/irq.c                 |  146 +++++++++++++++++++
 arch/mips/loongson1/common/platform.c            |  130 +++++++++++++++++
 arch/mips/loongson1/common/prom.c                |   87 +++++++++++
 arch/mips/loongson1/common/reset.c               |   45 ++++++
 arch/mips/loongson1/common/setup.c               |   29 ++++
 arch/mips/loongson1/ls1b/Makefile                |    5 +
 arch/mips/loongson1/ls1b/board.c                 |   39 +++++
 arch/mips/oprofile/common.c                      |    1 +
 arch/mips/oprofile/op_model_mipsxx.c             |    4 +
 drivers/usb/Kconfig                              |    1 +
 drivers/usb/host/ehci-hcd.c                      |    5 +
 drivers/usb/host/ehci-ls1x.c                     |  170 ++++++++++++++++++++++
 32 files changed, 1272 insertions(+), 1 deletions(-)
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
 create mode 100644 drivers/usb/host/ehci-ls1x.c
