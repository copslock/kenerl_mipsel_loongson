Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 14:04:28 +0100 (CET)
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:51711 "EHLO
        e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006861AbaKXNDouwh4u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 14:03:44 +0100
Received: from /spool/local
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 24 Nov 2014 13:03:39 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 24 Nov 2014 13:03:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5CBB72190070
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:03:09 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAOD3aIN16384482
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:03:36 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAOD3Yki008551
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 06:03:36 -0700
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAOD3Yk3008544;
        Mon, 24 Nov 2014 06:03:34 -0700
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 47DB01224439; Mon, 24 Nov 2014 14:03:34 +0100 (CET)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390"@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 0/7] ACCESS_ONCE and non-scalar accesses
Date:   Mon, 24 Nov 2014 14:03:23 +0100
Message-Id: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 1.9.3
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112413-0021-0000-0000-000001E3D22A
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

As discussed on LKML http://marc.info/?i=54611D86.4040306%40de.ibm.com
ACCESS_ONCE might fail with specific compiler for non-scalar accesses.

Here is a set of patches to tackle that problem. (The first patch
is already in kvm/next).
The last patch will force ACCESS_ONCE to error-out if it is used
on non-scalar accesses.
I have cross-compiled the resulting kernel with defconfig for
microblaze, m68k, alpha, s390,x86_64, i686, sparc, sparc64, mips,
ia64, arm and arm64.

So hopefully this patch set should be complete regarding the non-scalar
accesses. (As Linus pointed out, accesses > word size are a problem
on its own, but this patch set does not tackle this)

The result is also available as 0d199efcfc9875b8de17bb4fe1d87a27bd39a172
on
git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git ACCESS_ONCE

Now:
- It would be good to have the changes reviewed by component experts.
- It would also be good if architecture maintainers could double check, that
  "kernel: Force ACCESS_ONCE to work only on scalar types" does not break
  anything beyond defconfig.
- some comments about cc stable

Thanks

Christian
----------------------------------------------------------------
Christian Borntraeger (7):
      KVM: s390: Fix ipte locking
      mm: replace page table access via ACCESS_ONCE with barriers
      x86: Rework ACCESS_ONCE for spinlock code
      x86: Replace ACCESS_ONCE in gup with a barrier
      mips: Replace ACCESS_ONCE in gup with a barrier
      arm64: Replace ACCESS_ONCE for spinlock code with barriers
      kernel: Force ACCESS_ONCE to work only on scalar types

 arch/arm64/include/asm/spinlock.h |  7 +++++--
 arch/mips/mm/gup.c                |  6 ++++--
 arch/s390/kvm/gaccess.c           | 20 ++++++++++++++------
 arch/x86/include/asm/spinlock.h   | 14 +++++++++-----
 arch/x86/mm/gup.c                 |  7 +++++--
 include/linux/compiler.h          | 12 +++++++++++-
 mm/gup.c                          |  4 +++-
 mm/memory.c                       |  3 ++-
 mm/rmap.c                         |  3 ++-
 9 files changed, 55 insertions(+), 21 deletions(-)
