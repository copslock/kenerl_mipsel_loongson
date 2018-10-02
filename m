Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2018 13:50:20 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994599AbeJBLuLnL3lM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2018 13:50:11 +0200
Date:   Tue, 2 Oct 2018 12:50:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup'
 regression
In-Reply-To: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810020249480.20762@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Fix a commit 8a8158c85e1e ("MIPS: memset.S: EVA & fault support for 
small_memset") regression and remove assembly warnings:

arch/mips/lib/memset.S: Assembler messages:
arch/mips/lib/memset.S:243: Warning: Macro instruction expanded into multiple instructions in a branch delay slot

triggering with the CPU_DADDI_WORKAROUNDS option set and this code:

	PTR_SUBU	a2, t1, a0
	jr		ra
	 PTR_ADDIU	a2, 1

This is because with that option in place the DADDIU instruction, which 
the PTR_ADDIU CPP macro expands to, becomes a GAS macro, which in turn 
expands to an LI/DADDU (or actually ADDIU/DADDU) sequence:

 13c:	01a4302f 	dsubu	a2,t1,a0
 140:	03e00008 	jr	ra
 144:	24010001 	li	at,1
 148:	00c1302d 	daddu	a2,a2,at
	...

Correct this by switching off the `noreorder' assembly mode and letting 
GAS schedule this jump's delay slot, as there is nothing special about 
it that would require manual scheduling.  With this change in place 
correct code is produced:

 13c:	01a4302f 	dsubu	a2,t1,a0
 140:	24010001 	li	at,1
 144:	03e00008 	jr	ra
 148:	00c1302d 	daddu	a2,a2,at
	...

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 8a8158c85e1e ("MIPS: memset.S: EVA & fault support for small_memset")
Cc: stable@vger.kernel.org # 4.17+
---
 arch/mips/lib/memset.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

linux-mips-memset-jr-ra-nodaddi-fix.patch
Index: linux-20180930-3maxp-defconfig/arch/mips/lib/memset.S
===================================================================
--- linux-20180930-3maxp-defconfig.orig/arch/mips/lib/memset.S
+++ linux-20180930-3maxp-defconfig/arch/mips/lib/memset.S
@@ -280,9 +280,11 @@
 	 * unset_bytes = end_addr - current_addr + 1
 	 *      a2     =    t1    -      a0      + 1
 	 */
+	.set		reorder
 	PTR_SUBU	a2, t1, a0
+	PTR_ADDIU	a2, 1
 	jr		ra
-	 PTR_ADDIU	a2, 1
+	.set		noreorder
 
 	.endm
 
