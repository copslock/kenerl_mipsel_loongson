Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 05:40:29 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:45514 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009481AbaJJDk1xKKzr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 05:40:27 +0200
Received: by mail-pd0-f176.google.com with SMTP id fp1so856323pdb.21
        for <multiple recipients>; Thu, 09 Oct 2014 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2/+8nUz6Q5aLElhAhdeSYsVKUv26KYmoT/g7ik/0ea0=;
        b=pCjV+Y6PxN3RA3KKvcjdUeM7X2m1pGxviXwZEUfp27xc6sPaSs5v03sJLcmRchpjk8
         YKSLqwbx7XjswBFUNJjXT+p9e4upeLJ8I9fru9sX03I5KuHitvAJkK1nVoElTDsAs7Aj
         HhNDcWB1RQMwktR6w9qbLU4E/wv8xwjG4rEcXmWnwdRw15GTaGAE47YaO0yot9qinQ1c
         kVnVdrMGtY3IYmdOMxnr0cf/VcMaesOBRTYhIR0CVbxW09RW2U4TVVclvRAiRddione2
         01PbcCSX9P4FGCXouw58jjCJZojILRIz0bSiLB5XIeD3Pv5FhZILic/7FGo1b4qu4atJ
         T6Rw==
X-Received: by 10.66.226.36 with SMTP id rp4mr2170132pac.61.1412912421122;
        Thu, 09 Oct 2014 20:40:21 -0700 (PDT)
Received: from localhost.localdomain ([171.213.62.98])
        by mx.google.com with ESMTPSA id sa6sm1563051pbb.29.2014.10.09.20.40.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Oct 2014 20:40:20 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 0/6] MIPS: Loongson1B: Fixes and updates
Date:   Fri, 10 Oct 2014 11:39:58 +0800
Message-Id: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43182
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

These patches are mainly fixes/updates for Loongson1B,
and moreover, add cpufreq support.

Kelvin Cheung (6):
  MIPS: Loongson1B: Fix reboot problem on LS1B
  MIPS: Loongson1B: Improve early printk
  MIPS: Loongson1B: Some fixes/updates for LS1B
  MIPS: Loongson1B: Add a clockevent/clocksource using PWM Timer
  clk: ls1x: Update relationship among all clocks
  cpufreq: Loongson1: Add cpufreq driver for Loongson1B

 arch/mips/Kconfig                                |   1 +
 arch/mips/include/asm/mach-loongson1/cpufreq.h   |  23 +++
 arch/mips/include/asm/mach-loongson1/loongson1.h |   8 +-
 arch/mips/include/asm/mach-loongson1/platform.h  |  10 +-
 arch/mips/include/asm/mach-loongson1/regs-clk.h  |  23 ++-
 arch/mips/include/asm/mach-loongson1/regs-mux.h  |  67 +++++++
 arch/mips/include/asm/mach-loongson1/regs-pwm.h  |  29 +++
 arch/mips/include/asm/mach-loongson1/regs-wdt.h  |  11 +-
 arch/mips/loongson1/Kconfig                      |  42 ++++-
 arch/mips/loongson1/common/Makefile              |   2 +-
 arch/mips/loongson1/common/clock.c               |  28 ---
 arch/mips/loongson1/common/platform.c            | 141 ++++++++++++--
 arch/mips/loongson1/common/prom.c                |  30 ++-
 arch/mips/loongson1/common/reset.c               |  20 +-
 arch/mips/loongson1/common/time.c                | 226 +++++++++++++++++++++++
 arch/mips/loongson1/ls1b/board.c                 |  12 +-
 drivers/clk/clk-ls1x.c                           | 109 ++++++++---
 drivers/cpufreq/Kconfig                          |  10 +
 drivers/cpufreq/Makefile                         |   1 +
 drivers/cpufreq/ls1x-cpufreq.c                   | 217 ++++++++++++++++++++++
 20 files changed, 889 insertions(+), 121 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson1/cpufreq.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-mux.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-pwm.h
 delete mode 100644 arch/mips/loongson1/common/clock.c
 create mode 100644 arch/mips/loongson1/common/time.c
 create mode 100644 drivers/cpufreq/ls1x-cpufreq.c

-- 
1.9.1
