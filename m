Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 14:23:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32482 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992864AbdHHMW5MvwGG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 14:22:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 418998B0FC7B5;
        Tue,  8 Aug 2017 13:22:46 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 8 Aug 2017 13:22:49 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 0/6] MIPS: Further microMIPS stack unwinding fixes
Date:   Tue, 8 Aug 2017 13:22:29 +0100
Message-ID: <1502194955-18018-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59418
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

Commit 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
added support for unwinding the stack on microMIPS, which has a mix of
16 and 32bit sized instructions. Unfortunately a lot of the code
introduced had bugs which prevented it working correctly in all cases.
This series aims to address those issues. The series also provides
additional fixup to some changes made in v4.11, which also aimed to
address errors in commit 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned
access support.").

These patches have been tested on qemu M14Kc micromips and tested for
regression on ci40, Boston, Octeon III & malta.

For ease of backport, I have opted to just fix the issues with the
existing code to start off with, despite the violations of the code
style in the areas being fixed. The final patch in the series refactors
the is_sp_move_ins function so that it compiles with the coding
standard.

This series is based on v4.13-rc4.


Changes in v3:
- Remove hack which attempted to cope with 16bit instructions
- New patch to fix detection of addiusp instruction
- Deal with special behaviour of addiusp immediates 0x0,0x1,0x1fe & 0x1ff
- New patch to fix big endian systems

Changes in v2:
- Keep locals in reverse christmas tree order
- Replace conditional with xor and subtract
- Refactor is_sp_move_ins to interpret immediate inline.

Matt Redfearn (6):
  MIPS: Handle non word sized instructions when examining frame
  MIPS: microMIPS: Fix detection of addiusp instruction
  MIPS: microMIPS: Fix decoding of addiusp instruction
  MIPS: microMIPS: Fix decoding of swsp16 instruction
  MIPS: Stacktrace: Fix  microMIPS stack unwinding on big endian systems
  MIPS: Refactor handling of stack pointer in get_frame_info

 arch/mips/include/uapi/asm/inst.h |  2 +-
 arch/mips/kernel/process.c        | 80 ++++++++++++++++++++-------------------
 2 files changed, 43 insertions(+), 39 deletions(-)

-- 
2.7.4
