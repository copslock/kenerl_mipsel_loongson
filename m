Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:25:37 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:52202 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825756Ab2JaPUts3-1u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:20:49 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:20:41 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 14/20] MIPS: Use the UM bit instead of the CU0 enable bit in  the status register to figure out the stack for  saving regs.
Date:   Wed, 31 Oct 2012 11:20:37 -0400
Message-Id: <6BC12683-224F-4867-818C-FE4CF722B272@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34828
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/stackframe.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index cb41af5..59c9245 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -30,7 +30,7 @@
 #define STATMASK 0x1f
 #endif
 
-#ifdef CONFIG_MIPS_MT_SMTC
+#if defined(CONFIG_MIPS_MT_SMTC) || defined (CONFIG_MIPS_HW_FIBERS)
 #include <asm/mipsmtregs.h>
 #endif /* CONFIG_MIPS_MT_SMTC */
 
@@ -162,9 +162,9 @@
 		.set	noat
 		.set	reorder
 		mfc0	k0, CP0_STATUS
-		sll	k0, 3		/* extract cu0 bit */
+		andi    k0,k0,0x10 		/* check user mode bit*/
 		.set	noreorder
-		bltz	k0, 8f
+         beq     k0, $0, 8f
 		 move	k1, sp
 		.set	reorder
 		/* Called from user mode, new stack. */
-- 
1.7.11.3
