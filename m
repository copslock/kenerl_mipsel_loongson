Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:50:23 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58783 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991957AbdFSPtwRYCDH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:49:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 60A031A46A0;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 3DEB91A2452;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 00/10] MIPS: Add virtual Ranchu board as a generic-based board
Date:   Mon, 19 Jun 2017 17:49:30 +0200
Message-Id: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

This series adds Mips Ranchu virtual machine used by Android emulator.
The board relies on the concept of Mips generic boards, and utilizes
generic board framework for build and device organization.

The Ranchu board is intended to be used by Android emulator.The name
"Ranchu" originates from Android development community. "Goldfish" and
"Ranchu" are names for two generations of virtual boards used by
Android emulator. "Ranchu" is a newer one among the two, and this
series deals with Ranchu. However, for historical reasons, some file,
device, and variable names in this series still contain the word
"Goldfish".

Mips Ranchu machine includes a number of Goldfish devices. The
support for Virtio devices is also included. Ranchu board supports
up to 16 virtio devices which can be attached using virtio MMIO Bus.
This is summarized in the following picture:

       ABUS
        ||----MIPS CPU
        ||       |                    IRQs
        ||----Goldfish PIC------------(32)--------
        ||                     | | | | | | | | |
        ||----Goldfish TTY------ | | | | | | | |
        ||                       | | | | | | | |
        ||----Goldfish RTC-------- | | | | | | |
        ||                         | | | | | | |
        ||----Goldfish FB----------- | | | | | |
        ||                           | | | | | |
        ||----Goldfish Events--------- | | | | |
        ||                             | | | | |
        ||----Goldfish Audio------------ | | | |
        ||                               | | | |
        ||----Goldfish Battery------------ | | |
        ||                                 | | |
        ||----Android PIPE------------------ | |
        ||                                   | |
        ||----Virtio MMIO Bus                | |
        ||    |    |    |                    | |
        ||    |    |   (virtio-block)--------- |
        ||   (16)  |                           |
        ||    |   (virtio-net)------------------


Device Tree is created on the QEMU side based on the information about
devices IO map and IRQ numbers. Kernel will load this DTB using UHI
boot protocol.

Checkpatch script outputs a small number of warnings if applied to
this series. We did not correct the code, since we think the code is
correct for those particular cases of checkpatch warnings.

Aleksandar Markovic (6):
  Documentation: Add device tree binding for Goldfish RTC driver
  MIPS: ranchu: Add Goldfish RTC driver
  Documentation: Add device tree binding for Goldfish PIC driver
  MIPS: ranchu: Add Goldfish PIC driver
  Documentation: Add device tree binding for Goldfish FB driver
  video: goldfishfb: Add driver support for device tree bindings

Miodrag Dinic (4):
  MIPS: ranchu: Add Ranchu as a new generic-based board
  MIPS: Introduce check_legacy_ioport() interface
  MIPS: i8042: Probe this device only if it exists
  MIPS: generic: Add optional support for Android kernel

 .../bindings/goldfish/google,goldfish-fb.txt       |  18 +++
 .../interrupt-controller/google,goldfish-pic.txt   |  18 +++
 .../bindings/rtc/google,goldfish-rtc.txt           |  17 ++
 MAINTAINERS                                        |  19 +++
 arch/mips/Makefile                                 |   8 +-
 arch/mips/configs/generic/android.config           | 173 +++++++++++++++++++++
 arch/mips/configs/generic/board-ranchu.config      |  23 +++
 arch/mips/generic/Kconfig                          |  11 ++
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ranchu.c                   |  83 ++++++++++
 arch/mips/include/asm/io.h                         |   5 +
 arch/mips/kernel/setup.c                           |  43 +++++
 drivers/input/serio/i8042-io.h                     |   2 +-
 drivers/irqchip/Kconfig                            |   9 ++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-goldfish-pic.c                 | 171 ++++++++++++++++++++
 drivers/rtc/Kconfig                                |   6 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-goldfish.c                         | 149 ++++++++++++++++++
 drivers/video/fbdev/goldfishfb.c                   |   8 +-
 20 files changed, 762 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/goldfish/google,goldfish-fb.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 create mode 100644 arch/mips/configs/generic/android.config
 create mode 100644 arch/mips/configs/generic/board-ranchu.config
 create mode 100644 arch/mips/generic/board-ranchu.c
 create mode 100644 drivers/irqchip/irq-goldfish-pic.c
 create mode 100644 drivers/rtc/rtc-goldfish.c

-- 
2.7.4
