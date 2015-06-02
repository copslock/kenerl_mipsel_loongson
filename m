Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 09:59:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13071 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006788AbbFBH66yVH44 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 09:58:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AD430A19F196E;
        Tue,  2 Jun 2015 01:09:28 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 2 Jun
 2015 01:09:29 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 2 Jun
 2015 01:09:28 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 1 Jun 2015
 17:09:25 -0700
Subject: [PATCH 0/3] MIPS: SMP memory barriers: lightweight sync,
 acquire-release
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <benh@kernel.crashing.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <Steven.Hill@imgtec.com>,
        <alexander.h.duyck@redhat.com>, <davem@davemloft.net>
Date:   Mon, 1 Jun 2015 17:09:25 -0700
Message-ID: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47776
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

The following series implements lightweight SYNC memory barriers for SMP Linux
and a correct use of SYNCs around atomics, futexes, spinlocks etc LL-SC loops -
the basic building blocks of any atomics in MIPS.

Historically, a generic MIPS doesn't use memory barriers around LL-SC loops in
atomics, spinlocks etc. However, Architecture documents never specify that LL-SC
loop creates a memory barrier. Some non-generic MIPS vendors already feel
the pain and enforces it. With introduction in a recent out-of-order superscalar
MIPS processors an aggressive speculative memory read it is a problem now.

The generic MIPS memory barrier instruction SYNC (aka SYNC 0) is something
very heavvy because it was designed for propogating barrier down to memory.
MIPS R2 introduced lightweight SYNC instructions which correspond to smp_*()
set of SMP barriers. The description was very HW-specific and it was never
used, however, it is much less trouble for processor pipelines and can be used
in smp_mb()/smp_rmb()/smp_wmb() as is as in acquire/release barrier semantics.
After prolonged discussions with HW team it became clear that lightweight SYNCs
were designed specifically with smp_*() in mind but description is in timeline
ordering space.

So, the problem was spotted recently in engineering tests and it was confirmed
with tests that without memory barrier load and store may pass LL/SC
instructions in both directions, even in old MIPS R2 processors.
Aggressive speculation in MIPS R6 and MIPS I5600 processors adds more fire to
this issue.

3 patches introduces a configurable control for lightweight SYNCs around LL/SC
loops and for MIPS32 R2 it was allowed to choose an enforcing SYNCs or not
(keep as is) because some old MIPS32 R2 may be happy without that SYNCs.
In MIPS R6 I chose to have SYNC around LL/SC mandatory because all of that
processors have an agressive speculation and delayed write buffers. In that
processors series it is still possible the use of SYNC 0 instead of
lightweight SYNCs in configuration - just in case of some trouble in
implementation in specific CPU. However, it is considered safe do not implement
some or any lightweight SYNC in specific core because Architecture requires
HW map of unimplemented SYNCs to SYNC 0.

---

Leonid Yegoshin (3):
      MIPS: R6: Use lightweight SYNC instruction in smp_* memory barriers
      MIPS: enforce LL-SC loop enclosing with SYNC (ACQUIRE and RELEASE)
      MIPS: bugfix - replace smp_mb with release barrier function in unlocks


 arch/mips/Kconfig                |   47 ++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/barrier.h  |   32 +++++++++++++++++++++++---
 arch/mips/include/asm/bitops.h   |    2 +-
 arch/mips/include/asm/spinlock.h |    2 +-
 4 files changed, 77 insertions(+), 6 deletions(-)

--
Signature
