Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 13:38:51 +0100 (CET)
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:48896 "EHLO
        e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006995AbaKYMitGL20o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 13:38:49 +0100
Received: from /spool/local
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Nov 2014 12:38:43 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 25 Nov 2014 12:38:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F5642190066
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:13 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPCceDA6554086
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:40 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAP7ZhaP016306
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 02:35:44 -0500
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAP7Zgwu016303;
        Tue, 25 Nov 2014 02:35:43 -0500
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 0151D1224439; Tue, 25 Nov 2014 13:38:38 +0100 (CET)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390"@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv2 00/10] ACCESS_ONCE and non-scalar accesses
Date:   Tue, 25 Nov 2014 13:38:27 +0100
Message-Id: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 1.9.3
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112512-0013-0000-0000-000001FADD22
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44432
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

Here is a set of patches to tackle that problem.

The first patch is already in kvm/next and this series is against rc3 (as
kvm/next so that we can avoid a merge conflict as soon as this series
has stabilized).
The 2nd patch introduces READ_ONCE/ASSIGN_ONCE as suggested by Linus.
The 2nd to last patch will force ACCESS_ONCE to error-out if it is used
on non-scalar accesses.

I have cross-compiled the resulting kernel with defconfig for
microblaze, m68k, alpha, s390,x86_64, i686, sparc, sparc64, mips,
ia64, arm and arm64.
Will Deacon pointed me to the right defconfig for arm32 to also trigger
a finding here.
Runtime testing was only done on s390x.

There is a small problem left with sparc (32bit) and m68k:

mm/rmap.c: In function 'mm_find_pmd':
include/linux/compiler.h:220:72: warning: '__val' may be used uninitialized in this function [-Wmaybe-uninitialized]
       ({ typeof(p) __val; __read_once_size(&p, &__val, sizeof(__val)); __val; })
                                                                        ^
include/linux/compiler.h:220:20: note: '__val' was declared here
       ({ typeof(p) __val; __read_once_size(&p, &__val, sizeof(__val)); __val; })
                    ^
mm/rmap.c:584:9: note: in expansion of macro 'READ_ONCE'
  pmde = READ_ONCE(*pmd);

Reason is that for both architectures pmd_t is long[16]. WTF?

So the next spin will either fix m68k/sparc or use a barrier + ACCESS_ONCE.

Comments?

Christian Borntraeger (10):
  KVM: s390: Fix ipte locking
  kernel: Provide READ_ONCE and ASSIGN_ONCE
  mm: replace ACCESS_ONCE with READ_ONCE
  x86/spinlock: Replace ACCESS_ONCE with READ_ONCE/ASSIGN_ONCE
  x86: Replace ACCESS_ONCE in gup with READ_ONCE
  mips: Replace ACCESS_ONCE in gup with READ_ONCE
  arm64: Replace ACCESS_ONCE for spinlock code with READ_ONCE
  arm: Replace ACCESS_ONCE for spinlock code with READ_ONCE
  tighten rules for ACCESS ONCE
  KVM: s390: change ipte lock from barrier to READ_ONCE

 arch/arm/include/asm/spinlock.h   |  4 ++--
 arch/arm64/include/asm/spinlock.h |  4 ++--
 arch/mips/mm/gup.c                |  2 +-
 arch/s390/kvm/gaccess.c           | 14 +++++++------
 arch/x86/include/asm/spinlock.h   |  8 +++----
 arch/x86/mm/gup.c                 |  2 +-
 include/linux/compiler.h          | 44 ++++++++++++++++++++++++++++++++++++++-
 mm/gup.c                          |  2 +-
 mm/memory.c                       |  2 +-
 mm/rmap.c                         |  2 +-
 10 files changed, 64 insertions(+), 20 deletions(-)
