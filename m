Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2018 16:15:41 +0200 (CEST)
Received: from mail-wr1-x442.google.com ([IPv6:2a00:1450:4864:20::442]:46025
        "EHLO mail-wr1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990490AbeI3OPc7EXDu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2018 16:15:32 +0200
Received: by mail-wr1-x442.google.com with SMTP id q5-v6so4505736wrw.12;
        Sun, 30 Sep 2018 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6+x3YShPyc6fiL5GbQhe5v9q1PG82Fg3nttEyWOhP8=;
        b=JFkuMs9zxFpcIF3yNEvR5ANYnhgH3fXfbxFqyCoI3ZxCaIGPlF8NIPCfjAvNSaxjQX
         PgojS/IXoE5f7j5fMCi1ZOFTDvMYACYhd5X0oDhwvVTmBCHVhlv0zd6skvdRzGRKr1NO
         GmLKVLUxFlgXpkKIZ/0Wpc1vU6H0+5ljgPuWqla5QSRF2xh1tyzuaWHLna84afZKlhW9
         kxZHJ17ML7TdaMcs+FWY9b6IMEv6MfrY3LILI3o19NkrkdDr7ZhPBXBVM476gVset0wQ
         MC88UYTfH3qPbXyslH6N5NS+GruZLwBw5zSpts8FJ7U3o6u4XxJjDjPAAmzmBC+wHCJ2
         qCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6+x3YShPyc6fiL5GbQhe5v9q1PG82Fg3nttEyWOhP8=;
        b=iBbtmEKZIkPE8G0RLyR40UdlcUGm4NzRG13N2st7wP0O2h8at1S2sdH3Kmxj/wR5fh
         CexX0lxFtyrFK4PDp/2eyM+OE/oG1bPLMm0rPa5fPgIqm++caw/ZQABBLuhpvt6J3yeS
         4YfDynsN494NsTfURKP7PHwmvjWzNptyyOAuJKCH3BKiBvOrxK+hT08mfcIfTdhk4yXq
         w4RmNcc3r3eLdCqN7djIgpw+TyAHD8dInS38xouTXWQtw5vQQsu1CXcxAX6jil5qSpSK
         txlZacXH5f8Qb9QgNxNR0U23nJSJBW98rejX3EiurUxLXERUr16PrHvX2IGJAok0WF6U
         YyUA==
X-Gm-Message-State: ABuFfoil56UrCFxlm14jvWmILTNX/1ZzwpN5w3az05f1KBTS9DMoEgWc
        LXs/c8AW6gETOkZM0ke2+z6bRH1WU2s=
X-Google-Smtp-Source: ACcGV61fxaoJrgNv3ZHiIrQMCRYu+4+gBEnMLlLAl12dI9abbu40yo4Pw9S9dopJ0m/DVn0YJbu5Sw==
X-Received: by 2002:adf:bbc3:: with SMTP id z3-v6mr4321246wrg.183.1538316927300;
        Sun, 30 Sep 2018 07:15:27 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v21-v6sm19415738wrd.4.2018.09.30.07.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:15:26 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/5] MIPS: Lexra LX5280 CPU + Realtek RTL8186 SoC support
Date:   Sun, 30 Sep 2018 17:15:05 +0300
Message-Id: <20180930141510.2690-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

Hi,

This RFC patch series adds all the necessary code
to successfully boot Linux on the Realtek RTL8186 SoC.

Boot log with this series applied (+one DT patch that adds partitions) is available here:
https://gist.github.com/yashac3/483decfa8db014edfb055ba5a1f9996e

Network drivers and other misc drivers are not included
in this patch set (they will be sent in the future).


This patch series includes:
- Patch 1: Lexra LX5280 CPU support (MIPS)
- Patches 2-4: DT bindings for hardware supported in patch 5
- Patch 5: RTL8186 SoC support (MIPS code, timer driver, irqchip, device tree)


What's still missing:

1) Upstream toolchain support for the Lexra LX5280 CPU.
   (Still WIP) GCC and binutils patches are available at [1][2].
   Buildroot with these patches applied is available at [3].

   The toolchain work is still WIP and I'm planning to send it
   for review when it will be ready.

   Still, feel free to comment on this work too.

2) Reading the TLB size from device tree:
   (The reason there's no DT bindings for the LX5280 in this series)

   As there's no way to get the TLB size from the hardware,
   is must be passed in the DT.

   Currently in arch/mips, the FDT is not available in the cpu_probe()
   stage, where the 'tlbsize' field of the cpu data is set.

   Any ideas/suggestions on how to solve that?


This patch series is on top of v4.18 + 5 prerequisite patches that
are in mips-next for 4.20. [4][5].

This patch series is also available at:
https://github.com/yashac3/linux-rtl8186/commits/rtl8186-porting-for-upstream-4.18


Please review.

Thanks,
Yasha


[1] https://github.com/yashac3/gcc/commits/lx5280-gcc-8_2_0
[2] https://github.com/yashac3/binutils-gdb/commits/lx5280-porting-master
[3] https://github.com/yashac3/buildroot/commits/lx5280_master
[4] https://www.linux-mips.org/archives/linux-mips/2018-09/msg00769.html
[5] https://www.linux-mips.org/archives/linux-mips/2018-09/msg00775.html


Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Yasha Cherikovsky (5):
  MIPS: Add support for the Lexra LX5280 CPU
  dt-binding: timer: Document RTL8186 SoC DT bindings
  dt-binding: interrupt-controller: Document RTL8186 SoC DT bindings
  dt-binding: mips: Document Realtek SoC DT bindings
  MIPS: Add Realtek RTL8186 SoC support

 .../interrupt-controller/realtek,rtl8186-intc |  18 ++
 .../devicetree/bindings/mips/realtek.txt      |   9 +
 .../bindings/timer/realtek,rtl8186-timer.txt  |  17 ++
 arch/mips/Kbuild.platforms                    |   1 +
 arch/mips/Kconfig                             |  47 +++-
 arch/mips/Makefile                            |   1 +
 arch/mips/boot/compressed/uart-16550.c        |   5 +
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/realtek/Makefile           |   4 +
 arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 ++++++
 .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 ++++
 arch/mips/configs/rtl8186_defconfig           | 112 ++++++++
 arch/mips/include/asm/cpu-features.h          |   3 +
 arch/mips/include/asm/cpu-type.h              |   4 +
 arch/mips/include/asm/cpu.h                   |   9 +
 arch/mips/include/asm/isadep.h                |   3 +-
 arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 +++
 arch/mips/include/asm/mipsregs.h              |  10 +
 arch/mips/include/asm/module.h                |   2 +
 arch/mips/include/asm/pgtable-32.h            |   7 +-
 arch/mips/include/asm/pgtable-bits.h          |   9 +-
 arch/mips/include/asm/pgtable.h               |   6 +-
 arch/mips/include/asm/stackframe.h            |   9 +-
 arch/mips/include/asm/traps.h                 |   2 +
 arch/mips/kernel/Makefile                     |   2 +
 arch/mips/kernel/cpu-probe.c                  |   6 +
 arch/mips/kernel/entry.S                      |   3 +-
 arch/mips/kernel/genex.S                      |   6 +-
 arch/mips/kernel/idle.c                       |  10 +
 arch/mips/kernel/process.c                    |   3 +-
 arch/mips/kernel/traps.c                      |  42 +++
 arch/mips/lib/Makefile                        |   1 +
 arch/mips/mm/Makefile                         |   1 +
 arch/mips/mm/c-lx5280.c                       | 251 ++++++++++++++++++
 arch/mips/mm/cache.c                          |   6 +
 arch/mips/mm/fault.c                          |   4 +
 arch/mips/mm/tlbex.c                          |   1 +
 arch/mips/rtl8186/Makefile                    |   2 +
 arch/mips/rtl8186/Platform                    |   7 +
 arch/mips/rtl8186/irq.c                       |   8 +
 arch/mips/rtl8186/prom.c                      |  15 ++
 arch/mips/rtl8186/setup.c                     |  80 ++++++
 arch/mips/rtl8186/time.c                      |  10 +
 drivers/clocksource/Kconfig                   |   9 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-rtl8186.c           | 220 +++++++++++++++
 drivers/irqchip/Kconfig                       |   5 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rtl8186.c                 | 107 ++++++++
 49 files changed, 1225 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc
 create mode 100644 Documentation/devicetree/bindings/mips/realtek.txt
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
 create mode 100644 arch/mips/boot/dts/realtek/Makefile
 create mode 100644 arch/mips/boot/dts/realtek/rtl8186.dtsi
 create mode 100644 arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts
 create mode 100644 arch/mips/configs/rtl8186_defconfig
 create mode 100644 arch/mips/include/asm/mach-rtl8186/rtl8186.h
 create mode 100644 arch/mips/mm/c-lx5280.c
 create mode 100644 arch/mips/rtl8186/Makefile
 create mode 100644 arch/mips/rtl8186/Platform
 create mode 100644 arch/mips/rtl8186/irq.c
 create mode 100644 arch/mips/rtl8186/prom.c
 create mode 100644 arch/mips/rtl8186/setup.c
 create mode 100644 arch/mips/rtl8186/time.c
 create mode 100644 drivers/clocksource/timer-rtl8186.c
 create mode 100644 drivers/irqchip/irq-rtl8186.c

-- 
2.19.0
