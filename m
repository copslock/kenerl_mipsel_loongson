Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Sep 2010 06:16:26 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:45053 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490963Ab0IGEQW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Sep 2010 06:16:22 +0200
Received: (qmail 5908 invoked from network); 7 Sep 2010 04:16:19 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 Sep 2010 04:16:19 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Mon, 06 Sep 2010 21:16:19 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 6 Sep 2010 21:03:48 -0700
Subject: [PATCH RESEND 3/5] MIPS: pfn_valid() is broken on low memory HIGHMEM systems
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Message-Id: <b4da0a0f45b83839973a64983e3feb89@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 27721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4957

pfn_valid() compares the PFN to max_mapnr:

        __pfn >= min_low_pfn && __pfn < max_mapnr;

On HIGHMEM kernels, highend_pfn is used to set the value of max_mapnr.
Unfortunately, highend_pfn is left at zero if the system does not
actually have enough RAM to reach into the HIGHMEM range.  This causes
pfn_valid() to always return false, and when debug checks are enabled
the kernel will fail catastrophically:

Memory: 22432k/32768k available (2249k kernel code, 10336k reserved, 653k data, 1352k init, 0k highmem)
NR_IRQS:128
kfree_debugcheck: out of range ptr 81c02900h.
Kernel bug detected[#1]:
Cpu 0
$ 0   : 00000000 10008400 00000034 00000000
$ 4   : 8003e160 802a0000 8003e160 00000000
$ 8   : 00000000 0000003e 00000747 00000747
...

On such a configuration, max_low_pfn should be used to set max_mapnr.

This was seen on 2.6.34.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 2efcbd2..18183a4 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -370,7 +370,7 @@ void __init mem_init(void)
 #ifdef CONFIG_DISCONTIGMEM
 #error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
 #endif
-	max_mapnr = highend_pfn;
+	max_mapnr = highend_pfn ? : max_low_pfn;
 #else
 	max_mapnr = max_low_pfn;
 #endif
-- 
1.7.0.4
