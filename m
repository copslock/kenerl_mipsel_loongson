Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 17:20:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44204 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbdEaPUFAno0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 17:20:05 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3FB8041757C82;
        Wed, 31 May 2017 16:19:55 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 May 2017 16:19:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 0/4] MIPS: sysmips(MIPS_ATOMIC_SET, ...) fixes
Date:   Wed, 31 May 2017 16:19:46 +0100
Message-ID: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

These patches fix a few issues with the sysmips(MIPS_ATOMIC_SET, ...)
system call. This system call is pretty much deprecated and no longer
used by glibc, however it is still provided for compatibility so we
should keep it working.

Patch 1 fixes a longstanding broken atomic retry condition which results
in the loop retrying until the the operation was *NOT* atomic:
- The new (instead of old) value will usually be returned.
- If the operation fails first time it won't be repeated (otherwise
  it'll repeat until it does fail, which is slow).

Patch 2 fixes a similarly longstanding clobbering of callee saved
registers in the common path, which tends to crash userland soon
afterwards.

Patch 3 fixes an EVA specific issue where normal LL/SC instructions are
used instead of the EVA specific LLE/SCE instructions.

Finally patch 4 simplifies the assembly slightly to avoid the apparently
redundant branch via a subsection. If anybody knows why this was there
and whether it is still needed I'm all ears. This is the only patch not
tagged for stable.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org

James Hogan (4):
  MIPS: Fix mips_atomic_set() retry condition
  MIPS: Save static registers before sysmips
  MIPS: Fix mips_atomic_set() with EVA
  MIPS: Branch straight to ll in mips_atomic_set()

 arch/mips/kernel/scall32-o32.S |  2 +-
 arch/mips/kernel/scall64-64.S  |  2 +-
 arch/mips/kernel/scall64-n32.S |  2 +-
 arch/mips/kernel/scall64-o32.S |  2 +-
 arch/mips/kernel/syscall.c     | 19 ++++++++++++-------
 5 files changed, 16 insertions(+), 11 deletions(-)

-- 
git-series 0.8.10
