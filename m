Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:04:16 +0200 (CEST)
Received: from mail-oi0-f74.google.com ([209.85.218.74]:40254 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011950AbaJTTEOl1HzJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:14 +0200
Received: by mail-oi0-f74.google.com with SMTP id v63so829257oia.5
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q16fJr8tNIjJMH4Ky3eoVqxZiFfmIaffB3jljEtkXgo=;
        b=bfdKBCZUv0rSFsVgNIk5wE6CTZgdNhdK0d5BxgheEdXy1OHM1Ha3mFWdZCYtoTxfWU
         gCtd5XUGIWYYo8dK0vtmp7FaSiloTnOmldaHYtJgq/MdnWuQ/6jCXk50gRQFPxU6csBc
         ot0wGHQIq1s8SdjV5++iLRm5gwt/5T9kO1eKlwNkjc79gwTkRT9V3ING9ABv3icZMZmq
         SPqAczWg4dDehNuvrz+VrorSfAvo8sl6KjhdQrSpyBB0vq3CQwDL2sWT20tMXDTxsA8G
         Wu7GM4gIUwE7v3ZQT3zUAzA8sw+SsncW5Vb15lMpC2IzyJIrHap+P1u/t7Id7bivNkTT
         5YDQ==
X-Gm-Message-State: ALoCoQl/4jztTjoLwYMtYSo3hd9CCNPklWCt2wbBSX8+JDHcHGgSAtpQQxFXxfC65jOk7Ik1PwH7
X-Received: by 10.182.81.199 with SMTP id c7mr20288695oby.3.1413831848363;
        Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si437273yhe.3.2014.10.20.12.04.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:08 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id x6u81G8f.1; Mon, 20 Oct 2014 12:04:08 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 0EB7A220B02; Mon, 20 Oct 2014 12:04:06 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] MIPS GIC cleanup, part 2
Date:   Mon, 20 Oct 2014 12:03:47 -0700
Message-Id: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43359
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

Second round of cleanups for the MIPS GIC drivers:
 - Patches 1 through 5 get rid of the ugly REG() macros and instead use
   proper iomem accessors.
 - Patches 6 and 7 move the GIC header to linux/irqchip/ and clean it up.
 - Patches 8 through 10 are misc. GIC irqchip cleanups.
 - Patches 11 and 12 combine the GIC clocksource and clockevent drivers and
   move them to drivers/clocksource/.
 - Patches 13 through 19 are various cleanups for the GIC clocksource driver.

Boot tested on Malta and (with additional out-of-tree patches) a platform
based on the IMG Pistachio SoC.  Build tested for SEAD-3.

Based on 3.18-rc1 + part 1 of my GIC cleanup series [0].  A tree with both
series is available at:
  https://github.com/abrestic/linux/commits/mips-gic-cleanup-pt2-v1

[0] https://lkml.org/lkml/2014/9/18/487

Andrew Bresticker (19):
  MIPS: Malta: Use gic_read_count() to read GIC timer
  irqchip: mips-gic: Export function to read counter width
  MIPS: sead3: Stop using GIC REG macros
  MIPS: Malta: Stop using GIC REG macros
  irqchip: mips-gic: Use proper iomem accessors
  MIPS: Move gic.h to include/linux/irqchip/mips-gic.h
  irqchip: mips-gic: Clean up header file
  irqchip: mips-gic: Clean up #includes
  irqchip: mips-gic: Remove gic_{pending,itrmask}_regs
  irqchip: mips-gic: Use GIC_SH_WEDGE_{SET,CLR} macros
  MIPS: Move GIC clocksource driver to drivers/clocksource/
  clocksource: mips-gic: Combine with GIC clockevent driver
  clocksource: mips-gic: Staticize local symbols
  clocksource: mips-gic: Move gic_frequency to clocksource driver
  clocksource: mips-gic: Remove gic_event_handler
  clocksource: mips-gic: Use percpu_dev_id
  clocksource: mips-gic: Use CPU notifiers to setup the timer
  clocksource: mips-gic: Use clockevents_config_and_register
  clocksource: mips-gic: Bump up rating of GIC timer

 arch/mips/Kconfig                                  |  21 +-
 arch/mips/include/asm/mips-boards/maltaint.h       |   2 +-
 arch/mips/include/asm/mips-boards/sead3int.h       |   2 +-
 arch/mips/include/asm/time.h                       |   5 +-
 arch/mips/kernel/Makefile                          |   2 -
 arch/mips/kernel/cevt-gic.c                        | 103 ---------
 arch/mips/kernel/cevt-r4k.c                        |   2 +-
 arch/mips/kernel/csrc-gic.c                        |  40 ----
 arch/mips/kernel/smp-cmp.c                         |   2 +-
 arch/mips/kernel/smp-cps.c                         |   2 +-
 arch/mips/kernel/smp-gic.c                         |   2 +-
 arch/mips/kernel/smp-mt.c                          |   2 +-
 arch/mips/mti-malta/malta-int.c                    |  15 +-
 arch/mips/mti-malta/malta-time.c                   |  20 +-
 arch/mips/mti-sead3/sead3-ehci.c                   |   2 +-
 arch/mips/mti-sead3/sead3-int.c                    |   9 +-
 arch/mips/mti-sead3/sead3-net.c                    |   2 +-
 arch/mips/mti-sead3/sead3-platform.c               |   2 +-
 arch/mips/mti-sead3/sead3-time.c                   |   2 +-
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/mips-gic-timer.c               | 139 ++++++++++++
 drivers/irqchip/irq-mips-gic.c                     | 243 +++++++++++++--------
 .../asm/gic.h => include/linux/irqchip/mips-gic.h  | 203 +++--------------
 24 files changed, 363 insertions(+), 464 deletions(-)
 delete mode 100644 arch/mips/kernel/cevt-gic.c
 delete mode 100644 arch/mips/kernel/csrc-gic.c
 create mode 100644 drivers/clocksource/mips-gic-timer.c
 rename arch/mips/include/asm/gic.h => include/linux/irqchip/mips-gic.h (61%)

-- 
2.1.0.rc2.206.gedb03e5
