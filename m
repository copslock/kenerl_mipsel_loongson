Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 15:41:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27571 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993637AbdCAOleTEnBI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2017 15:41:34 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7B5529BFBA2A0;
        Wed,  1 Mar 2017 14:41:25 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 1 Mar 2017 14:41:28 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/5] MIPS: Further microMIPS stack unwinding fixes
Date:   Wed, 1 Mar 2017 14:41:15 +0000
Message-ID: <1488379280-2954-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56941
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

4.11 includes a bunch of stack unwinding fixes for microMIPS, but some
of those fixes require additional fixup, provided by this series.
These patches have been tested on qemu M14Kc micromips and tested for
regression on ci40, Boston, Octeon III & malta.

This series is based on mips-for-linux-next

Changes in v2:
- Keep locals in reverse christmas tree order
- Replace conditional with xor and subtract
- Refactor is_sp_move_ins to interpret immediate inline.

Matt Redfearn (5):
  MIPS: Handle non word sized instructions when examining frame
  MIPS: microMIPS: Fix decoding of addiusp instruction
  MIPS: Refactor handling of stack pointer in get_frame_info
  MIPS: Stacktrace: Fix __usermode() of uninitialised regs
  MIPS: microMIPS: Fix decoding of swsp16 instruction

 arch/mips/include/asm/stacktrace.h |  3 ++
 arch/mips/include/uapi/asm/inst.h  |  2 +-
 arch/mips/kernel/process.c         | 66 ++++++++++++++++++++------------------
 3 files changed, 39 insertions(+), 32 deletions(-)

-- 
2.7.4
