Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 10:29:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25188 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990509AbcKDJ3J0WgR0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 10:29:09 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 131CE432F5077;
        Fri,  4 Nov 2016 09:29:01 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 4 Nov 2016 09:29:02 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        James Hogan <james.hogan@imgtec.com>,
        Qais Yousef <qsyousef@gmail.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        <linux-kernel@vger.kernel.org>, Yang Shi <yang.shi@windriver.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] SMP Startup Improvements
Date:   Fri, 4 Nov 2016 09:28:55 +0000
Message-ID: <1478251738-13593-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55665
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


This series improves the startup of SMP processors for MIPS. Firstly,
replace the use of a bitmask of CPUs to detect secondard CPUs starting
with a completion event. This change means that secondary CPUs can fail
to start, and this will be detected and handled rather than hanging the
kernel.
The second patch removes the now redundant CPU bitmask.
The third patch improves error handling in the CPS SMP implementation.
In an unlikely corner case where no online CPU is available in a core
to start a secondary VPE, previously the kernel would BUG(), this patch
causes a warning to be printed and the situation handled more
gracefully.

This series is based on v4.9-rc1 and has been tested on Boston, Malta,
SEAD3, Octeon and Pistachio Ci40 platforms.



Matt Redfearn (3):
  MIPS: smp: Use a completion event to signal CPU up
  MIPS: smp: Remove cpu_callin_map
  MIPS: smp-cps: Don't BUG if a CPU fails to start

 arch/mips/cavium-octeon/smp.c         |  1 -
 arch/mips/include/asm/smp.h           |  2 --
 arch/mips/kernel/process.c            |  4 +---
 arch/mips/kernel/smp-bmips.c          |  1 -
 arch/mips/kernel/smp-cps.c            |  7 +++++--
 arch/mips/kernel/smp.c                | 17 +++++++++--------
 arch/mips/loongson64/loongson-3/smp.c |  1 -
 7 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.7.4
