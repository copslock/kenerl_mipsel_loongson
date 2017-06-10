Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:27:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51486 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993949AbdFJA1Fp7nXt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:27:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4A24D6340115D;
        Sat, 10 Jun 2017 01:26:58 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:26:59
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/11] MIPS: cmpxchg(), xchg() fixes & queued locks
Date:   Fri, 9 Jun 2017 17:26:32 -0700
Message-ID: <20170610002644.8434-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58389
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

This series makes a bunch of cleanups & improvements to the cmpxchg() &
xchg() macros & functions, allowing them to be used on values smaller
than 4 bytes, then switches MIPS over to use generic queued spinlocks &
queued read/write locks.

Applies atop v4.12-rc4.

Paul Burton (11):
  MIPS: cmpxchg: Unify R10000_LLSC_WAR & non-R10000_LLSC_WAR cases
  MIPS: cmpxchg: Pull xchg() asm into a macro
  MIPS: cmpxchg: Use __compiletime_error() for bad cmpxchg() pointers
  MIPS: cmpxchg: Error out on unsupported xchg() calls
  MIPS: cmpxchg: Drop __xchg_u{32,64} functions
  MIPS: cmpxchg: Implement __cmpxchg() as a function
  MIPS: cmpxchg: Implement 1 byte & 2 byte xchg()
  MIPS: cmpxchg: Implement 1 byte & 2 byte cmpxchg()
  MIPS: cmpxchg: Rearrange __xchg() arguments to match xchg()
  MIPS: Use queued read/write locks (qrwlock)
  MIPS: Use queued spinlocks (qspinlock)

 arch/mips/Kconfig                      |   2 +
 arch/mips/include/asm/Kbuild           |   2 +
 arch/mips/include/asm/cmpxchg.h        | 280 ++++++++++------------
 arch/mips/include/asm/spinlock.h       | 426 +--------------------------------
 arch/mips/include/asm/spinlock_types.h |  34 +--
 arch/mips/kernel/Makefile              |   2 +-
 arch/mips/kernel/cmpxchg.c             | 109 +++++++++
 7 files changed, 239 insertions(+), 616 deletions(-)
 create mode 100644 arch/mips/kernel/cmpxchg.c

-- 
2.13.1
