Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:15:25 +0200 (CEST)
Received: from mail-qg0-f73.google.com ([209.85.192.73]:63480 "EHLO
        mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007451AbaH2WOvkL471 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:51 +0200
Received: by mail-qg0-f73.google.com with SMTP id i50so416784qgf.4
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n51GCGIKUkPpMECFu0nqsV9pL4HZ+2xgUjDfrndOh64=;
        b=dxghpNKQB2x4QEPj+tl2VGZVWgR9+GqjT9umzkOoH6bCPnnpPLei1Qsot7aSLvR9ED
         2zwOF0VEzmXbIZgpW8Id5YZYUp+KLSABrz8BPTEBtHCEqvz3VnXmd6eAtmGXvJ3VcmyJ
         5mwPSUyetCTO88zZbeEER6mp7kH4F9LCc3zHb3LIKKw03cljNE+rFkcDz0oE0Zl8i0bX
         +D79aJTBo8ojPsEr9YKYzhL6XKL4Dbw2g0Hy8gKDuZQRPj+KHm1z7XVjER6R2jqbXL6+
         G4APNj/WVqhhuQgoTYW3TEuHe8NpKmpGe9p6da3YZ9jA1zDwQ7dJdZhSB5ty6PJiICY7
         IHPQ==
X-Gm-Message-State: ALoCoQkGmi1j2oEMjqZGJy1v5QN5XuBgZ97D/+G2d+otwWCCZAQGIKxu0F69JcDjxiLFmgpFY2A4
X-Received: by 10.236.207.101 with SMTP id m65mr5481651yho.41.1409350485505;
        Fri, 29 Aug 2014 15:14:45 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c77si178yha.5.2014.08.29.15.14.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:45 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B07DC5A43B0;
        Fri, 29 Aug 2014 15:14:41 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 4ABCA221060; Fri, 29 Aug 2014 15:14:41 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] MIPS: GIC device-tree support
Date:   Fri, 29 Aug 2014 15:14:27 -0700
Message-Id: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

This series add support for mapping and routing GIC interrupts through
the device-tree, which will be used on the upcoming interAptiv-based
Danube SoC.

- Patches 1 and 2 provide improvements to the CPU interrupt controller
  when used with DT.
- Patches 3 through 7 add device-tree support for the GIC.
- Patches 8 and 9 are misc. GIC irqchip cleanups.
- Patches 10 through 12 cleanup/fix GIC local interrupt support.

Based on 3.17-rc2 and boot tested on Danube (+ out of tree patches) and
Malta.  Build tested for SEAD-3.  Paul Burton has also tested this series
with his WIP Malta DT support [0].

[0] https://github.com/paulburton/linux/commits/wip-malta-dt

Andrew Bresticker (12):
  MIPS: Provide a generic plat_irq_dispatch
  MIPS: Set vint handler when mapping CPU interrupts
  of: Add binding document for MIPS GIC
  MIPS: GIC: Move MIPS_GIC_IRQ_BASE into platform irq.h
  MIPS: GIC: Add device-tree support
  MIPS: GIC: Add generic IPI support when using DT
  MIPS: GIC: Implement irq_set_type callback
  MIPS: GIC: Implement generic irq_ack/irq_eoi callbacks
  MIPS: GIC: Fix gic_set_affinity() return value
  MIPS: GIC: Support local interrupts
  MIPS: GIC: Use local interrupts for timer
  MIPS: Malta: Map GIC local interrupts

 Documentation/devicetree/bindings/mips/gic.txt |  50 +++
 arch/mips/include/asm/gic.h                    |  36 ++
 arch/mips/include/asm/mach-generic/irq.h       |   8 +
 arch/mips/include/asm/mach-sead3/irq.h         |   1 +
 arch/mips/include/asm/mips-boards/maltaint.h   |   2 -
 arch/mips/include/asm/mips-boards/sead3int.h   |   2 -
 arch/mips/kernel/cevt-gic.c                    |  16 +-
 arch/mips/kernel/irq-gic.c                     | 434 ++++++++++++++++++++++++-
 arch/mips/kernel/irq_cpu.c                     |  32 +-
 arch/mips/mti-malta/malta-int.c                |  44 ++-
 10 files changed, 585 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/gic.txt

-- 
2.1.0.rc2.206.gedb03e5
