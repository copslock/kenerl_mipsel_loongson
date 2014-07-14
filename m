Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 11:14:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39774 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6856070AbaGNJOWouqHk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 11:14:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6D94592EB8E5
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 10:14:14 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:14:15 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:14:15 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/5] Add support for HardWare Table Walker for 32-bit cores
Date:   Mon, 14 Jul 2014 10:14:01 +0100
Message-ID: <1405329246-21643-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

This patch adds support for the HardWare Table Walker which acts as a
hardware fast-path for the TLB Refill handler. The patch only allows 32-bit cores
to use this feature since it has only been tested on such targets. A new kernel
parameters is added, called 'nohwtw' to disable the feature and use the
regular TLB refill handler.

The patch is based on v3.16-rc5

Markos Chandras (5):
  MIPS: cpu-info: Change the cpu options variable to unsigned long long
  MIPS: cpu: Add new cpu option for HardWare Table Walker.
  MIPS: asm: Add register definitions for Hardware Table Walker
  MIPS: kernel: cpu-probe: Add support for the HardWare Table Walker
  MIPS: mm: Use the HardWare Page Table Walker if the core supports it

 arch/mips/include/asm/cpu-features.h |  4 ++
 arch/mips/include/asm/cpu-info.h     |  2 +-
 arch/mips/include/asm/cpu.h          | 57 +++++++++++-----------
 arch/mips/include/asm/mipsregs.h     | 44 +++++++++++++++++
 arch/mips/include/asm/mmu_context.h  | 10 ++++
 arch/mips/include/asm/pgtable.h      | 27 +++++++++++
 arch/mips/kernel/cpu-probe.c         | 23 +++++++++
 arch/mips/kernel/proc.c              |  1 +
 arch/mips/mm/tlb-r4k.c               | 13 +++++-
 arch/mips/mm/tlbex.c                 | 91 ++++++++++++++++++++++++++++++++++++
 10 files changed, 242 insertions(+), 30 deletions(-)

-- 
2.0.0
