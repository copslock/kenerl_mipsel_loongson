Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 21:34:05 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:49786 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026583AbbEHTeEPf05n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 21:34:04 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 4384A285F4;
        Fri,  8 May 2015 19:34:00 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id 30DCB285F0;
        Fri,  8 May 2015 19:34:00 +0000 (GMT)
Received: from bos-lp6ds.kendall.corp.akamai.com (bos-lp6ds.kendall.corp.akamai.com [172.28.13.70])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id 2B2ED2030;
        Fri,  8 May 2015 19:34:00 +0000 (GMT)
From:   Eric B Munson <emunson@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric B Munson <emunson@akamai.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 0/3] Allow user to request memory to be locked on page fault
Date:   Fri,  8 May 2015 15:33:43 -0400
Message-Id: <1431113626-19153-1-git-send-email-emunson@akamai.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emunson@akamai.com
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

mlock() allows a user to control page out of program memory, but this
comes at the cost of faulting in the entire mapping when it is
allocated.  For large mappings where the entire area is not necessary
this is not ideal.

This series introduces new flags for mmap() and mlockall() that allow a
user to specify that the covered are should not be paged out, but only
after the memory has been used the first time.

The performance cost of these patches are minimal on the two benchmarks
I have tested (stream and kernbench).

Avg throughput in MB/s from stream using 1000000 element arrays
Test     4.1-rc2      4.1-rc2+lock-on-fault
Copy:    10,979.08    10,917.34
Scale:   11,094.45    11,023.01
Add:     12,487.29    12,388.65
Triad:   12,505.77    12,418.78

Kernbench optimal load
                 4.1-rc2  4.1-rc2+lock-on-fault
Elapsed Time     71.046   71.324
User Time        62.117   62.352
System Time      8.926    8.969
Context Switches 14531.9  14542.5
Sleeps           14935.9  14939

Eric B Munson (3):
  Add flag to request pages are locked after page fault
  Add mlockall flag for locking pages on fault
  Add tests for lock on fault

 arch/alpha/include/uapi/asm/mman.h          |   2 +
 arch/mips/include/uapi/asm/mman.h           |   2 +
 arch/parisc/include/uapi/asm/mman.h         |   2 +
 arch/powerpc/include/uapi/asm/mman.h        |   2 +
 arch/sparc/include/uapi/asm/mman.h          |   2 +
 arch/tile/include/uapi/asm/mman.h           |   2 +
 arch/xtensa/include/uapi/asm/mman.h         |   2 +
 include/linux/mm.h                          |   1 +
 include/linux/mman.h                        |   3 +-
 include/uapi/asm-generic/mman.h             |   2 +
 mm/mlock.c                                  |  13 ++-
 mm/mmap.c                                   |   4 +-
 mm/swap.c                                   |   3 +-
 tools/testing/selftests/vm/Makefile         |   8 +-
 tools/testing/selftests/vm/lock-on-fault.c  | 145 ++++++++++++++++++++++++++++
 tools/testing/selftests/vm/on-fault-limit.c |  47 +++++++++
 tools/testing/selftests/vm/run_vmtests      |  23 +++++
 17 files changed, 254 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/vm/lock-on-fault.c
 create mode 100644 tools/testing/selftests/vm/on-fault-limit.c

Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-api@vger.kernel.org

-- 
1.9.1
