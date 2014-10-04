Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2014 05:17:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56281 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008971AbaJDDRYI1p0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Oct 2014 05:17:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 04E943E695205;
        Sat,  4 Oct 2014 04:17:16 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 4 Oct
 2014 04:17:16 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 4 Oct
 2014 04:17:16 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 3 Oct 2014
 20:17:14 -0700
Subject: [PATCH 0/3] MIPS executable stack protection
To:     <linux-mips@linux-mips.org>, <Zubair.Kakakhel@imgtec.com>,
        <david.daney@cavium.com>, <peterz@infradead.org>,
        <paul.gortmaker@windriver.com>, <davidlohr@hp.com>,
        <macro@linux-mips.org>, <chenhc@lemote.com>, <zajec5@gmail.com>,
        <james.hogan@imgtec.com>, <keescook@chromium.org>,
        <alex@alex-smith.me.uk>, <tglx@linutronix.de>,
        <blogic@openwrt.org>, <jchandra@broadcom.com>,
        <paul.burton@imgtec.com>, <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <markos.chandras@imgtec.com>, <manuel.lauss@gmail.com>,
        <akpm@linux-foundation.org>, <lars.persson@axis.com>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Fri, 3 Oct 2014 20:17:14 -0700
Message-ID: <20141004030438.28569.85536.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

The following series implements an executable stack protection in MIPS.

It sets up a per-thread 'VDSO' page and appropriate TLB support.
Page is set write-protected from user and is maintained via kernel VA.
MIPS FPU emulation is shifted to new page and stack is relieved for
execute protection as is as all data pages in default setup during ELF
binary initialization. The real protection is controlled by GLIBC and
it can do stack protected now as it is done in other architectures and
I learned today that GLIBC team is ready for this.

Note: actual execute-protection depends from HW capability, of course.

This patch is required for MIPS32/64 R2 emulation on MIPS R6 architecture.
Without it 'ssh-keygen' crashes pretty fast on attempt to execute instruction
in stack.
---

Leonid Yegoshin (3):
      MIPS: mips_flush_cache_range is added
      MIPS: Setup an instruction emulation in VDSO protected page instead of user stack
      MIPS: set stack/data protection as non-executable


 arch/mips/include/asm/cacheflush.h  |    3 +
 arch/mips/include/asm/mmu.h         |    2 +
 arch/mips/include/asm/page.h        |    2 -
 arch/mips/include/asm/processor.h   |    2 -
 arch/mips/include/asm/switch_to.h   |   12 ++++
 arch/mips/include/asm/thread_info.h |    3 +
 arch/mips/include/asm/tlbmisc.h     |    1 
 arch/mips/include/asm/vdso.h        |    2 +
 arch/mips/kernel/process.c          |    7 ++
 arch/mips/kernel/vdso.c             |   41 ++++++++++++-
 arch/mips/math-emu/dsemul.c         |  114 ++++++++++++++++++++++++++---------
 arch/mips/mm/c-octeon.c             |    8 ++
 arch/mips/mm/c-r3k.c                |    8 ++
 arch/mips/mm/c-r4k.c                |   43 +++++++++++++
 arch/mips/mm/c-tx39.c               |    9 +++
 arch/mips/mm/cache.c                |    4 +
 arch/mips/mm/fault.c                |    5 ++
 arch/mips/mm/tlb-r4k.c              |   39 ++++++++++++
 18 files changed, 273 insertions(+), 32 deletions(-)

-- 
Signature
