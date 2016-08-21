Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 21:59:17 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:49512 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992363AbcHUT6wZCzFn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Aug 2016 21:58:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u7LJwdEN023773
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 21 Aug 2016 12:58:39 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Sun, 21 Aug 2016 12:58:39 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/5] mips: audit and remove needless module.h use from core
Date:   Sun, 21 Aug 2016 15:58:12 -0400
Message-ID: <20160821195817.5802-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

Originally module.h provided support for both what was modular code and
what was providing support to modules via EXPORT_SYMBOL and friends.

That changed when we forked out support for the latter into the export.h
header; roughly five years ago[1].

We dealt with the immediate fallout of that change back then, but we
did not go through and "downgrade" all the non-modular module.h users
to export.h, once the merge of that change enabled us to do so.

This means we should be able to reduce the usage of module.h in code
that is obj-y Makefile or bool Kconfig.  In the case of some of these
which are modular, we can extend that to also include files that are
building basic support functionality but not related to loading or
registering the final module; such files also have no need whatsoever
for module.h

The advantage in removing such instances is that module.h itself
sources about 15 other headers; adding significantly to what we feed
cpp, and it can obscure what headers we are effectively using.

Consider the following pseudo patch to introduce a no-op source
that just includes module.h:

    diff --git a/init/Makefile b/init/Makefile
    --- a/init/Makefile
    +++ b/init/Makefile
    @@ -2,7 +2,7 @@

    -obj-y                          := main.o version.o mounts.o
    +obj-y                          := main.o version.o mounts.o foo.o

    diff --git a/init/foo.c b/init/foo.c
    new file mode 100644
    --- /dev/null
    +++ b/init/foo.c
    @@ -0,0 +1 @@
    +#include <linux/module.h>

With that in place, we then can see the impact with this:

   paul@builder:~/git/linux-head$ make O=../x86_64-build/ init/foo.i
   make[1]: Entering directory '/home/paul/git/x86_64-build'
     CPP     init/foo.i

   paul@builder:~/git/linux-head$ ls -lh ../x86_64-build/init/foo.i 
   -rw-rw-r-- 1 paul paul 754K Jul 12 20:04 ../x86_64-build/init/foo.i

So, with every module.h include, we guarantee a minimum of 3/4 of a MB
of text output from cpp as the baseline of header preamble to process.

Repeating the same experiment with <linux/init.h> and the result is less
than 12kB; with <linux/export.h> it is only about 1/2kB; with both it
still is less than 12kB.  Presumably the numbers are similar for !x86.

In this series we manage to remove about 40 includes of module.h that
just simply don't need to exist anymore in core MIPS files (kernel, lib,
pci, mm, kvm).

Since module.h might be the implicit source for init.h (for __init)
and for export.h (for EXPORT_SYMBOL) we consider each instance for the
requirement of either and replace as needed.  Some additional implicit
include issues were also fixed up as they appeared during build
coverage.

The series was done on a per directory level for the larger dirs and
then we will tackle the platform specific files in a subsequent series.
This seemed like a better solution than one giant commit that would not
get easily reviewed.

The risk here is entirely on introducing build failures -- there is
no changes to generated code, so if build coverage is exhaustive,
the risk should be zero.

To that end, I have done all[mod/no/yes]config, and each mips defconfig
(a couple aren't supported by my toolchain however) with these changes
on a recent linux-next tree.

Paul.

[1] https://lwn.net/Articles/453517/

---

Cc: James Hogan <james.hogan@imgtec.com>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>

Paul Gortmaker (5):
  mips/kernel: Audit and remove any unnecessary uses of module.h
  mips/mm: Audit and remove any unnecessary uses of module.h
  mips/lib: Audit and remove any unnecessary uses of module.h
  mips/pci: Audit and remove any unnecessary uses of module.h
  mips/kvm: Audit and remove any unnecessary uses of module.h

 arch/mips/kernel/binfmt_elfn32.c      | 8 +-------
 arch/mips/kernel/binfmt_elfo32.c      | 8 +-------
 arch/mips/kernel/branch.c             | 2 +-
 arch/mips/kernel/linux32.c            | 1 -
 arch/mips/kernel/mips-r2-to-r6-emul.c | 1 -
 arch/mips/kernel/smp.c                | 2 +-
 arch/mips/kvm/commpage.c              | 1 -
 arch/mips/kvm/dyntrans.c              | 1 -
 arch/mips/kvm/emulate.c               | 1 -
 arch/mips/kvm/interrupt.c             | 1 -
 arch/mips/kvm/trap_emul.c             | 1 -
 arch/mips/lib/ashldi3.c               | 2 +-
 arch/mips/lib/ashrdi3.c               | 2 +-
 arch/mips/lib/bswapdi.c               | 3 ++-
 arch/mips/lib/bswapsi.c               | 3 ++-
 arch/mips/lib/cmpdi2.c                | 2 +-
 arch/mips/lib/delay.c                 | 2 +-
 arch/mips/lib/iomap-pci.c             | 2 +-
 arch/mips/lib/iomap.c                 | 2 +-
 arch/mips/lib/lshrdi3.c               | 2 +-
 arch/mips/lib/ucmpdi2.c               | 2 +-
 arch/mips/mm/c-r4k.c                  | 2 +-
 arch/mips/mm/cache.c                  | 2 +-
 arch/mips/mm/dma-default.c            | 2 +-
 arch/mips/mm/fault.c                  | 1 -
 arch/mips/mm/highmem.c                | 3 ++-
 arch/mips/mm/init.c                   | 2 +-
 arch/mips/mm/ioremap.c                | 2 +-
 arch/mips/mm/mmap.c                   | 2 +-
 arch/mips/mm/page.c                   | 1 -
 arch/mips/mm/tlb-r4k.c                | 2 +-
 arch/mips/pci/pci-ar71xx.c            | 2 +-
 arch/mips/pci/pci-ar724x.c            | 2 +-
 arch/mips/pci/pci-lantiq.c            | 2 --
 arch/mips/pci/pci-mt7620.c            | 2 --
 arch/mips/pci/pci-rt2880.c            | 2 --
 arch/mips/pci/pci-rt3883.c            | 2 --
 arch/mips/pci/pcie-octeon.c           | 2 +-
 38 files changed, 28 insertions(+), 54 deletions(-)

-- 
2.8.4
