Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2016 15:43:47 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:28690 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992143AbcJKNmtG2rKK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2016 15:42:49 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id BC7624A761DA0;
        Tue, 11 Oct 2016 14:42:37 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Oct 2016
 14:42:40 +0100
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 11 Oct 2016 14:42:40 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-remoteproc@vger.kernel.org>,
        <lisa.parratt@imgtec.com>, <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 0/4] MIPS: Remote processor driver
Date:   Tue, 11 Oct 2016 14:42:32 +0100
Message-ID: <1476193356-1350-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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


The MIPS remote processor driver allows non-Linux firmware to take
control of and execute on one of the systems VPEs. The CPU must be
offlined from Linux first. A sysfs interface is created which allows
firmware to be loaded and changed at runtime. A full description is
available at [1]. An example firmware that can be used with this driver
is available at [2].

This is useful to allow running bare metal code, or an RTOS, on one or
more CPUs while allowing Linux to continue running on those remaining.

The remote processor framework allows for firmwares to provide any
virtio device for communication between the firmware running on the
remote VP and Linux. For example [1] demonstrates a simple firmware
which provides a virtual serial port. Any string sent to the port is
case inverted and returned.

This is conceptually similar to the VPE loader functionality, but is
more standard as it fits into the remoteproc subsystem.

The first patches in this series lay the groundwork for the driver
before it is added. The last series deprecates the VPE loader.

This functionality is supported on:
- MIPS32r2 devices implementing the MIPS MT ASE for multithreading, such
  as interAptiv.
- MIPS32r6 devices implementing VPs, such as I6400.

Limitations:
- The remoteproc core supports only 32bit ELFs. Therefore it is only
  possible to run 32bit firmware on the remote processor. Also, for
  virtio communication, pointers are passed from the kernel to firmware.
  There can be no mismatch in pointer sizes between the kernel and
  firmware, so this limits the host kernel to 32bit as well.

The functionality has been tested on the Ci40 board which has a 2 core 2
thread interAptiv.

This series is based on v4.8

Depends on James Hogan's ebase series:
MIPS: traps: 64bit kernels should read CP0_EBase 64bit
MIPS: traps: Convert ebase to KSeg0
MIPS: traps: Ensure full EBase is written

Without these patches, if firmware modifies ebase to allow handling
exceptions / interrupts, then when the VPE is returned to Linux the
kernel exception handlers won't be reinstated properly.

[1]
http://wiki.prplfoundation.org/w/images/d/df/MIPS_OS_Remote_Processor_Driver_Whitepaper_1.0.9.pdf
[2] https://github.com/MIPS/mips-rproc-example


Changes in v3:
Update GIC context saving to use CPU hotplug state machine
Update MIPS remoteproc driver to use CPU hotplug state machine
Remove sysfs interface from MIPS rproc driver, now provided by the core.
Drop patches that Ralf has already merged to mips-next

Changes in v2:
Add dependence on additional patches to mips-gic in commit log
Incorporate changes from Marc Zynger's review:
- Remove CONTEXT_SAVING define.
- Make saved local state a per-cpu variable
- Make gic_save_* static functions when enabled, and do { } while(0)
  otherwise

Lisa Parratt (1):
  MIPS: CPS: Add VP(E) stealing

Matt Redfearn (3):
  irqchip: mips-gic: Add context saving for MIPS_REMOTEPROC
  remoteproc/MIPS: Add a remoteproc driver for MIPS
  MIPS: Deprecate VPE Loader

 arch/mips/Kconfig                    |  12 +-
 arch/mips/include/asm/smp-cps.h      |   8 +
 arch/mips/include/asm/smp.h          |   1 +
 arch/mips/kernel/smp-cps.c           | 162 +++++++++-
 arch/mips/kernel/smp.c               |  12 +
 drivers/irqchip/irq-mips-gic.c       | 208 ++++++++++++-
 drivers/remoteproc/Kconfig           |  11 +
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/mips_remoteproc.c | 566 +++++++++++++++++++++++++++++++++++
 9 files changed, 966 insertions(+), 15 deletions(-)
 create mode 100644 drivers/remoteproc/mips_remoteproc.c

-- 
2.7.4
