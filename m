Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:04:12 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2705 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825882Ab2JaM7ApFGOM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:59:00 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:56:35 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:57:52 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 15A6040FE3; Wed, 31
 Oct 2012 05:58:20 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 00/15] Netlogic XLR/XLS/XLP updates
Date:   Wed, 31 Oct 2012 18:31:26 +0530
Message-ID: <cover.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7C8FFF893QC1968348-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Here's is the next patchset for Netlogic XLR/XLS/XLP CPUs. The 
highlights are:
 * Support for XLP multi-chip boards, this feature allows two or four
   XLPs to be connected using an interconnect(ICI) to form a coherent
   SMP system with upto 128 cpus (only 64 supported now).
 * Support for XLR/XLS fast message network. The XLR/XLS CPU cores
   talk to the high speed interfaces using a messaging mechanism
   which uses the co-processor 2 on the CPU core. The code is to
   intialize the bucket (message queue) sizes, and to distribute
   credits on the queues to the devices (stations).
 * oprofile support for XLR and perf support for XLP (this has been
   posted a few times)

The patchset also includes few fixes to the XLR/XLS/XLP code.

JC.

Ganesan Ramalingam (1):
  MIPS: Netlogic: Support for XLR/XLS Fast Message Network

Jayachandran C (12):
  MIPS: Netlogic: select MIPSR2 for XLP
  MIPS: Netlogic: Enable SUE bit in cores
  MIPS: Netlogic: keep .dtb/.dtb.S until make clean
  MIPS: Netlogic: Move fdt init to plat_mem_setup
  MIPS: Netlogic: Fix DMA zone selection for 64-bit
  MIPS: Netlogic: Fix interrupt table entry init
  MIPS: Netlogic: Pass cpuid to early_init_secondary
  MIPS: Netlogic: Update PIC access functions
  MIPS: Netlogic: Move from u32 cpumask to cpumask_t
  MIPS: Netlogic: Support for multi-chip configuration
  MIPS: Netlogic: Make number of nodes configurable
  MIPS: Netlogic: PIC IRQ handling update for multi-chip

Madhusudan Bhat (1):
  MIPS: oprofile: Support for XLR/XLS processors

Zi Shen Lim (1):
  MIPS: perf: Add XLP support for hardware perf.

 arch/mips/Kconfig                                |    9 +-
 arch/mips/include/asm/mach-netlogic/irq.h        |    4 +-
 arch/mips/include/asm/mach-netlogic/multi-node.h |   54 ++++
 arch/mips/include/asm/netlogic/common.h          |   51 ++-
 arch/mips/include/asm/netlogic/interrupt.h       |    2 +-
 arch/mips/include/asm/netlogic/mips-extns.h      |  142 +++++++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h     |   44 +--
 arch/mips/include/asm/netlogic/xlp-hal/sys.h     |    1 -
 arch/mips/include/asm/netlogic/xlr/fmn.h         |  363 ++++++++++++++++++++++
 arch/mips/include/asm/netlogic/xlr/pic.h         |    2 -
 arch/mips/include/asm/netlogic/xlr/xlr.h         |    6 +-
 arch/mips/kernel/perf_event_mipsxx.c             |  124 ++++++++
 arch/mips/netlogic/Kconfig                       |   28 ++
 arch/mips/netlogic/common/irq.c                  |  165 ++++++----
 arch/mips/netlogic/common/smp.c                  |   89 +++---
 arch/mips/netlogic/common/smpboot.S              |    6 +-
 arch/mips/netlogic/dts/Makefile                  |   16 +-
 arch/mips/netlogic/xlp/nlm_hal.c                 |   67 +---
 arch/mips/netlogic/xlp/setup.c                   |   50 +--
 arch/mips/netlogic/xlp/wakeup.c                  |   83 +++--
 arch/mips/netlogic/xlr/Makefile                  |    4 +-
 arch/mips/netlogic/xlr/fmn-config.c              |  290 +++++++++++++++++
 arch/mips/netlogic/xlr/fmn.c                     |  204 ++++++++++++
 arch/mips/netlogic/xlr/setup.c                   |   37 ++-
 arch/mips/netlogic/xlr/wakeup.c                  |   23 +-
 arch/mips/oprofile/Makefile                      |    1 +
 arch/mips/oprofile/common.c                      |    1 +
 arch/mips/oprofile/op_model_mipsxx.c             |   29 ++
 28 files changed, 1620 insertions(+), 275 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/multi-node.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/fmn.h
 create mode 100644 arch/mips/netlogic/xlr/fmn-config.c
 create mode 100644 arch/mips/netlogic/xlr/fmn.c

-- 
1.7.9.5
