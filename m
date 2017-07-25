Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:24:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993970AbdGYTUoPakXn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:20:44 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D756CAF5;
        Tue, 25 Jul 2017 19:20:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 55/83] MIPS: Fix mips_atomic_set() with EVA
Date:   Tue, 25 Jul 2017 12:19:19 -0700
Message-Id: <20170725191717.049811516@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725191708.449126292@linuxfoundation.org>
References: <20170725191708.449126292@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/syscall.c |    7 +++++--
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
@@ -138,9 +139,11 @@ static inline int mips_atomic_set(unsign
 		__asm__ __volatile__ (
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
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
 		"	.insn						\n"
