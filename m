Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 14:55:52 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52376 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbdJIMzoTWTVY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2017 14:55:44 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQl-0004vA-Gv; Mon, 09 Oct 2017 13:45:12 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQP-0001zp-MQ; Mon, 09 Oct 2017 13:44:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Mon, 09 Oct 2017 13:44:24 +0100
Message-ID: <lsq.1507553064.816298483@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 059/192] MIPS: Fix mips_atomic_set() with EVA
In-Reply-To: <lsq.1507553063.449494954@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.49-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 4915e1b043d6286928207b1f6968197b50407294 upstream.

EVA linked loads (LLE) and conditional stores (SCE) should be used on
EVA kernels for the MIPS_ATOMIC_SET operation of the sysmips system
call, or else the atomic set will apply to the kernel view of the
virtual address space (potentially unmapped on EVA kernels) rather than
the user view (TLB mapped).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16151/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -28,6 +28,7 @@
 #include <linux/elf.h>
 
 #include <asm/asm.h>
+#include <asm/asm-eva.h>
 #include <asm/branch.h>
 #include <asm/cachectl.h>
 #include <asm/cacheflush.h>
@@ -137,9 +138,11 @@ static inline int mips_atomic_set(unsign
 		__asm__ __volatile__ (
 		"	.set	arch=r4000				\n"
 		"	li	%[err], 0				\n"
-		"1:	ll	%[old], (%[addr])			\n"
+		"1:							\n"
+		user_ll("%[old]", "(%[addr])")
 		"	move	%[tmp], %[new]				\n"
-		"2:	sc	%[tmp], (%[addr])			\n"
+		"2:							\n"
+		user_sc("%[tmp]", "(%[addr])")
 		"	beqz	%[tmp], 4f				\n"
 		"3:							\n"
 		"	.subsection 2					\n"
