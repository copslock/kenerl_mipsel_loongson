Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 01:49:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55944 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012622AbbHEXtVUTdn1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 01:49:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9BC086381E463;
        Thu,  6 Aug 2015 00:49:10 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 00:49:14 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 6 Aug
 2015 00:49:14 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 5 Aug 2015
 16:49:11 -0700
Subject: [PATCH v4 0/3] MIPS executable stack protection
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <daniel.sanders@imgtec.com>, <linux-mips@linux-mips.org>,
        <cernekee@gmail.com>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <heiko.carstens@de.ibm.com>,
        <paul.gortmaker@windriver.com>, <behanw@converseincode.com>,
        <macro@linux-mips.org>, <cl@linux.com>, <pkarat@mvista.com>,
        <linux@roeck-us.net>, <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <luto@amacapital.net>, <dahi@linux.vnet.ibm.com>,
        <markos.chandras@imgtec.com>, <eunb.song@samsung.com>,
        <kumba@gentoo.org>
Date:   Wed, 5 Aug 2015 16:49:11 -0700
Message-ID: <20150805234348.20722.71740.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48628
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

v2 changes:
    - Added an optimization during mmap switch - doesn't switch if the same
      thread is rescheduled and other threads don't intervene (Peter Zijlstra)
    - Fixed uMIPS support (Paul Burton)
    - Added unwinding of VDSO emulation stack at signal handler invocation,
      hiding an emulation page (Andy Lutomirski note in other patch comments)

V3 change: heavy preemption friendly.

V4 changes:
    - Fixed bug in supplementary TLB flush (change KVA to user address space)
    - Rebased to 4.X kernel
---

Leonid Yegoshin (3):
      MIPS: mips_flush_cache_range is added
      MIPS: Setup an instruction emulation in VDSO protected page instead of user stack
      MIPS: set stack/data protection as non-executable


 arch/mips/include/asm/cacheflush.h    |    3 +
 arch/mips/include/asm/fpu_emulator.h  |    2 
 arch/mips/include/asm/mmu.h           |    3 +
 arch/mips/include/asm/page.h          |    2 
 arch/mips/include/asm/processor.h     |    2 
 arch/mips/include/asm/switch_to.h     |   14 +++
 arch/mips/include/asm/thread_info.h   |    3 +
 arch/mips/include/asm/tlbmisc.h       |    1 
 arch/mips/include/asm/vdso.h          |    3 +
 arch/mips/kernel/mips-r2-to-r6-emul.c |   10 +-
 arch/mips/kernel/process.c            |    7 ++
 arch/mips/kernel/signal.c             |    4 +
 arch/mips/kernel/vdso.c               |   44 +++++++++
 arch/mips/math-emu/cp1emu.c           |    8 +-
 arch/mips/math-emu/dsemul.c           |  154 +++++++++++++++++++++++++++------
 arch/mips/mm/c-octeon.c               |    8 ++
 arch/mips/mm/c-r3k.c                  |    8 ++
 arch/mips/mm/c-r4k.c                  |   43 +++++++++
 arch/mips/mm/c-tx39.c                 |    9 ++
 arch/mips/mm/cache.c                  |    4 +
 arch/mips/mm/fault.c                  |    5 +
 arch/mips/mm/tlb-r4k.c                |   42 +++++++++
 22 files changed, 343 insertions(+), 36 deletions(-)

--
Signature
