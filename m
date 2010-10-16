Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 23:45:57 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:52848 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491753Ab0JPVoQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Oct 2010 23:44:16 +0200
Received: (qmail 13539 invoked from network); 16 Oct 2010 21:44:13 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Oct 2010 21:44:13 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 16 Oct 2010 14:44:13 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH resend 6/9] MIPS: pfn_valid() is broken on low memory HIGHMEM systems
Date:   Sat, 16 Oct 2010 14:22:35 -0700
Message-Id: <97b0445d9c40cccfec10b8aa12025b1a@localhost>
In-Reply-To: <17ebecce124618ddf83ec6fe8e526f93@localhost>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

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
