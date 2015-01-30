Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 13:10:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42145 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011134AbbA3MKDnP0qK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 13:10:03 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9DF00901517FF
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 12:09:55 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 12:09:57 +0000
Received: from localhost (192.168.159.167) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 12:09:56 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 00/10] FP/MSA fixes
Date:   Fri, 30 Jan 2015 12:09:29 +0000
Message-ID: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.167]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45562
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

This series fixes a bunch of bugs, both build & runtime, with FP & MSA
support. Most of them only affect systems with the new FP modes & MSA
support enabled.

Changes in v2:
  - Rebase atop v3.19-rc6.

James Hogan (2):
  Revert "MIPS: Don't assume 64-bit FP registers for context switch"
  MIPS: MSA: Fix big-endian FPR_IDX implementation

Paul Burton (8):
  MIPS: push .set arch=r4000 into the functions needing it
  MIPS: assume at as source/dest of MSA copy/insert instructions
  MIPS: remove MSA macro recursion
  MIPS: wrap cfcmsa & ctcmsa accesses for toolchains with MSA support
  MIPS: clear MSACSR cause bits when handling MSA FP exception
  MIPS: ensure FCSR cause bits are clear after invoking FPU emulator
  MIPS: prevent FP context set via ptrace being discarded
  MIPS: disable FPU if the mode is unsupported

 arch/mips/include/asm/asmmacro-32.h | 128 ++++++++++-----------
 arch/mips/include/asm/asmmacro.h    | 218 +++++++++++++++++++++---------------
 arch/mips/include/asm/fpu.h         |  19 ++--
 arch/mips/include/asm/processor.h   |   2 +-
 arch/mips/kernel/asm-offsets.c      |  66 -----------
 arch/mips/kernel/genex.S            |  11 +-
 arch/mips/kernel/ptrace.c           |  30 ++++-
 arch/mips/kernel/r4k_fpu.S          |   2 +-
 arch/mips/kernel/traps.c            |  17 +--
 9 files changed, 248 insertions(+), 245 deletions(-)

-- 
2.2.2
