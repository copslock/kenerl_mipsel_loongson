Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:50:51 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55267 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993982AbdF1PunZWQy8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:50:43 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 188C61A4733;
        Wed, 28 Jun 2017 17:50:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id EF0AF1A46B7;
        Wed, 28 Jun 2017 17:50:36 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 00/10] MIPS: Add virtual Ranchu board as a generic-based board
Date:   Wed, 28 Jun 2017 17:46:53 +0200
Message-Id: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58860
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

Aleksandar Markovic (6):
  Documentation: Add device tree binding for Goldfish RTC driver
  MIPS: ranchu: Add Goldfish RTC driver
  Documentation: Add device tree binding for Goldfish PIC driver
  MIPS: ranchu: Add Goldfish PIC driver
  Documentation: Add device tree binding for Goldfish FB driver
  video: goldfishfb: Add support for device tree bindings

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
 arch/mips/configs/generic/board-ranchu.config      |  25 +++
 arch/mips/generic/Kconfig                          |  11 ++
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ranchu.c                   |  83 ++++++++++
 arch/mips/include/asm/io.h                         |   5 +
 arch/mips/kernel/setup.c                           |  41 +++++
 drivers/input/serio/i8042-io.h                     |   2 +-
 drivers/irqchip/Kconfig                            |   9 ++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-goldfish-pic.c                 | 169 ++++++++++++++++++++
 drivers/rtc/Kconfig                                |   6 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-goldfish.c                         | 136 ++++++++++++++++
 drivers/video/fbdev/goldfishfb.c                   |   8 +-
 20 files changed, 747 insertions(+), 4 deletions(-)
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
