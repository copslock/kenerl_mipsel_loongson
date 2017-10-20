Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 16:35:20 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:33064 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992214AbdJTOfNbyitQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 16:35:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id EFAB11A4998;
        Fri, 20 Oct 2017 16:35:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id D04641A492C;
        Fri, 20 Oct 2017 16:35:06 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 0/5] MIPS: Add virtual Ranchu board as a generic-based board
Date:   Fri, 20 Oct 2017 16:33:33 +0200
Message-Id: <1508510055-6167-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60500
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

v4->v5:

    - removed RTC clock-related patches since they are already applied
    - removed 8042-related patch since this issue is expected to be
      resolved on the whole platform level
    - redesigned Goldfish PIC driver
    - updated email adresses in commit messages and MAINTAINERS file
      to contain "@mips.com" instead of "@imgtec.com"
    - used "MIPS" instead of "Mips" in commit messages
    - rebased to the latest code

v3->v4:

    - corrected RTC clock patch so that it does not cause build
      errors for some targets, and limited compile support to MIPS
      architecture, since it is the only case where this driver is
      used
    - changed titles of patches 2 and 4 to make them consistent
      with commit messages of corresponding directories
    - applied "checkpatch --strict" to the whole series and
      corrected several instances of reported warnings
    - rebased to the latest code

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
    - removed the patch on separate MIPS Android config as not needed
    - rebased to the latest code

v1->v2:

    - patch on RTC driver cleaned up
    - added drivers for virtio console and net to the Ranchu board
    - minor improvements in commit messages
    - updated recipient lists using get_maintainer.pl
    - rebased to the latest code

This series adds MIPS Ranchu virtual machine used by Android emulator.
The board relies on the concept of MIPS generic boards, and utilizes
generic board framework for build and device organization.

The Ranchu board is intended to be used by Android emulator.The name
"Ranchu" originates from Android development community. "Goldfish" and
"Ranchu" are names for two generations of virtual boards used by
Android emulator. "Ranchu" is a newer one among the two, and this
series deals with Ranchu. However, for historical reasons, some file,
device, and variable names in this series still contain the word
"Goldfish".

MIPS Ranchu machine includes a number of Goldfish devices. The
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

Aleksandar Markovic (2):
  Documentation: Add device tree binding for Goldfish FB driver
  video: goldfishfb: Add support for device tree bindings

Miodrag Dinic (3):
  Documentation: Add device tree binding for Goldfish PIC driver
  irqchip/irq-goldfish-pic: Add Goldfish PIC driver
  MIPS: ranchu: Add Ranchu as a new generic-based board

 .../bindings/display/google,goldfish-fb.txt        |  18 +++
 .../interrupt-controller/google,goldfish-pic.txt   |  30 +++++
 MAINTAINERS                                        |  12 ++
 arch/mips/configs/generic/board-ranchu.config      |  30 +++++
 arch/mips/generic/Kconfig                          |  10 ++
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ranchu.c                   |  78 ++++++++++++
 drivers/irqchip/Kconfig                            |   8 ++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-goldfish-pic.c                 | 131 +++++++++++++++++++++
 drivers/video/fbdev/goldfishfb.c                   |   8 +-
 11 files changed, 326 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
 create mode 100644 arch/mips/configs/generic/board-ranchu.config
 create mode 100644 arch/mips/generic/board-ranchu.c
 create mode 100644 drivers/irqchip/irq-goldfish-pic.c

-- 
2.7.4
