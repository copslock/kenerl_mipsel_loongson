Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 00:38:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49052 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdFBWidLmeM3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 00:38:33 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9A20889132F47
        for <linux-mips@linux-mips.org>; Fri,  2 Jun 2017 23:38:22 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 23:38:26
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/6] MIPS: TLB exception handler fixes & optimisation
Date:   Fri, 2 Jun 2017 15:38:00 -0700
Message-ID: <20170602223806.5078-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58164
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

This series fixes a race condition during in TLB exceptions for I6400 &
I6500 CPUs where TLB RAMs are shared between threads/VPs within a core,
and implements a few optimisations & cleanups for TLB exception
handling.

Applies atop v4.12-rc3.

Paul Burton (6):
  MIPS: Add CPU shared FTLB feature detection
  MIPS: Handle tlbex-tlbp race condition
  MIPS: Allow storing pgd in C0_CONTEXT for MIPSr6
  MIPS: Use current_cpu_type() in m4kc_tlbp_war()
  MIPS: tlbex: Use ErrorEPC as scratch when KScratch isn't available
  MIPS: tlbex: Remove struct work_registers

 arch/mips/Kconfig                    |   2 +-
 arch/mips/include/asm/cpu-features.h |  41 ++++++
 arch/mips/include/asm/cpu.h          |   4 +
 arch/mips/kernel/cpu-probe.c         |  11 ++
 arch/mips/mm/tlbex.c                 | 234 +++++++++++++++++------------------
 5 files changed, 169 insertions(+), 123 deletions(-)

-- 
2.13.0
