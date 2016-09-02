Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 12:00:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19796 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990864AbcIBKA0qO-Xz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 12:00:26 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 13D03D167A38E;
        Fri,  2 Sep 2016 11:00:08 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Sep 2016 11:00:10 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <lisa.parratt@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Hugh Dickins <hughd@google.com>,
        Qais Yousef <qsyousef@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Huacai Chen <chenhc@lemote.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/6] MIPS: Remote processor driver
Date:   Fri, 2 Sep 2016 10:59:49 +0100
Message-ID: <1472810395-21381-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54975
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
remote VPE and Linux. For example [2] demonstrates a simple firmware
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

This series is based on v4.8-rc4.

Depends on some patches from James Hogan's recent "MIPS: General EVA fixes &
cleanups" series:
MIPS: traps: 64bit kernels should read CP0_EBase 64bit
MIPS: traps: Convert ebase to KSeg0
MIPS: traps: Ensure full EBase is written

Without these patches, if firmware modifies ebase to allow handling
exceptions / interrupts, then when the VPE is returned to Linux the
kernel exception handlers won't be reinstated properly.

[1] http://wiki.prplfoundation.org/w/images/d/df/MIPS_OS_Remote_Processor_Driver_Whitepaper_1.0.9.pdf
[2] https://github.com/MIPS/mips-rproc-example



Lisa Parratt (1):
  MIPS: CPS: Add VP(E) stealing

Matt Redfearn (5):
  irqchip: mips-gic: Add context saving for MIPS_REMOTEPROC
  MIPS: tlb-r4k: If there are wired entries, don't use TLBINVF
  MIPS: smp.c: Introduce mechanism for freeing and allocating IPIs
  remoteproc/MIPS: Add a remoteproc driver for MIPS
  MIPS: Deprecate VPE Loader

 Documentation/ABI/testing/sysfs-class-mips-rproc |  24 +
 arch/mips/Kconfig                                |  12 +-
 arch/mips/include/asm/smp-cps.h                  |   8 +
 arch/mips/include/asm/smp.h                      |  15 +
 arch/mips/kernel/smp-cps.c                       | 162 +++++-
 arch/mips/kernel/smp.c                           |  73 ++-
 arch/mips/mm/tlb-r4k.c                           |   7 +-
 drivers/irqchip/irq-mips-gic.c                   | 185 ++++++-
 drivers/remoteproc/Kconfig                       |  11 +
 drivers/remoteproc/Makefile                      |   1 +
 drivers/remoteproc/mips_remoteproc.c             | 651 +++++++++++++++++++++++
 11 files changed, 1124 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-mips-rproc
 create mode 100644 drivers/remoteproc/mips_remoteproc.c

-- 
2.7.4
