Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jun 2016 23:11:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35160 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27041626AbcFAVLZ4kfPI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Jun 2016 23:11:25 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u51LBNCb022754;
        Wed, 1 Jun 2016 23:11:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u51LBKQX022753;
        Wed, 1 Jun 2016 23:11:20 +0200
Date:   Wed, 1 Jun 2016 23:11:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org, Huacai Chen <chenhc@lemote.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Longson 3: Fix fast refill handler for 32 bit kernels
Message-ID: <20160601211120.GA16149@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

A recent merge has broken the LLVMLinux build for 32-bit little endian. I've
bisected it to 380cd58 and it looks like a bug in the kernel to me. Clang is
rejecting the inline assembly in the expansion of 'write_c0_kpgd
(swapper_pg_dir)' of tlbex.c. The relevant inline assembly can be found in
__write_64bit_c0_split() and is attempting to use the 'L' and 'M' print
modifiers on swapper_pg_dir which is a 32-bit unsigned long. These print
modifiers only make sense for 64-bit values so I think the kernel source is
incorrect.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Reported-by: Daniel Sanders <Daniel.Sanders@imgtec.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
---
I don't have Loongson 3 hardware for testing, could somebody of the Loongson
folks please review / test this?  Thanks!

 arch/mips/include/asm/mipsregs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e1ca65c..044fab6 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1652,8 +1652,8 @@ do {									\
 #define read_c0_pgd()		__read_64bit_c0_register($9, 7)
 #define write_c0_pgd(val)	__write_64bit_c0_register($9, 7, val)
 
-#define read_c0_kpgd()		__read_64bit_c0_register($31, 7)
-#define write_c0_kpgd(val)	__write_64bit_c0_register($31, 7, val)
+#define read_c0_kpgd()		__read_ulong_c0_register($31, 7)
+#define write_c0_kpgd(val)	__write_ulong_c0_register($31, 7, val)
 
 /* Cavium OCTEON (cnMIPS) */
 #define read_c0_cvmcount()	__read_ulong_c0_register($9, 6)
