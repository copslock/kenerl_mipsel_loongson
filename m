Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 10:37:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26077 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008707AbaIKIhg6VWDm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 10:37:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 973E77F32B97;
        Thu, 11 Sep 2014 09:37:28 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 09:37:30 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 11 Sep 2014 08:31:19 +0100
Received: from pburton-laptop.home (192.168.159.78) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 08:30:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/10] MIPS O32 new FP ABI support
Date:   Thu, 11 Sep 2014 08:30:13 +0100
Message-ID: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.78]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series introduces support for reading the FP mode requirements of
ELF binaries from their .MIPS.abiflags section when present, and
configuring the system appropriately. The motivation for these new ABIs
is to enable O32 binaries to operate with a 64b FPU (Status.FR=1) and
therefore to run on systems where that is the only FPU available, allow
use of MSA & do so without rebuilding the world. For further details on
the new ABIs please see:

  https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking

The first 3 patches of the series extend binfmt_elf with hooks such that
the MIPS architecture code can access the FP mode information & reject
invalid FP modes.

Patches 4-7 introduce support for operating with "hybrid FPRs" - a
scheme in which odd single precision registers alias with the upper 32b
of the preceeding even double as is typical with FR=0, but where all
32 64b doubles are also available. This is implemented by trapping &
emulating single precision register accesses using a new Config5.FRE
bit.

Patches 8 & 9 introduce the .MIPS.abiflags section along with the kernel
support for reading it & treating binaries accordingly.

Patch 10 adds a simple debug option to test the implementation of hybrid
FPRs by forcing all code that can operate in that mode to do so, which
is usually avoided due to the overhead of trapping & emulating.

Paul Burton (10):
  binfmt_elf: hoist ELF program header loading to a function
  binfmt_elf: load interpreter program headers earlier
  binfmt_elf: allow arch code to examine PT_LOPROC ... PT_HIPROC headers
  MIPS: define bits introduced for hybrid FPRs
  MIPS: detect presence of the FRE & UFR bits
  MIPS: ensure Config5.UFE is clear on boot
  MIPS: support for hybrid FPRs
  MIPS: ELF: add definition for the .MIPS.abiflags section
  MIPS: ELF: set FP mode according to .MIPS.abiflags
  MIPS: Kconfig option to better exercise/debug hybrid FPRs

 arch/mips/Kconfig                    |   1 +
 arch/mips/Kconfig.debug              |  13 +++
 arch/mips/include/asm/cpu-features.h |   4 +
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/elf.h          |  74 +++++++++++---
 arch/mips/include/asm/fpu.h          |  49 ++++++++--
 arch/mips/include/asm/mipsregs.h     |   3 +
 arch/mips/include/asm/thread_info.h  |   2 +
 arch/mips/kernel/Makefile            |   7 +-
 arch/mips/kernel/cpu-probe.c         |   4 +-
 arch/mips/kernel/elf.c               | 181 +++++++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c             |  47 +++++++++
 arch/mips/math-emu/cp1emu.c          |   9 +-
 fs/Kconfig.binfmt                    |   3 +
 fs/binfmt_elf.c                      | 169 ++++++++++++++++++++------------
 include/linux/elf.h                  |  73 ++++++++++++++
 16 files changed, 549 insertions(+), 91 deletions(-)
 create mode 100644 arch/mips/kernel/elf.c

-- 
2.0.4
