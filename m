Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 16:35:05 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:45633 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990864AbcJQOe7Pnhi4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 16:34:59 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E7C55D6B1CF5A;
        Mon, 17 Oct 2016 15:34:49 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 15:34:53 +0100
Received: from localhost (10.100.200.11) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 15:34:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/4] MIPS: Pre-r6 emulation cleanup
Date:   Mon, 17 Oct 2016 15:34:34 +0100
Message-ID: <20161017143438.17298-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.11]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55454
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

This series cleans up the code used to emulate pre-r6 instructions that
were removed by MIPSr6 when running on a MIPSr6 CPU. It also removes the
dependency of the pre-r6 emulation code on uniprocessor kernels, since
there's no reason it shouldn't work with SMP kernels.

Applies atop v4.9-rc1.


Paul Burton (4):
  MIPS: Remove r2_emul_return from struct thread_info
  MIPS: Cleanup LLBit handling in switch_to
  MIPS: Allow pre-r6 emulation on SMP MIPSr6 kernels
  MIPS: Remove RESTORE_ALL_AND_RET

 arch/mips/Kconfig                   |  4 +---
 arch/mips/include/asm/stackframe.h  | 12 ++++--------
 arch/mips/include/asm/switch_to.h   | 18 ++++++++++++------
 arch/mips/include/asm/thread_info.h |  1 -
 arch/mips/kernel/asm-offsets.c      |  1 -
 arch/mips/kernel/entry.S            | 18 ------------------
 arch/mips/kernel/traps.c            |  2 --
 7 files changed, 17 insertions(+), 39 deletions(-)

-- 
2.10.0
