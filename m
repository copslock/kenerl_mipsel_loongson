Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2016 00:07:46 +0200 (CEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:41910 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992227AbcHVWHjZJ6l4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2016 00:07:39 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id EBF742342CA;
        Tue, 23 Aug 2016 01:07:37 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Alex Smith <alex.smith@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: mangle-port: fix build failure with VDSO code
Date:   Tue, 23 Aug 2016 01:07:35 +0300
Message-Id: <20160822220735.13865-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Commit 1685ddbe35cd ("MIPS: Octeon: Changes to support readq()/writeq()
usage.") added bitwise shift operations that assume that unsigned long
is always 64-bits. This broke the build of VDSO code, as it gets compiled
also in "faked" 32-bit mode. Althought the failing inline functions are
never executed in 32-bit mode, they still need to pass the compilation.
Fix by using 64-bit types explicitly.

The patch fixes the following build failure:

  CC      arch/mips/vdso/gettimeofday-o32.o
In file included from los/git/devel/linux/arch/mips/include/asm/io.h:32:0,
                 from los/git/devel/linux/arch/mips/include/asm/page.h:194,
                 from los/git/devel/linux/arch/mips/vdso/vdso.h:26,
                 from los/git/devel/linux/arch/mips/vdso/gettimeofday.c:11:
los/git/devel/linux/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h: In function '__should_swizzle_bits':
los/git/devel/linux/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift-count-overflow]
  unsigned long did = ((unsigned long)a >> 40) & 0xff;
                                        ^~

Fixes: 1685ddbe35cd ("MIPS: Octeon: Changes to support readq()/writeq() usage.")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/asm/mach-cavium-octeon/mangle-port.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h b/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
index 0cf5ac1..8ff2cbd 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
@@ -15,8 +15,8 @@
 static inline bool __should_swizzle_bits(volatile void *a)
 {
 	extern const bool octeon_should_swizzle_table[];
+	u64 did = ((u64)(uintptr_t)a >> 40) & 0xff;
 
-	unsigned long did = ((unsigned long)a >> 40) & 0xff;
 	return octeon_should_swizzle_table[did];
 }
 
@@ -29,7 +29,7 @@ static inline bool __should_swizzle_bits(volatile void *a)
 
 #define __should_swizzle_bits(a)	false
 
-static inline bool __should_swizzle_addr(unsigned long p)
+static inline bool __should_swizzle_addr(u64 p)
 {
 	/* boot bus? */
 	return ((p >> 40) & 0xff) == 0;
-- 
2.9.2
