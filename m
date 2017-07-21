Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 18:55:50 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:37426 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993122AbdGUQznO1ITm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 18:55:43 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 546201A4A63;
        Fri, 21 Jul 2017 18:55:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 373F71A4A5F;
        Fri, 21 Jul 2017 18:55:37 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 0/8] MIPS: Add virtual Ranchu board as a generic-based board
Date:   Fri, 21 Jul 2017 18:53:29 +0200
Message-Id: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59201
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

v2->v3:

    - fixed configuration dependency for VIRTIO_NET and
        RTC_DRV_GOLDFISH
    - fixed frequency calculation in ranchu_measure_hpt_freq()
    - use DT info instead of hard-coding RTC base in
        ranchu_measure_hpt_freq()
    - Goldfish PIC reworked to follow legacy irq domain paradigm
    - Goldfish RTC reimplemented to support alarm functionality
    - added COMPILE_TEST to Goldfish PIC & RTC to extend compile
        test coverage
    - corrected location of documentation for Goldfish FB
    - added a patch on unselecting ARCH_MIGHT_HAVE_PC_SERIO
    - removed two patches on i8042 as not needed in new organization
    - removed the patch on separate Mips Android config as not needed
    - rebased to the latest code

v1->v2:

    - patch on RTC driver cleaned up
    - added drivers for virtio console and net to the Ranchu board
    - minor improvements in commit messages
    - updated recipient lists using get_maintainer.pl
    - rebased to the latest code

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

Aleksandar Markovic (4):
  Documentation: Add device tree binding for Goldfish RTC driver
  Documentation: Add device tree binding for Goldfish PIC driver
  Documentation: Add device tree binding for Goldfish FB driver
  video: goldfishfb: Add support for device tree bindings

Miodrag Dinic (4):
  MIPS: ranchu: Add Goldfish RTC driver
  MIPS: ranchu: Add Goldfish PIC driver
  MIPS: ranchu: Add Ranchu as a new generic-based board
  MIPS: Unselect ARCH_MIGHT_HAVE_PC_SERIO if MIPS_GENERIC

 .../bindings/display/google,goldfish-fb.txt        |  18 ++
 .../interrupt-controller/google,goldfish-pic.txt   |  18 ++
 .../bindings/rtc/google,goldfish-rtc.txt           |  17 ++
 MAINTAINERS                                        |  18 ++
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/configs/generic/board-ranchu.config      |  30 +++
 arch/mips/generic/Kconfig                          |  11 +
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ranchu.c                   |  76 +++++++
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-goldfish-pic.c                 | 142 +++++++++++++
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-goldfish.c                         | 233 +++++++++++++++++++++
 drivers/video/fbdev/goldfishfb.c                   |   8 +-
 16 files changed, 590 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 create mode 100644 arch/mips/configs/generic/board-ranchu.config
 create mode 100644 arch/mips/generic/board-ranchu.c
 create mode 100644 drivers/irqchip/irq-goldfish-pic.c
 create mode 100644 drivers/rtc/rtc-goldfish.c

-- 
2.7.4
