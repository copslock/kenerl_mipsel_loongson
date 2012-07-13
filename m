Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:25:00 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1446 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903684Ab2GMQY1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:27 +0200
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:25 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:23:28 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 636B29F9F5; Fri, 13
 Jul 2012 09:24:08 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:07 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 00/12] Netlogic XLR/XLP updates.
Date:   Fri, 13 Jul 2012 21:53:13 +0530
Message-ID: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E94F73MK9921326-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
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

Fixes and updates for the Netlogic XLP code, this should apply cleanly
on top of the current linux-next tree.

Patch 1 (Netlogic: Fix indentation of smpboot.S) and patch 3
(Netlogic: merge of.c into setup.c) are fixups to the merge
fallout in linux-next.

Regards,
JC.

Ganesan Ramalingam (1):
  MIPS: Netlogic: DTS file for XLP boards

Jayachandran C (9):
  MIPS: Netlogic: Fix indentation of smpboot.S
  MIPS: Netlogic: Fix low-level flush on core wakeup
  MIPS: Netlogic: merge of.c into setup.c
  MIPS: Netlogic: remove cpu_has_dc_aliases define for XLP
  MIPS: PCI: Fix for byte swap for Netlogic XLP
  MIPS: Netlogic: early console fix
  MIPS: Netlogic: Move serial ports to device tree
  MIPS: Netlogic: Add support for built in DTB
  MIPS: Netlogic: XLP defconfig update

Madhusudan Bhat (1):
  MIPS: oprofile: Support for XLR/XLS processors

Zi Shen Lim (1):
  MIPS: perf: Add XLP support for hardware perf.

 arch/mips/Kconfig                                  |    3 +-
 arch/mips/configs/nlm_xlp_defconfig                |  133 +++++++++++++-------
 .../asm/mach-netlogic/cpu-feature-overrides.h      |    1 -
 arch/mips/kernel/perf_event_mipsxx.c               |  124 ++++++++++++++++++
 arch/mips/netlogic/Kconfig                         |   15 +++
 arch/mips/netlogic/Makefile                        |    1 +
 arch/mips/netlogic/common/earlycons.c              |    2 +-
 arch/mips/netlogic/common/smpboot.S                |   22 ++--
 arch/mips/netlogic/dts/Makefile                    |    4 +
 arch/mips/netlogic/dts/xlp_evp.dts                 |  124 ++++++++++++++++++
 arch/mips/netlogic/xlp/Makefile                    |    3 +-
 arch/mips/netlogic/xlp/of.c                        |   34 -----
 arch/mips/netlogic/xlp/platform.c                  |  108 ----------------
 arch/mips/netlogic/xlp/setup.c                     |   32 ++++-
 arch/mips/oprofile/Makefile                        |    1 +
 arch/mips/oprofile/common.c                        |    1 +
 arch/mips/oprofile/op_model_mipsxx.c               |   28 +++++
 arch/mips/pci/pci-xlp.c                            |    5 +-
 18 files changed, 437 insertions(+), 204 deletions(-)
 create mode 100644 arch/mips/netlogic/dts/Makefile
 create mode 100644 arch/mips/netlogic/dts/xlp_evp.dts
 delete mode 100644 arch/mips/netlogic/xlp/of.c
 delete mode 100644 arch/mips/netlogic/xlp/platform.c

-- 
1.7.9.5
