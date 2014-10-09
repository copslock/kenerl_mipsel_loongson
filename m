Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 22:00:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61767 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010997AbaJIUAM1sgOn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 22:00:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D50CA6F22C6DB;
        Thu,  9 Oct 2014 21:00:00 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 21:00:04 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 21:00:04 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 9 Oct 2014
 13:00:01 -0700
Subject: [PATCH v2 0/3] MIPS executable stack protection
To:     <linux-mips@linux-mips.org>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <paul.gortmaker@windriver.com>,
        <davidlohr@hp.com>, <macro@linux-mips.org>, <chenhc@lemote.com>,
        <richard@nod.at>, <zajec5@gmail.com>, <james.hogan@imgtec.com>,
        <keescook@chromium.org>, <alex@alex-smith.me.uk>,
        <tglx@linutronix.de>, <blogic@openwrt.org>,
        <jchandra@broadcom.com>, <paul.burton@imgtec.com>,
        <qais.yousef@imgtec.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <dengcheng.zhu@imgtec.com>, <manuel.lauss@gmail.com>,
        <akpm@linux-foundation.org>, <lars.persson@axis.com>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Thu, 9 Oct 2014 13:00:01 -0700
Message-ID: <20141009195030.31230.58695.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43159
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

---

Leonid Yegoshin (3):
      MIPS: mips_flush_cache_range is added
      MIPS: Setup an instruction emulation in VDSO protected page instead of user stack
      MIPS: set stack/data protection as non-executable


 arch/mips/include/asm/cacheflush.h   |    3 +
 arch/mips/include/asm/fpu_emulator.h |    2 
 arch/mips/include/asm/mmu.h          |    3 +
 arch/mips/include/asm/page.h         |    2 
 arch/mips/include/asm/processor.h    |    2 
 arch/mips/include/asm/switch_to.h    |   14 +++
 arch/mips/include/asm/thread_info.h  |    3 +
 arch/mips/include/asm/tlbmisc.h      |    1 
 arch/mips/include/asm/vdso.h         |    3 +
 arch/mips/kernel/process.c           |    7 ++
 arch/mips/kernel/signal.c            |    4 +
 arch/mips/kernel/vdso.c              |   41 +++++++++
 arch/mips/math-emu/cp1emu.c          |    8 +-
 arch/mips/math-emu/dsemul.c          |  153 ++++++++++++++++++++++++++++------
 arch/mips/mm/c-octeon.c              |    8 ++
 arch/mips/mm/c-r3k.c                 |    8 ++
 arch/mips/mm/c-r4k.c                 |   43 ++++++++++
 arch/mips/mm/c-tx39.c                |    9 ++
 arch/mips/mm/cache.c                 |    4 +
 arch/mips/mm/fault.c                 |    5 +
 arch/mips/mm/tlb-r4k.c               |   42 +++++++++
 21 files changed, 333 insertions(+), 32 deletions(-)

-- 
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
